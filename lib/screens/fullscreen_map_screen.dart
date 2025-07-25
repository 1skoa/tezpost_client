import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const FullMapScreen({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tezpost Cargo')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 17,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('full_map_marker'),
            position: LatLng(latitude, longitude),
          ),
        },
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}
