import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile/helpers/firebase_messaging_service.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/selection_page.dart';
import 'package:mobile/services/client_service.dart';
import 'package:mobile/services/driver_service.dart';
import 'package:mobile/widgets/cards/driver_card.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _clientService = ClientService();
  final _driverService = DriverService();
  final _firebaseMessagingService = FirebaseMessagingService();
  List<DriverCardModel> _drivers = [];
  StreamSubscription<RemoteMessage>? _notificationStream;

  @override
  void initState() {
    super.initState();
    getAll();
    _firebaseMessagingService.updateFirebaseMessageToken();
    _receiveMessage();
  }

  void _receiveMessage() {
    _notificationStream = _firebaseMessagingService.receiveMessage(context);
  }

  void onLogout() async {
    await _clientService.logout();

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SelectionPage(),
        ),
      );
    }
  }

  Future<void> getAll() async {
    List<DriverCardModel> drivers = [];
    try {
      drivers = await _driverService.getAll();
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _drivers = [...drivers];
    });
  }

  @override
  void dispose() {
    _notificationStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Vozači"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          actions: [
            IconButton(
              onPressed: onLogout,
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _drivers.length,
          itemBuilder: (itemBuilder, index) => DriverCard(
            driver: _drivers[index],
          ),
        ),
      ),
    );
  }
}
