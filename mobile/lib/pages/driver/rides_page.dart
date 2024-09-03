import 'package:flutter/material.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/ride_model.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/services/ride_service.dart';
import 'package:mobile/widgets/cards/active_ride_card.dart';
import 'package:mobile/widgets/dialogs/confirmation_dialog.dart';
import 'package:mobile/widgets/loading.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({super.key});

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage> {
  final _rideService = RideService();
  List<ActiveRideCardModel> _activeRides = [];
  FetchStatus _fetchStatus = FetchStatus.loading;

  @override
  void initState() {
    super.initState();
    _getActiveRides();
  }

  void _getActiveRides() async {
    try {
      final rides = await _rideService.getActiveRides();
      setState(() {
        _activeRides = [...rides];
        _fetchStatus = FetchStatus.data;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  void _declineRide(int rideId) async {
    final areYouSure = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmationDialog(
        question: "Jeste li sigurni da zelite odbiti?",
      ),
    );

    if (areYouSure == null || !areYouSure) return;

    try {
      final declinedRideId = await _rideService.decline(rideId);
      final declinedRide =
          _activeRides.firstWhere((ride) => ride.id! == declinedRideId);
      setState(() {
        _activeRides.remove(declinedRide);
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Današnje Vožnje"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _build(),
    );
  }

  Widget _build() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vaša trenutno aktivna vožnja:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: _activeRides.isNotEmpty
                  ? ListView.builder(
                      itemCount: _activeRides.length,
                      itemBuilder: (itemBuilder, index) => ActiveRideCard(
                        ride: _activeRides[index],
                        decline: _declineRide,
                      ),
                    )
                  : const Center(
                      child: Text("Još uvijek nemate aktivnih vožnji"),
                    ),
            ),
          ],
        );
    }
  }
}
