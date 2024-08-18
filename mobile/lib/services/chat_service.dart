import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:http/http.dart' as http;

class ChatService {

  Future<ChatModel> getClientChatByIds(int driverId) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/chats/$driverId");
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "clientToken");

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token!}'
      },
    );

    if (response.statusCode == 200) {
      return ChatModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get chat.");
    }
  }
}