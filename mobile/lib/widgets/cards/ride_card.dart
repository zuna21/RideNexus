import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  const RideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/600"),
                ),
                Text(
                  "jovan0808",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Text(
              "Doboj - Zenica",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Column(
              children: [
                const Text("1:25:26"),
                Text(
                  "45 KM",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("Ruta"),
              icon: const Icon(Icons.location_on_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
