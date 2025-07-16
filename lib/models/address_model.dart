class AddressModel {
  final int id;
  final String name;
  final int directionId;
  final int shippingId;
  final Map<String, double>? geo; // карта с double значениями

  AddressModel({
    required this.id,
    required this.name,
    required this.directionId,
    required this.shippingId,
    this.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    Map<String, double>? geoMap;

    if (json['geo'] != null) {
      final geoString = json['geo'] as String;
      // Ожидается формат: "lat, lng"
      final parts = geoString.split(',');
      if (parts.length == 2) {
        final lat = double.tryParse(parts[0].trim());
        final lng = double.tryParse(parts[1].trim());
        if (lat != null && lng != null) {
          geoMap = {
            'lat': lat,
            'lng': lng,
          };
        }
      }
    }

    return AddressModel(
      id: json['id'],
      name: json['name'],
      directionId: json['direction_id'],
      shippingId: json['shipping_id'],
      geo: geoMap,
    );
  }
}
