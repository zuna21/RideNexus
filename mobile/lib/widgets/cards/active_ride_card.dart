import 'package:flutter/material.dart';
import 'package:mobile/models/ride_model.dart';
import 'package:mobile/pages/driver/finish_ride_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiveRideCard extends StatefulWidget {
  const ActiveRideCard({super.key, required this.ride, required this.decline});

  final ActiveRideCardModel ride;
  final Function(int rideId) decline;

  @override
  State<ActiveRideCard> createState() => _ActiveRideCardState();
}

class _ActiveRideCardState extends State<ActiveRideCard> {
  void _openNavigation() async {
    if (widget.ride.latitude == null || widget.ride.longitude == null)
      return; // bolje je neku poruku napisati
    final Uri url;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      url = Uri.parse(
          "maps:directions?daddr=${widget.ride.latitude},${widget.ride.longitude}");
    } else {
      url = Uri.parse(
          "google.navigation:q=${widget.ride.latitude},${widget.ride.longitude}");
    }

    try {
      await launchUrl(url);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/700"),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Text(
              widget.ride.username!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Iz mjesta:",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                      Text(
                        widget.ride.location!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Broj putnika:",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                      Text(
                        widget.ride.passengers!.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kreirano u:",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                      Text(
                        widget.ride.createdAt!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      widget.decline(widget.ride.id!);
                    },
                    child: const Text("Odbij"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: _openNavigation,
                    child: const Text("Prihvati"),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: Colors.teal[800],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FinishRidePage(),
                  ),
                );
              },
              child: const Text("Završi vožnju"),
            ),
          ],
        ),
      ),
    );
  }
}
