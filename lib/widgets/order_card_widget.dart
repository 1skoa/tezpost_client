import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/models/order_model.dart';
import 'package:tezpost_client/providers/theme_provider.dart';
import 'package:tezpost_client/widgets/delivery_progress_widget.dart';
import '../theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.themeMode == ThemeMode.dark;
        final colorScheme = Theme.of(context).colorScheme;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 12),
          color: colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (order.image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radius),
                    child: Image.network(
                      order.image!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 12),
                Text('Трек-код: ${order.trackCode}'),
                Text('Вес: ${order.weight ?? "-"} кг'),
                Text('Габариты: ${order.length} x ${order.width} x ${order.height} см'),
                if (order.statusName != null) Text('Статус: ${order.statusName}'),
                if (order.directionName != null) Text('Направление: ${order.directionName}'),
                if (order.shippingName != null) Text('Тип доставки: ${order.shippingName}'),
                if (order.createdAt != null) Text('Дата: ${order.createdAt}'),
                const SizedBox(height: 16),
                DeliveryProgressWidget(currentStatusName: order.statusName ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}

