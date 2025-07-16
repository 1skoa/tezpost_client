import 'package:flutter/material.dart';
import 'package:tezpost_client/api/api_service.dart';
import 'package:tezpost_client/utils/constants.dart';
import 'package:tezpost_client/widgets/city_chips.dart';
import 'package:tezpost_client/widgets/direction_list.dart';
import 'package:tezpost_client/widgets/map_view.dart';
import 'package:tezpost_client/widgets/shipping_chips.dart';

class WarehouseTjAddressScreen extends StatefulWidget {
  const WarehouseTjAddressScreen({super.key});

  @override
  State<WarehouseTjAddressScreen> createState() => _WarehouseTjAddressScreen();
}

class _WarehouseTjAddressScreen extends State<WarehouseTjAddressScreen> {
  int selectedId = 4;
  bool isCity = true;
  Map<int, String> directions = {};
  Map<int, List<dynamic>> pricesMap = {};
  Map<int, List<dynamic>> addressesMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData(selectedId, isCity);
  }
  Future<void> _fetchData(int cityId, city) async {
    setState(() => isLoading = true);
    try {
      final addresses = await ApiService.fetchAddressesByShippingId(cityId, city);

      final grouped = _groupByDirection(addresses);
      final newDirections = <int, String>{};

      for (var dirId in grouped.keys) {
        newDirections[dirId] = staticDirections[dirId] ?? 'Неизвестно';
      }
      setState(() {
        addressesMap = grouped;
        directions = newDirections;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Ошибка загрузки адресов: $e');
    }
  }
  Map<int, List<dynamic>> _groupByDirection(List<dynamic> addresses) {
    final map = <int, List<dynamic>>{};
    for (var addr in addresses) {
      final int directionId = addr.directionId;
      map.putIfAbsent(directionId, () => []).add(addr);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              CityChips(
                selectedId: selectedId,
                onChanged: (id) {
                  setState(() {
                    selectedId = id;
                  });
                  _fetchData(id, isCity);
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Адреса складов',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: DirectionList(
                    selectedId: selectedId,
                    directions: directions,
                    pricesMap: pricesMap,
                    addressesMap: addressesMap,
                    isDark: isDark,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
