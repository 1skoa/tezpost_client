import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tezpost_client/models/order_model.dart';
import 'package:tezpost_client/models/price_model.dart';
import 'package:tezpost_client/utils/urls.dart';

import '../models/address_model.dart';


class ApiService {
  static Future<OrderModel?> fetchOrderByTrackCode(String trackCode) async {
    final url = Uri.parse('${ApiUrls.findOrder}?data=$trackCode');

    final response = await http.get(url);

    print('🔍 Запрос: $url');
    print('📦 Статус: ${response.statusCode}');
    print('📨 Ответ: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return OrderModel.fromJson(data);
    } else {
      return null;
    }
  }

  static Future<List<PriceModel>> fetchPrices(int shippingId) async {
    final url = Uri.parse("${ApiUrls.prices}?shipping_id=$shippingId");

    final response = await http.get(url);

    print('🔍 Запрос: $url');
    print('📦 Статус: ${response.statusCode}');
    print('📨 Ответ: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => PriceModel.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка загрузки цен');
    }
  }

  static Future<List<AddressModel>> fetchAddressesByShippingId(int shippingId) async {
    final url = Uri.parse("${ApiUrls.addresses}?shipping_id=$shippingId");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Api-Key': '42386e60-dea6-4610-ae4c-22ddaa2e9fc7',
      },
    );

    print('🔍 Запрос: $url');
    print('📦 Статус: ${response.statusCode}');
    print('📨 Ответ: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => AddressModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load addresses');
    }
  }

}
