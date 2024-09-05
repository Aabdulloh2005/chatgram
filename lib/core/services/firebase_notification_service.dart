import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  static final _pushNotification = FirebaseMessaging.instance;

  static Future<String?> getFcmToken() async {
    return await _pushNotification.getToken();
  }

  static Future<void> permission() async {
    await _pushNotification.requestPermission();
  }
}
