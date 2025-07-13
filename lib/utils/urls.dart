class ApiUrls {
  static const String baseUrl = "https://test-api.tezpost.ru/api";
  static const String profile = "$baseUrl/auth/user";
  static const String getOrders = "$baseUrl/profile/get-orders";
  static const String findOrder = "$baseUrl/profile/find-order";
  static const String prices = "$baseUrl/prices";
  static const String addresses = "$baseUrl/addresses";
  static const String sendCode = "$baseUrl/auth/send-sms";
  static const String confirmCode = "$baseUrl/auth/number-check";
  static const String deleteOrder = "$baseUrl/profile/delete-order";
}
