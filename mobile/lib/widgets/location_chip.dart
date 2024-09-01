import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/helpers/location_service.dart';
import 'package:mobile/models/location_model.dart';

class LocationChip extends StatefulWidget {
  const LocationChip({super.key});

  @override
  State<LocationChip> createState() => _LocationChipState();
}

class _LocationChipState extends State<LocationChip> {
  final _locationService = LocationService();
  LocationModel? _location;
  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();
    _getAndUpdateLocation();
    _locationListener();
  }

  void _getAndUpdateLocation() async {
    try {
      final location = await _locationService.getAndUpdateCurrentLocation();
      setState(() {
        _location = location;
      });
    } catch(e) {
      print(e.toString(),);
    }
  }

  void _locationListener() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) async {
      if (position == null) return;
      try {
        final location = await _locationService.updateCurrentLocation(position);
        setState(() {
          _location = location;
        });
      } catch (e) {
        print(e.toString());
        _location = LocationModel();
        setState(() {
          _location!.location = "greška";
        });
      }
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _location == null ? "Nema lokacije" : _location!.location!,
      ),
      avatar: const Icon(Icons.location_on_outlined),
    );
  }
}
