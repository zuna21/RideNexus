import 'package:flutter/material.dart';
import 'package:mobile/helpers/location_service.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/selection_page.dart';
import 'package:mobile/pages/user/user_login_page.dart';
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
  final _locationService = LocationService();
  List<DriverCardModel> _drivers = [];

  @override
  void initState() {
    super.initState();
    getLocationPermission();
    getAll();
  }

  void getLocationPermission() async {
    final havePermissions = await _locationService.havePermissionForLocation();
    if (!havePermissions) {
      await _clientService.logout();
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const UserLoginPage(),
          ),
        );
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

      /* const SingleChildScrollView(
        child: Column(
          children: [
            DriverCard(),
            DriverCard(),
            DriverCard(),
          ],
        ),
      ), */
    );
  }
}
