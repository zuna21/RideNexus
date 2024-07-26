import 'package:flutter/material.dart';
import 'package:mobile/widgets/cards/driver_card.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vozači"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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