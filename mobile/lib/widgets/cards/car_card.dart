import 'package:flutter/material.dart';
import 'package:mobile/models/car_model.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key, required this.car, required this.onCardTap});

  final CarModel car;
  final void Function(int carId) onCardTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCardTap(car.id!),
      child: Card(
        color: Colors.amber[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Image.network(
                  "https://picsum.photos/700",
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    car.make!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Chip(
                    color: WidgetStatePropertyAll(
                        car.isActive! ? Colors.greenAccent : Colors.redAccent),
                    label: Text(car.isActive! ? "Aktivno" : "Neaktivno"),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("Model:"), Text(car.model!)],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tablice:"),
                        Text(car.registrationNumber!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
