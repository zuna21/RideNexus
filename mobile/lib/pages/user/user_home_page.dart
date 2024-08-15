import 'package:flutter/material.dart';
import 'package:mobile/pages/selection_page.dart';
import 'package:mobile/services/client_service.dart';
import 'package:mobile/widgets/cards/driver_card.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _clientService = ClientService();

  Future<void> onLogout() async {
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DriverCard(),
            DriverCard(),
            DriverCard(),
          ],
        ),
      ),
    );
  }
}
