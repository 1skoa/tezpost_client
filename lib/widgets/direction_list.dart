import 'package:flutter/material.dart';
import 'direction_card.dart';

class DirectionList extends StatelessWidget {
  final int selectedId;
  final Map<int, String> directions;
  final Map<int, List<dynamic>> pricesMap;
  final Map<int, List<dynamic>> addressesMap;
  final bool isDark;

  const DirectionList({
    super.key,
    required this.selectedId,
    required this.directions,
    required this.pricesMap,
    required this.addressesMap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: directions.entries.map((e) {
        return DirectionCard(
          directionId: e.key,
          directionName: e.value,
          isSelected: e.key == selectedId,
          isDark: isDark,
          prices: pricesMap[e.key] ?? [],
          addresses: addressesMap[e.key] ?? [],
        );
      }).toList(),
    );
  }
}
