import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Цвета для контейнера с +992 (фон и бордер)
    final codePrefixBackgroundColor = isDark ? Colors.grey[800] : Colors.grey.shade100;
    final codePrefixBorderColor = isDark ? Colors.grey[700] : Colors.grey.shade400;

    // Цвет заполнения для PinCodeTextField
    final activeFillColor = theme.colorScheme.primary.withOpacity(0.1);
    final selectedFillColor = theme.colorScheme.primary.withOpacity(0.2);
    final inactiveFillColor = isDark ? Colors.grey[700]! : Colors.grey.shade200;

    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Введите номер телефона',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: codePrefixBorderColor!),
                      borderRadius: BorderRadius.circular(10),
                      color: codePrefixBackgroundColor,
                    ),
                    child: Text(
                      '+992',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [controller.phoneMask],
                      decoration: InputDecoration(
                        hintText: '___ ___ ___',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: isDark ? Colors.grey[800] : Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              if (controller.showCodeField) ...[
                Text(
                  'Введите код из СМС',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                PinCodeTextField(
                  appContext: context,
                  focusNode: controller.codeFocusNode,
                  length: 4,
                  controller: controller.codeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: activeFillColor,
                    inactiveFillColor: inactiveFillColor,
                    selectedFillColor: selectedFillColor,
                    activeColor: theme.colorScheme.primary,
                    inactiveColor: inactiveFillColor,
                    selectedColor: theme.colorScheme.primary,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onChanged: (_) {},
                  textStyle: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
              ],

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(controller.showCodeField ? Icons.lock_open : Icons.send),
                  onPressed: () {
                    if (controller.showCodeField) {
                      controller.submitCode(context);
                    } else {
                      controller.sendSmsCode(context);
                    }
                  },
                  label: Text(controller.showCodeField ? 'Подтвердить' : 'Далее'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
