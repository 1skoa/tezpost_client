import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezpost_client/models/my_order_model.dart';
import 'package:tezpost_client/utils/urls.dart';
import 'package:tezpost_client/widgets/network_error_dialog.dart';

class OrdersController {
  Future<List<MyOrderModel>?> fetchOrders(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;

    try {
      final response = await http.get(
        Uri.parse(ApiUrls.getOrders),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List ordersJson = data['orders'] ?? [];
        return ordersJson.map((json) => MyOrderModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        return null;
      } else {
        throw Exception('Ошибка загрузки заказов');
      }
    } on SocketException {
      _showNetworkErrorDialog(context, () {
        Navigator.of(context).pop();
        fetchOrders(context);
      });
      return null;
    }
  }

  Future<bool> deleteOrder({
    required BuildContext context,
    required int orderId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userJson = prefs.getString('user');
    final userMap = jsonDecode(userJson!);
    final userId = userMap['id'];

    if (token == null || userId == null) return false;

    try {
      final response = await http.delete(
        Uri.parse(ApiUrls.deleteOrder),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'order_id': orderId,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Ошибка удаления: ${response.body}');
        return false;
      }
    } on SocketException {
      _showNetworkErrorDialog(context, () {
        Navigator.of(context).pop();
      });
      return false;
    }
  }

  void _showNetworkErrorDialog(BuildContext context, VoidCallback onRetry) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => NetworkErrorDialog(onRetry: onRetry),
    );
  }
}