import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/helpers/firebase_messaging_service.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:mobile/pages/driver/cars_page.dart';
import 'package:mobile/pages/driver/driver_basic_account_details.dart';
import 'package:mobile/pages/driver/messages_page.dart';
import 'package:mobile/pages/driver/reviews_page.dart';
import 'package:mobile/pages/driver/rides_page.dart';
import 'package:mobile/pages/selection_page.dart';
import 'package:mobile/services/driver_service.dart';
import 'package:mobile/widgets/big_select_button.dart';
import 'package:mobile/widgets/location_chip.dart';
import 'package:mobile/widgets/rating.dart';

enum PopupMenuItemValue { first, second, third }

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final _driverService = DriverService();
  final _firebaseMessagingService = FirebaseMessagingService();
  DriverAccountDetailsModel? _driver;
  PopupMenuItemValue? selectedItem;
  StreamSubscription<RemoteMessage>? _receiveMessageStream;

  @override
  void initState() {
    super.initState();
    getAccountDetails();
    _firebaseMessagingService.updateFirebaseMessageToken();
    _receiveMessage();
  }

  void _receiveMessage() {
    _receiveMessageStream = _firebaseMessagingService.receiveMessage(context);
  }

  void getAccountDetails() async {
    DriverAccountDetailsModel? driver;
    try {
      driver = await _driverService.GetAccountDetails();
    } catch (e) {
      print(e);
    }

    if (driver != null) {
      setState(() {
        _driver = driver;
      });
    }
  }


  void _onPopupMenuSelect(PopupMenuItemValue value) {
    switch (value) {
      case PopupMenuItemValue.first:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const DriverBasicAccountDetails(),
          ),
        );
        break;
      default:
    }
  }

  void onLogout() async {
    await _driverService.logout();
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SelectionPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _receiveMessageStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_driver == null ? "Username" : _driver!.username!),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          actions: [
            PopupMenuButton<PopupMenuItemValue>(
              icon: const Icon(Icons.settings),
              onSelected: (value) => _onPopupMenuSelect(value),
              itemBuilder: (context) => [
                const PopupMenuItem<PopupMenuItemValue>(
                  value: PopupMenuItemValue.first,
                  child: Text("Ažuriraj profil"),
                ),
              ],
            )
          ],
        ),
        body: _driver != null
            ? SingleChildScrollView(
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
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _driver!.profilePhotoUrl == null
                                      ? AppConfig.defaultProfile
                                      : _driver!.profilePhotoUrl!,
                                ),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _driver!.fullName!,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(_driver!.hasPrice!
                                  ? "${_driver!.price!} KM/km"
                                  : "Cijena nije navedena"),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LocationChip(),
                            ],
                          )
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
                            Rating(
                              rating: _driver!.rating!,
                              canChange: false,
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              _driver!.rating!.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "(${_driver!.ratingCount})",
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
                        Badge.count(
                          count: _driver!.unseenChats!,
                          isLabelVisible: _driver!.unseenChats! > 0,
                          child: BigSelectButton(
                            text: "Poruke",
                            icon: Icons.mail_outline,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const MessagesPage(),
                                ),
                              );
                            },
                          ),
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
                              MaterialPageRoute(
                                builder: (_) => ReviewsPage(
                                  driverId: _driver!.id!,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ElevatedButton(
                        onPressed: onLogout,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(50)),
                        child: const Text("Završi za danas"),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text("Failed to get account details."),
              ),
      ),
    );
  }
}
