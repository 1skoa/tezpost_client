import 'package:flutter/material.dart';
import 'package:tezpost_client/screens/main_screen.dart';

class NetworkErrorDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorDialog({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Ошибка сети'),
        content: const Text('Проверьте подключение к интернету и попробуйте снова.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen(bottomNavIndex: 0)),
                    (route) => false,
              );
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}