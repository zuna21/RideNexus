import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/client_model.dart';
import 'package:http/http.dart' as http;

class ClientService {
  Future<ClientModel> login(LoginClientModel loginClientModel) async {
    const storage = FlutterSecureStorage();
    final url = Uri.http(AppConfig.baseUrl, "/api/client/login");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(loginClientModel.toJson()),
    );

    if (response.statusCode == 200) {
      ClientModel driver = ClientModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
      await storage.write(key: "clientToken", value: driver.token!);
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
}