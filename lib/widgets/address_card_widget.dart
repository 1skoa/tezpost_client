import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tezpost_client/models/address_model.dart';
import 'package:tezpost_client/widgets/map_view.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final geo = address.geo;
    final hasGeo = geo != null && geo['lat'] != null && geo['lng'] != null;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
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
          if (hasGeo) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: MapView(
                    latitude: geo['lat']!,
                    longitude: geo['lng']!,
                    height: 160, // маленькая карта в карточке
                  ),

                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text("Tezpost Cargo")),
                      body: SafeArea(
                        child: MapView(
                          latitude: geo['lat']!,
                          longitude: geo['lng']!,
                        ),
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.fullscreen),
              label: const Text('Открыть на весь экран'),
            ),

            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
