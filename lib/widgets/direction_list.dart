import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';
import 'direction_card.dart';

class DirectionList extends StatelessWidget {
  const DirectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeController, (int, Map<int, String>)>(
      selector: (_, c) => (c.selectedShippingId, c.directions),
      builder: (_, tuple, __) {
        final (selectedId, directions) = tuple;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Column(
          children: directions.entries.map((e) {
            final isSelected = e.key == selectedId;
            return DirectionCard(
              directionId: e.key,
              directionName: e.value,
              isSelected: isSelected,
              isDark: isDark,
            );
          }).toList(),
        );
      },
    );
  }
}