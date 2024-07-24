import 'package:flutter/material.dart';
import 'package:mobile/widgets/cards/ride_card.dart';

class RidesPage extends StatelessWidget {
  const RidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Današnje Vožnje"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 8
        ),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text("24.7.2024"),
                  icon: const Icon(Icons.calendar_today_outlined),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      foregroundColor:
                          Theme.of(context).colorScheme.onTertiaryContainer),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const RideCard(),
            const RideCard(),
            const RideCard(),
          ],
        ),
      ),
    );
  }
}
