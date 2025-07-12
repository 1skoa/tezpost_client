class MyOrderModel {
  final int id;
  final String trackCode;
  final String weight;
  final int length;
  final int width;
  final int height;
  final String statusName;
  final String shippingName;
  final String createdAt;
  final String? image;

  MyOrderModel({
    required this.id,
    required this.trackCode,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.image,
    required this.statusName,
    required this.shippingName,
    required this.createdAt,
  });

  factory MyOrderModel.fromJson(Map<String, dynamic> json) {
    return MyOrderModel(
      id: json['id'],
      trackCode: json['track_code'] ?? '',
      weight: json['weight']?.toString() ?? '0',
      length: (json['length'] as num?)?.toInt() ?? 0,
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
      statusName: json['status']?['name'] ?? 'Неизвестно',
      shippingName: json['shipping']?['name'] ?? 'Неизвестно',
      createdAt: json['created_at'] ?? '',
      image: json['image'],
    );
  }

}
