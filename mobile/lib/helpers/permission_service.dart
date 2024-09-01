import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  
  Future<bool> requestPermissions(BuildContext context) async {
    // Check and request location permission
    if (!await _requestPermission(Permission.locationWhenInUse)) {
      _openSettings();
      return false;
    }

    // Check and request notification permission
    AuthorizationStatus aS = await _grandNotificationPermission();
    if (aS != AuthorizationStatus.authorized) {
      _openSettings();
      return false;
    }

    return true;
  }

  Future<AuthorizationStatus> _grandNotificationPermission() async {
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

    return settings.authorizationStatus;
  }



  // Method to request a single permission
  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  // Method to open app settings
  void _openSettings() async {
    await openAppSettings();
  }
}