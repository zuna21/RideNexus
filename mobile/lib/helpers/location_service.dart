import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/location_model.dart';
import 'package:mobile/user_service.dart';
import 'package:http/http.dart' as http;

class LocationService {
  final _userService = UserService();

  Future<LocationModel> getAndUpdateCurrentLocation() async {
    final location = LocationModel();
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    final position = await Geolocator.getCurrentPosition(locationSettings: locationSettings); 
    location.latitude = position.latitude;
    location.longitude = position.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    final city = placemarks[0].locality;
    location.location = city;

    // sacuvati u bazi
    final token = await _userService.getToken();
    final role = await _userService.getRole();
    Uri? url;
    role == "driver"
    ? url = Uri.http(AppConfig.baseUrl, "/api/location/driver")
    : url = Uri.http(AppConfig.baseUrl, "/api/location/client");
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(location.toJson())
    );

    if (response.statusCode == 200) {
      return LocationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to update location");
    }

  }



  Future<bool> havePermissionForLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
