import 'package:flutter/material.dart';
import 'package:mobile/widgets/cards/car_card.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moja Vozila"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarCard(),
            CarCard(),
            CarCard(),
          ],
        ),
      ),
    );
  }
}