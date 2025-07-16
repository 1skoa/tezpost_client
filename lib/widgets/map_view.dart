import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double? height;

  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final mapWidget = GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('warehouse'),
          position: LatLng(latitude, longitude),
        ),
      },
      zoomControlsEnabled: true,
      myLocationEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,
    );

    return height != null
        ? SizedBox(height: height, child: mapWidget)
        : mapWidget;
  }
}
