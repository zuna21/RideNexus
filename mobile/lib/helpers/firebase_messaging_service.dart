import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/fcm_model.dart';
import 'package:mobile/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/widgets/dialogs/ride_dialog.dart';
import 'package:mobile/widgets/notifications/basic_notification.dart';

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

  void receiveMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
      print(message.data['NotificationType']);
      print(message.notification!.title);
      print(message.notification!.body!);
      // Ovo cemo ako je NotificationType == "Ride"
      if (message.data["NotificationType"] == "Ride") {
        showDialog(
          context: context,
          builder: (_) => RideDialog(
            title: message.notification!.title!,
            body: message.notification!.body!,
          ),
        );
      } else if (message.data["NotificationType"] == "Basic") {
        showDialog(context: context, builder: (_) => BasicNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
        ),);
      }

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
    final Uri url;
    final role = await _userService.getRole();
    if (role == "driver") {
      url = Uri.http(AppConfig.baseUrl, "/api/driver/update-fcm-token");
    } else {
      url = Uri.http(AppConfig.baseUrl, "/api/client/update-fcm-token");
    }
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
