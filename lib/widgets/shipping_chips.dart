import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';

class ShippingChips extends StatelessWidget {
  final int selectedId;
  final ValueChanged<int> onChanged;

  const ShippingChips({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ShippingChip(label: 'Авиа', id: 1, selectedId: selectedId, onChanged: onChanged),
        const SizedBox(width: 8),
        _ShippingChip(label: 'Авто', id: 2, selectedId: selectedId, onChanged: onChanged),
      ],
    );
  }
}

class _ShippingChip extends StatelessWidget {
  final String label;
  final int id;
  final int selectedId;
  final ValueChanged<int> onChanged;

  const _ShippingChip({
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
