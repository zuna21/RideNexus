import 'package:flutter/material.dart';
import 'package:mobile/helpers/location_service.dart';
import 'package:mobile/models/location_model.dart';
import 'package:mobile/models/ride_model.dart';

class RideDialog extends StatefulWidget {
  const RideDialog({super.key});

  @override
  State<RideDialog> createState() => _RideDialogState();
}

class _RideDialogState extends State<RideDialog> {
  final _locationService = LocationService();
  LocationModel? _location;
  final createRideModel = CreateRideModel();
  final _passengersController = TextEditingController(
    text: "1"
  );

  @override
  void initState() {
    super.initState();
    getAndUpdateLocation();
  }

  void getAndUpdateLocation() async {
    LocationModel? location;
    try {
      location = await _locationService.getAndUpdateCurrentLocation();
    } catch(e) {
      print(e);
    }

    if (location != null) {
      setState(() {
        _location = location;
      });
    }
  }

  void _schedule() {
    if (_location == null || _passengersController.text.isEmpty || _passengersController.text.trim() == "") return;
    print(_passengersController.text);
    createRideModel.startLatitude = _location!.latitude!;
    createRideModel.startLongitude = _location!.longitude!;
    createRideModel.origin = _location!.location!;
    createRideModel.passengers = int.tryParse(_passengersController.text) ?? 1;
  }

  @override
  void dispose() {
    _passengersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Broj osoba:"),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    controller: _passengersController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Broj',
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vaša Lokacija: "),
                Chip(
                  label: Text(_location == null 
                  ? "...sačekajte"
                  : _location!.location!),
                  avatar: const Icon(Icons.location_on_outlined),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _schedule,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              child: const Text("Zakaži"),
            ),
          ],
        ),
      ),
    );
  }
}