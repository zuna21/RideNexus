import 'dart:convert';

import 'package:mobile/app_config.dart';
import 'package:mobile/models/car_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/user_service.dart';

class CarService {
  final _userService = UserService();

  Future<List<CarModel>> getAll() async {
    final url = Uri.http(AppConfig.baseUrl, "/api/cars");
    final token = await _userService.getToken();

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>).map((e) => CarModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load cars.");
    }
  }

  Future<CarModel> create(CreateCarModel createCar) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/cars");
    final token = await _userService.getToken();

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(createCar.toJson())
    );

    if (response.statusCode == 200) {
      return CarModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to create car");
    }
  }

  Future<int> delete(int carId) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/cars/$carId");
    final token = await _userService.getToken();

    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token!}'
      },
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to delete car");
    }
  }
}