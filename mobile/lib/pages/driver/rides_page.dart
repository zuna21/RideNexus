import 'package:flutter/material.dart';
import 'package:mobile/models/ride_model.dart';
import 'package:mobile/services/ride_service.dart';
import 'package:mobile/widgets/cards/active_ride_card.dart';
import 'package:mobile/widgets/dialogs/confirmation_dialog.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({super.key});

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage> {
  final _rideService = RideService();
  List<ActiveRideCardModel> _activeRides = [];

  @override
  void initState() {
    super.initState();
    getActiveRides();
  }

  void _declineRide(int rideId) async {
    final areYouSure = await showDialog<bool>(context: context, builder: (_) => ConfirmationDialog(
      question: "Jeste li sigurni da zelite odbiti?",
    ),);

    if (areYouSure == null || !areYouSure) return;

    try {
      final declinedRideId = await _rideService.decline(rideId);
      final declinedRide = _activeRides.firstWhere((ride) => ride.id! == declinedRideId);
      setState(() {
        _activeRides.remove(declinedRide);
      });
    } catch(e) {
      print(e.toString());
    }
  }

  void getActiveRides() async {
    try {
      final rides = await _rideService.getActiveRides();
      setState(() {
        _activeRides = [...rides];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Današnje Vožnje"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text("24.7.2024"),
                icon: const Icon(Icons.calendar_today_outlined),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    foregroundColor:
                        Theme.of(context).colorScheme.onTertiaryContainer),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _activeRides.length,
              itemBuilder: (itemBuilder, index) => ActiveRideCard(
                ride: _activeRides[index],
                decline: _declineRide,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
