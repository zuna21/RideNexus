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
  final _searchController = TextEditingController();
  List<DriverCardModel> _drivers = [];
  StreamSubscription<RemoteMessage>? _notificationStream;
  int _pageIndex = 0;
  bool _haveMore = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          _fetchData();
        }
      }
    });
    _firebaseMessagingService.updateFirebaseMessageToken();
    _receiveMessage();
  }

  void _receiveMessage() {
    _notificationStream = _firebaseMessagingService.receiveMessage(context);
  }

  void _fetchData() async {
    if (!_haveMore) return;
    List<DriverCardModel> drivers = [];
    try {
      drivers =
          await _driverService.getAll(44.727549, 18.090244, _pageIndex, 10);
      _pageIndex++;
      if (drivers.length < 3) _haveMore = false;
    } catch (e) {
      print(
        e.toString(),
      );
    }

    if (drivers.isNotEmpty) {
      setState(() {
        _drivers = [..._drivers, ...drivers];
      });
    }
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

  void _onSearch() {
    if (_searchController.text.trim().isEmpty) return;
    print(_searchController.text);
  }

  @override
  void dispose() {
    _notificationStream?.cancel();
    _scrollController.dispose();
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
        body: Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: _onSearch, icon: const Icon(Icons.search_outlined),),
                      suffixIconColor: Theme.of(context).colorScheme.primary,
                      border: const OutlineInputBorder(),
                      hintText: 'Potražite vozača po imenu',
                    ),
                  ),
                ),
              ],
            ),
          ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _drivers.length,
                itemBuilder: (itemBuilder, index) => DriverCard(
                  driver: _drivers[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
