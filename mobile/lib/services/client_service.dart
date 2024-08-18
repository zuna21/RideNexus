import 'dart:convert';

import 'package:mobile/app_config.dart';
import 'package:mobile/models/client_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/user_service.dart';

class ClientService {
  final _userService = UserService();

  Future<ClientModel> login(LoginClientModel loginClientModel) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/client/login");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(loginClientModel.toJson()),
    );

    if (response.statusCode == 200) {
      ClientModel client = ClientModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
      await _userService.setToken(client.token!);
      await _userService.setRole("client");
      return client;
    }
    else {
      throw Exception("Failed to login");
    }
  }

  Future<void> logout() async {
    await _userService.deleteAll();
  }
}