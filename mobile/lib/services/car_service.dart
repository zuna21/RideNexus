import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/car_model.dart';
import 'package:http/http.dart' as http;

class CarService {
  Future<List<CarModel>> getAll() async {
    final url = Uri.http(AppConfig.baseUrl, "/api/cars");
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "driverToken");

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token!}'
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>).map((e) => CarModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load cars.");
    }

  }
}