import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';
import 'package:tezpost_client/widgets/address_card_widget.dart';
import 'package:tezpost_client/widgets/price_card_widget.dart';

class DirectionCard extends StatelessWidget {
  final int directionId;
  final String directionName;
  final bool isDark;

  const DirectionCard({
    super.key,
    required this.directionId,
    required this.directionName,
    required this.isDark, required bool isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF49362A) : const Color(0xFFFFD2B4);
    final borderColor =
    isDark ? Colors.grey.shade700 : Colors.grey.withOpacity(0.1);
    final iconColor = isDark ? Colors.orange.shade300 : Colors.orange;
    final addressIconColor =
    isDark ? Colors.blueGrey.shade300 : Colors.blueGrey;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      Icon(
                          Icons.location_on_outlined,
                          color: iconColor, size: 20
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          directionName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Prices
                  Selector<HomeController, List<dynamic>>(
                    selector: (_, c) => c.getPricesByDirection(directionId),
                    builder: (_, prices, __) {
                      return Column(
                        children: prices
                            .map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: PriceCard(price: p),
                        ))
                            .toList(),
                      );
                    },
                  ),

                  // Addresses
                  Selector<HomeController, List<dynamic>>(
                    selector: (_, c) => c.getAddressesByDirection(directionId),
                    builder: (_, addresses, __) {
                      if (addresses.isEmpty) return const SizedBox.shrink();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 24),
                          Row(
                            children: [
                              Icon(Icons.store_mall_directory_outlined,
                                  size: 18, color: addressIconColor
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Адреса выдачи',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...addresses.map(
                                (a) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: AddressCard(address: a),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // RIGHT IMAGE
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(12),
            //   child: Image.asset(
            //     'assets/images/great_w.png',
            //     width: 50,
            //     height: 300,
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
