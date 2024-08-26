import 'package:flutter/material.dart';
import 'package:mobile/helpers/location_service.dart';
import 'package:mobile/models/location_model.dart';
import 'package:mobile/models/ride_model.dart';
import 'package:mobile/pages/driver/driver_home_page.dart';
import 'package:mobile/services/ride_service.dart';

class FinishRidePage extends StatefulWidget {
  const FinishRidePage({super.key, required this.rideId});

  final int rideId;

  @override
  State<FinishRidePage> createState() => _FinishRidePageState();
}

class _FinishRidePageState extends State<FinishRidePage> {
  final _priceController = TextEditingController();
  final _locationService = LocationService();
  final _currentLocation = LocationModel();
  final _rideService = RideService();

  @override
  void initState() {
    super.initState();
    updateCurrentLocation();
  }

  void updateCurrentLocation() async {
    final LocationModel location;
    try {
      location = await _locationService.getAndUpdateCurrentLocation();
      setState(() {
        _currentLocation.latitude = location.latitude!;
        _currentLocation.longitude = location.longitude!;
        _currentLocation.location = location.location!;
      });
    } catch (e) {
      print(e);
    }
  }

  void _onSubmit() async {
    final finishRide = FinishRideModel();
    finishRide.price = double.tryParse(_priceController.text) ?? 0;

    try {
      await _rideService.finish(widget.rideId, finishRide);
    } catch (e) {
      print(e.toString());
    }

    if (mounted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DriverHomePage(),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Završite Vožnju"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  "Nadamo se da je vožnja prošla kako treba. Ukoliko želite možete zamoliti putnika da Vam ostavi pozitivnu ocjenu. Ispod možete ostaviti koliko je vožnja koštala ukoliko to želite (nije obavezno, to je samo ako želite voditi evidenciju da imate uvid kad god to želite)."),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cijena (nije obavezno)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Trenutna lokacija:"),
                Chip(
                  avatar: const Icon(Icons.location_on_outlined),
                  label: Text(_currentLocation.location ?? "Nema lokacije"),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.onTertiaryContainer,
              ),
              child: const Text("Završi"),
            ),
          ],
        ),
      ),
    );
  }
}
