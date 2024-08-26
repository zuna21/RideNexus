import 'dart:convert';

import 'package:mobile/app_config.dart';
import 'package:mobile/models/ride_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/user_service.dart';

class RideService {
  final _userService = UserService();

  Future<bool> create(CreateRideModel createRideModel) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/rides");
    final token = await _userService.getToken();

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(createRideModel.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
      // Ovo je mozda bolje nego baciti Exception
    }
  }

  Future<List<ActiveRideCardModel>> getActiveRides() async {
    final url = Uri.http(AppConfig.baseUrl, "/api/rides/active-rides");
    final token = await _userService.getToken();
    if (token == null) {
      throw Exception("Failed to get token.");
    }

    final response = await http.get(
      url,
      headers: AppConfig.getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>)
          .map((e) => ActiveRideCardModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to get active rides.");
    }
  }

  Future<int> decline(int rideId) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/rides/decline/${rideId}");
    final token = await _userService.getToken();
    if (token == null) {
      throw Exception("Failed to get token.");
    }

    final response =
        await http.get(url, headers: AppConfig.getAuthHeaders(token));

    if (response.statusCode == 200) {
      return rideId;
    } else {
      throw Exception("Failed to decline ride.");
    }
  }

  Future<bool> finish(int rideId, FinishRideModel finishRideModel) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/rides/finish/$rideId");
    final token = await _userService.getToken();
    if (token == null) {
      throw Exception("Failed to get token.");
    }

    final response = await http.put(
      url,
      headers: AppConfig.getAuthHeaders(token),
      body: json.encode(finishRideModel.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to finish ride.");
    }
  }
}
