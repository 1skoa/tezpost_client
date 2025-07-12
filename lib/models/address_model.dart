class AddressModel {
  final int id;
  final String name;
  final int directionId;
  final int shippingId;

  AddressModel({
    required this.id,
    required this.name,
    required this.directionId,
    required this.shippingId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      name: json['name'],
      directionId: json['direction_id'],
      shippingId: json['shipping_id'],
    );
  }
}
