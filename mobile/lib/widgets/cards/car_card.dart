import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: NetworkImage("https://picsum.photos/650"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
            ),
            Column(
              children: [
                Text(
                  "Ford",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                Text(
                  "Escord 1.6",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ],
            ),
            const Text("345-T-861"),
            const Icon(
              Icons.directions_car_outlined,
              size: 50,
            ),
            Checkbox(
              value: true,
              onChanged: (isChecked) {},
            ),
          ],
        ),
      ),
    );
  }
}
