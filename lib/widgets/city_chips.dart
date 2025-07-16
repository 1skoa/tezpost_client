import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';

class CityChips extends StatelessWidget {
  final int selectedId;
  final ValueChanged<int> onChanged;

  const CityChips({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CityChips(label: 'Душанбе', id: 4, selectedId: selectedId, onChanged: onChanged),
        const SizedBox(width: 8),
        _CityChips(label: 'Худжанд', id: 5, selectedId: selectedId, onChanged: onChanged),
      ],
    );
  }
}

class _CityChips extends StatelessWidget {
  final String label;
  final int id;
  final int selectedId;
  final ValueChanged<int> onChanged;

  const _CityChips({
    required this.label,
    required this.id,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedId == id,
      onSelected: (_) => onChanged(id),
    );
  }
}
