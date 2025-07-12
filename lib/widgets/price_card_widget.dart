import 'package:flutter/material.dart';
import 'package:tezpost_client/models/price_model.dart';

class PriceCard extends StatelessWidget {
  final PriceModel price;

  const PriceCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Цена за кг: ${price.priceKg} \$',
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              'Цена за куб: ${price.priceCub} \$',
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
