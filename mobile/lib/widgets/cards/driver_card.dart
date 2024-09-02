import 'package:flutter/material.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/user/driver_page.dart';
import 'package:mobile/widgets/rating.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({super.key, required this.driver});

  final DriverCardModel driver;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DriverPage(
              driverId: driver.id!,
            ),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/600"),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2),
                      image: const DecorationImage(
                        image: NetworkImage("https://picsum.photos/600"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Row(
                    children: [
                      Rating(
                        rating: driver.rating!,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(${driver.ratingCount})",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.location_on_outlined),
                        label: Text(driver.location ?? "Nema lokacije"),
                      ),
                    ],
                  ),
                  Text(
                    driver.fullName!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    driver.car ?? "Nema auto",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text("Cijena: ${driver.price} KM/km"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
