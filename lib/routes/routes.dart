import 'package:flutter/material.dart';
import 'package:tezpost_client/screens/home_screen.dart';
import 'package:tezpost_client/screens/login_screen.dart';
import 'package:tezpost_client/screens/main_screen.dart';
import 'package:tezpost_client/screens/orders_screen.dart';
import 'package:tezpost_client/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String main = '/main';
  static const String order = '/order';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case order:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case main:
        final index = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => MainScreen(bottomNavIndex: index),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 — Страница не найдена')),
          ),
        );
    }
  }
}
