import 'package:flutter/material.dart';
import 'package:tezpost_client/models/price_model.dart';
import 'package:tezpost_client/utils/constants.dart';

class PriceCard extends StatelessWidget {
  final PriceModel price;

  const PriceCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final directionName = staticDirections[price.directionId] ?? 'Неизвестно';

    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final cardColor = isDark ? Colors.grey[800] : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Название города
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.deepOrange, size: 20),
              const SizedBox(width: 6),
              Text(
                directionName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Цена за кг
          Row(
            children: [
              const Icon(Icons.scale, size: 18, color: Colors.green),
              const SizedBox(width: 6),
              Text(
                'Цена за 1 кг:',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: subTextColor,
                    fontSize: 15
                ),
              ),
              const Spacer(),
              Text(
                '${price.priceKg.toStringAsFixed(2)} \$',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: 15
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Цена за куб
          Row(
            children: [
              const Icon(Icons.square_foot_outlined, size: 18, color: Colors.blue),
              const SizedBox(width: 6),
              Text(
                'Цена за 1 куб:',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: subTextColor,
                    fontSize: 15
                ),
              ),
              const Spacer(),
              Text(
                '${price.priceCub.toStringAsFixed(2)} \$',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontSize: 15
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
