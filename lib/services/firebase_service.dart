import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tezpost_client/screens/main_screen.dart';

class FirebaseService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await Firebase.initializeApp();

    await _requestPermission();

    final token = await _messaging.getToken();
    print('🔑 FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Foreground push: ${message.notification?.title}');
      print('📩 Body: ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('➡️ Открыто из уведомления: ${message.notification?.title}');

      MainScreen.selectedIndexNotifier.value = 1;
    });
  }

  static Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Разрешение получено');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print('❌ Разрешение отклонено');
    } else if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      print('🤔 Разрешение не определено');
    }
  }
}
