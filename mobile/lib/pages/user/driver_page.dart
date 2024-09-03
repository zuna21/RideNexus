import 'package:flutter/material.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/driver/chat_page.dart';
import 'package:mobile/pages/driver/reviews_page.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/pages/user/review_page.dart';
import 'package:mobile/services/driver_service.dart';
import 'package:mobile/widgets/loading.dart';
import 'package:mobile/widgets/rating.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key, required this.driverId});

  final int driverId;

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  final _driverService = DriverService();
  FetchStatus _fetchStatus = FetchStatus.loading;
  DriverDetailsModel? _driver;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    DriverDetailsModel? driver;
    try {
      driver = await _driverService.getDetails(widget.driverId);
      setState(() {
        _driver = driver;
        _fetchStatus = FetchStatus.data;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _driver != null ? Text(_driver!.username!) : const Text("Vozač"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _build()
    );
  }

  Widget _build() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return SingleChildScrollView(
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
                                image:
                                    NetworkImage("https://picsum.photos/700"),
                              ),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("(${_driver!.ratingCount!})"),
                            const SizedBox(
                              width: 10,
                            ),
                            Rating(
                              rating: _driver!.rating!,
                              size: 30,
                              canChange: false,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _driver!.rating!.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          _driver!.fullName!,
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Trenutna lokacija:"),
                                  Text(_driver!.location ?? "Nema lokacije"),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Vozilo:"),
                                  Text(_driver!.car!),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Reg. oznaka:"),
                                  Text(_driver!.registrationNumber!),
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Cijena:"),
                                  Text(_driver!.price.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatPage(
                                  driverId: widget.driverId,
                                ),
                              ),
                            );
                          },
                          label: const Text("Zakaži Vožnju"),
                          icon: const Icon(Icons.directions_car_outlined),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () =>
                              launchUrlString("tel://${_driver!.phone!}"),
                          label: const Text("Pozovi"),
                          icon: const Icon(Icons.phone_outlined),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ReviewPage(
                                  id: widget.driverId,
                                ),
                              ),
                            );
                          },
                          label: const Text("Ostavi Ocjenu"),
                          icon: const Icon(Icons.star_outline),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ReviewsPage(driverId: _driver!.id!),
                              ),
                            );
                          },
                          label: const Text("Pogledaj Ocjene"),
                          icon: const Icon(Icons.reviews_outlined),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    }
  }
}
