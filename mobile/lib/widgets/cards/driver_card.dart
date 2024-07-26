import 'package:flutter/material.dart';
import 'package:mobile/pages/user/driver_page.dart';
import 'package:mobile/widgets/rating.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DriverPage(),),
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
                      const Rating(
                        rating: 4.5,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(154)",
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Chip(
                        avatar: Icon(Icons.location_on_outlined),
                        label: Text("Doboj"),
                      ),
                    ],
                  ),
                  Text(
                    "Adir Žunić",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Vozilo: Ford Escord 1.6",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text("Cijena: 2 KM/km"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
