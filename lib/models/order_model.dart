class OrderModel {
  final int id;
  final String? trackCode;
  final String? weight;
  final int? length;
  final int? width;
  final int? height;
  final String? image;
  final String? statusName;
  final String? directionName;
  final String? shippingName;
  final String? createdAt;

  OrderModel({
    required this.id,
    this.trackCode,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.image,
    this.statusName,
    this.directionName,
    this.shippingName,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final order = json['order'];
    return OrderModel(
      id: order['id'],
      trackCode: order['track_code'],
      weight: order['weight'],
      length: order['length'],
      width: order['width'],
      height: order['height'],
      image: order['image'],
      statusName: order['status']?['name'],
      directionName: order['direction']?['name'],
      shippingName: order['shipping']?['name'],
      createdAt: order['created_at'],

    );
  }
}