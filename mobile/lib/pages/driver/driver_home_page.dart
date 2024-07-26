import 'package:flutter/material.dart';
import 'package:mobile/pages/driver/cars_page.dart';
import 'package:mobile/pages/driver/messages_page.dart';
import 'package:mobile/pages/driver/reviews_page.dart';
import 'package:mobile/pages/driver/rides_page.dart';
import 'package:mobile/widgets/big_select_button.dart';
import 'package:mobile/widgets/rating.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Username"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://picsum.photos/700"),
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Positioned(
                  bottom: -70,
                  left: 30,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://picsum.photos/500"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Adir Žunić",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Row(
                    children: [
                      Chip(
                        label: Text("Doboj"),
                        avatar: Icon(Icons.location_on),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("2 KM/km")
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Rating(
                      rating: 2.5,
                      canChange: false,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "2.5",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "(154)",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BigSelectButton(
                  text: "Vožnje",
                  icon: Icons.route_outlined,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RidesPage(),
                      ),
                    );
                  },
                ),
                BigSelectButton(
                  text: "Poruke",
                  icon: Icons.mail_outline,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MessagesPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BigSelectButton(
                  text: "Vozila",
                  icon: Icons.directions_car_outlined,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CarsPage(),
                      ),
                    );
                  },
                ),
                BigSelectButton(
                  text: "Recenzije",
                  icon: Icons.rate_review_outlined,
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ReviewsPage()));
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50)),
                child: const Text("Završi za danas"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
