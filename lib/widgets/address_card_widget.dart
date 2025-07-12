import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tezpost_client/models/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(
          address.name,
          style: theme.textTheme.bodySmall?.copyWith(fontSize: 13),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.copy, size: 18),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: address.name));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Адрес скопирован')),
            );
          },
        ),
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

    );
  }
}
