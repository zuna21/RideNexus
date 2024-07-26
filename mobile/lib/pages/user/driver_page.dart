import 'package:flutter/material.dart';
import 'package:mobile/widgets/rating.dart';

class DriverPage extends StatelessWidget {
  const DriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vozac"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/800"),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Positioned(
                    bottom: -70,
                    left: 10,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                        image: const DecorationImage(
                          image: NetworkImage("https://picsum.photos/700"),
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("(154)"),
                      const SizedBox(
                        width: 10,
                      ),
                      const Rating(
                        rating: 4.6,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "4.6",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Adir Žunić",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Trenutna lokacija:"),
                            Text("Doboj"),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Vozilo:"),
                            Text("Ford Escord 1.6"),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reg. oznaka:"),
                            Text("543-T-123"),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cijena:"),
                            Text("Po dogovoru"),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text("Zakaži Vožnju"),
                    icon: const Icon(Icons.directions_car_outlined),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text("Pozovi"),
                    icon: const Icon(Icons.phone_outlined),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text("Ostavi Ocjenu"),
                    icon: const Icon(Icons.star_outline),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
