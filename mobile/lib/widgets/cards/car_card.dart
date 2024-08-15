import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key, required this.car});

  final CarModel car;

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
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Column(
              children: [
                Text(
                  car.make!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                Text(
                  car.model!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ],
            ),
            Text(car.registrationNumber!),
            const Icon(
              Icons.directions_car_outlined,
              size: 50,
            ),
            Checkbox(
              value: car.isActive!,
              onChanged: (isChecked) {},
            ),
          ],
        ),
      ),
    );
  }
}
