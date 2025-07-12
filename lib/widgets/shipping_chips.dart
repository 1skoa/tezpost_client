import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/home_controller.dart';

class ShippingChips extends StatelessWidget {
  const ShippingChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _ShippingChip(label: 'Авиа', id: 1),
        SizedBox(width: 8),
        _ShippingChip(label: 'Авто', id: 2),
      ],
    );
  }
}

class _ShippingChip extends StatelessWidget {
  final String label;
  final int id;

  const _ShippingChip({required this.label, required this.id});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeController, bool>(
      selector: (_, c) => c.selectedShippingId == id,
      builder: (_, selected, __) => ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => context.read<HomeController>().changeShipping(id),
      ),
    );
  }
}