import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/driver_model.dart';
import 'package:http/http.dart' as http;

class DriverService {
  Future<DriverModel> login(LoginDriverModel loginDriverModel) async {
    const storage = FlutterSecureStorage();
    final url = Uri.http(AppConfig.baseUrl, "/api/driver/login");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(loginDriverModel.toJson()),
    );

    if (response.statusCode == 200) {
      DriverModel driver = DriverModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
      await storage.write(key: "driverToken", value: driver.token!);
      return driver;
    }
    else {
      throw Exception("Failed to login");
    }
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<List<DriverCardModel>> getAll() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "clientToken");
    final url = Uri.http(AppConfig.baseUrl, "/api/driver");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>).map((driver) => DriverCardModel.fromJson(driver)).toList();
    } else {
      throw Exception("Failed to get drivers");
    }
  }

  Future<DriverDetailsModel> getDetails(int driverId) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "clientToken");
    final url = Uri.http(AppConfig.baseUrl, "/api/driver/$driverId");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return DriverDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get driver");
    }
  }
}
