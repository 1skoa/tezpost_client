import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezpost_client/controllers/order_controller.dart';
import 'package:tezpost_client/models/my_order_model.dart';
import 'package:tezpost_client/providers/theme_provider.dart';
import 'package:tezpost_client/theme/app_theme.dart';
import 'package:tezpost_client/utils/urls.dart';
import 'package:tezpost_client/widgets/delivery_progress_widget.dart';
import 'package:tezpost_client/widgets/fullscreen_image_viewer.dart';
import 'package:tezpost_client/widgets/guest_view_widget.dart';

import 'main_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersController controller = OrdersController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedStatus = 'Все';

  late Future<List<MyOrderModel>?> _futureOrders;
  final List<String> _statusOptions = [
    'Все',
    'Прием заказа',
    'Готов к отправке',
    'В пути',
    'В ожидании выдачи',
    'Оплачен',
  ];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    _futureOrders = controller.fetchOrders(context);
  }

  ThemeMode? _lastThemeMode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (_lastThemeMode != themeProvider.themeMode) {
      _lastThemeMode = themeProvider.themeMode;
      _loadOrders();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
        centerTitle: true,
      ),
      body: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return FutureBuilder<List<MyOrderModel>?>(
            future: _futureOrders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Ошибка загрузки: ${snapshot.error}'));
              }

              final orders = snapshot.data;

              if (orders == null) return const GuestViewWidget();
              if (orders.isEmpty) return const Center(child: Text('Заказы не найдены'));

              final filteredOrders = orders.where((order) {
                final query = _searchQuery.toLowerCase();
                final matchesSearch = order.trackCode.toLowerCase().contains(query) ||
                    order.shippingName.toLowerCase().contains(query);
                final matchesStatus =
                    _selectedStatus == 'Все' || order.statusName == _selectedStatus;
                return matchesSearch && matchesStatus;
              }).toList();

              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _loadOrders();
                  });
                  await _futureOrders;
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                              : null,
                          hintText: 'Поиск по трек-коду, доставке...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.trim();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        items: _statusOptions
                            .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Фильтр по статусу',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: filteredOrders.isEmpty
                          ? const Center(child: Text('Нет совпадений'))
                          : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredOrders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return Card(
                            key: ValueKey(themeProvider.themeMode),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                            color: Theme.of(context).colorScheme.surface,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (order.image != null) ...[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => FullscreenImageViewer(
                                                imageUrl: order.image!),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          order.image!,
                                          height: 160,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                          const SizedBox.shrink(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  Text(
                                    'Трек-код: ${order.trackCode}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('Вес: ${order.weight} кг'),
                                  Text(
                                      'Размеры: ${order.length} x ${order.width} x ${order.height} см'),
                                  Text('Статус: ${order.statusName}'),
                                  Text('Доставка: ${order.shippingName}'),
                                  Text('Дата: ${order.createdAt}'),
                                  const SizedBox(height: 16),
                                  DeliveryProgressWidget(
                                      currentStatusName: order.statusName),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
