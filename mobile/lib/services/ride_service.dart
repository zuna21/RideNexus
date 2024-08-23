import 'dart:convert';

import 'package:mobile/app_config.dart';
import 'package:mobile/models/ride_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/user_service.dart';

class RideService {
  final _userService = UserService();

  Future<void> create(CreateRideModel createRideModel) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/rides");
    final token = await _userService.getToken();

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(createRideModel.toJson())
    );

    if (response.statusCode == 200) {
      // Uraditi nesto kad valja
    } else {
      throw Exception("Failed to create ride");
    }
  }
}