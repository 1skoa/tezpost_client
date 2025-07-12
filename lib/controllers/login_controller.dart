import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezpost_client/screens/main_screen.dart';
import 'package:tezpost_client/utils/urls.dart';

class LoginController extends ChangeNotifier {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();
  bool showCodeField = false;
  bool isLoading = false;

  final phoneMask = MaskTextInputFormatter(
    mask: '### ### ###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  Future<void> sendSmsCode(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final phone = "992${phoneMask.getUnmaskedText()}";

    final response = await http.post(
      Uri.parse(ApiUrls.sendCode),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    isLoading = false;

    if (response.statusCode == 200) {
      showCodeField = true;
      await Future.delayed(Duration(milliseconds: 100));
      codeFocusNode.requestFocus();
    } else {
      _showError(context, response);
    }

    notifyListeners();
  }

  Future<void> submitCode(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final phone = "992${phoneMask.getUnmaskedText()}";

    final deviceToken = await FirebaseMessaging.instance.getToken();

    final response = await http.post(
      Uri.parse(ApiUrls.confirmCode),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "confirm_code": int.tryParse(codeController.text),
        "device_token": deviceToken,
      }),
    );

    isLoading = false;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['confirmed'] == true && data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('user', jsonEncode(data['user']));
        isLoading = false;
        if (context.mounted) {
          Future.microtask(() {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen(bottomNavIndex: 2)),
                  (route) => false,
            );
          });
        }
      } else {
        _showSnackBar(context, data['message'] ?? 'Неверный код');
      }
    } else {
      _showError(context, response);
    }
  }

  void _showError(BuildContext context, http.Response response) {
    try {
      final error = jsonDecode(response.body);
      _showSnackBar(context, error['message'] ?? 'Ошибка запроса');
    } catch (_) {
      _showSnackBar(context, 'Неизвестная ошибка');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }



  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    codeFocusNode.dispose();
    super.dispose();
  }
}
