import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/fcm_model.dart';
import 'package:mobile/user_service.dart';
import 'package:http/http.dart' as http;

class FirebaseMessagingService {
  final _userService = UserService();

  void grandPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void receiveMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void updateFirebaseMessageToken() async {
// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        // APNS token is available, make FCM plugin API requests...
        _getToken();
      }
    } else {
      _getToken();
    }
  }

  void _getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
    if (token != null) {
      FcmModel fcmModel = FcmModel();
      fcmModel.token = token;
      await updateToken(fcmModel);
    }
    _listenForToken();
  }

  void _listenForToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      FcmModel fcmModel = FcmModel();
      fcmModel.token = fcmToken;
      await updateToken(fcmModel);
    }).onError((err) {
      // Error getting token.
    });
  }

  Future<bool> updateToken(FcmModel fcmModel) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/driver/update-fcm-token");
    final token = await _userService.getToken();

    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(fcmModel.toJson()));

    if (response.statusCode == 200) return true;
    return false;
  }
}
