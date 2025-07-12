import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezpost_client/providers/theme_provider.dart';
import 'package:tezpost_client/routes/routes.dart';
import 'package:tezpost_client/theme/app_theme.dart';
import 'package:tezpost_client/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadThemeFromPrefs();
  await FirebaseService.init();

  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'TezPost Client',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
