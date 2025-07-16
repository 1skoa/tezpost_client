import 'package:flutter/material.dart';
import 'package:tezpost_client/widgets/address_card_widget.dart';
import 'package:tezpost_client/widgets/price_card_widget.dart';

class DirectionCard extends StatefulWidget {
  final int directionId;
  final String directionName;
  final bool isSelected;
  final bool isDark;
  final List<dynamic> prices;
  final List<dynamic> addresses;

  const DirectionCard({
    super.key,
    required this.directionId,
    required this.directionName,
    required this.isSelected,
    required this.isDark,
    required this.prices,
    required this.addresses,
  });

  @override
  _DirectionCardState createState() => _DirectionCardState();
}

class _DirectionCardState extends State<DirectionCard> {
  bool _addressesExpanded = true;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark ? Colors.deepOrange.shade300 : Colors.deepOrange;
    final secondaryTextColor = widget.isDark ? Colors.white54 : Colors.black54;
    final bgColor = widget.isDark ? Colors.grey[850] : Colors.white;

    final borderColor = _addressesExpanded ? primaryColor : Colors.grey.shade300;
    final borderWidth = _addressesExpanded ? 2.0 : 1.0;

    final boxShadow = [
      BoxShadow(
        color: widget.isDark
            ? (_addressesExpanded ? primaryColor.withOpacity(0.4) : Colors.black45)
            : (_addressesExpanded ? primaryColor.withOpacity(0.3) : Colors.grey.withOpacity(0.1)),
        blurRadius: _addressesExpanded ? 12 : 6,
        offset: const Offset(0, 4),
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок с иконкой слева
            Row(
              children: [
                Icon(Icons.place_outlined, color: primaryColor, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.directionName,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (widget.prices.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.prices.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => SizedBox(
                    width: 160,
                    child: PriceCard(price: widget.prices[i]),
                  ),
                ),
              ),

            if (widget.prices.isNotEmpty) const SizedBox(height: 20),

            if (widget.addresses.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => setState(() => _addressesExpanded = !_addressesExpanded),
                    child: Row(
                      children: [
                        Text(
                          'Показать',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          _addressesExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: secondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: widget.addresses
                          .map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AddressCard(address: a),
                      ))
                          .toList(),
                    ),
                    crossFadeState: _addressesExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
  }