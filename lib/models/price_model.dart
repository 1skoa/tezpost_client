class PriceModel {
  final int id;
  final double priceKg;
  final double priceCub;
  final int directionId;
  final String directionName;
  final int shippingId;

  PriceModel({
    required this.id,
    required this.priceKg,
    required this.priceCub,
    required this.directionId,
    required this.directionName,
    required this.shippingId,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      id: json['id'],
      priceKg: (json['price_kg'] is int) ? (json['price_kg'] as int).toDouble() : json['price_kg'],
      priceCub: (json['price_cub'] is int) ? (json['price_cub'] as int).toDouble() : json['price_cub'],
      directionId: json['direction_id'],
      directionName: json['direction'] != null ? json['direction']['name'] ?? '' : '',
        shippingId: json['shipping_id'],
    );
  }
}
