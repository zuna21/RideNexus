import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/helpers/firebase_messaging_service.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/pages/selection_page.dart';
import 'package:mobile/services/client_service.dart';
import 'package:mobile/services/driver_service.dart';
import 'package:mobile/widgets/cards/driver_card.dart';
import 'package:mobile/widgets/loading.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  FetchStatus _fetchStatus = FetchStatus.loading;
  final _clientService = ClientService();
  final _driverService = DriverService();
  final _firebaseMessagingService = FirebaseMessagingService();
  final _scrollController = ScrollController();
  List<DriverCardModel> _drivers = [];
  StreamSubscription<RemoteMessage>? _notificationStream;
  int _pageIndex = 0;
  bool _haveMore = true;

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
          await _driverService.getAll(pageIndex: _pageIndex);
      _pageIndex++;
      if (drivers.length < AppConfig.pageSize) _haveMore = false;
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
      print(
        e.toString(),
      );
    }

    setState(() {
      _drivers = [..._drivers, ...drivers];
      _fetchStatus = FetchStatus.data;
    });
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
        body: _buildBody(),
      ),
    );
  }


  Widget _buildBody() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return Column(
          children: [
            /* Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _onSearch,
                          icon: const Icon(Icons.search_outlined),
                        ),
                        suffixIconColor: Theme.of(context).colorScheme.primary,
                        border: const OutlineInputBorder(),
                        hintText: 'Potražite vozača po imenu',
                      ),
                    ),
                  ),
                ],
              ),
            ), */
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
        );
    }
  }
}
