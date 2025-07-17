class OperatorModel {
  final int id;
  final String phone;
  final String name;
  final String? telegramUsername;

  OperatorModel({
    required this.id,
    required this.phone,
    required this.name,
    this.telegramUsername,
  });

  factory OperatorModel.fromJson(Map<String, dynamic> json) {
    return OperatorModel(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      telegramUsername: json['telegram_username'],
    );
  }
}
