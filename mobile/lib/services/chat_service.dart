import 'dart:convert';

import 'package:mobile/app_config.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/message_model.dart';
import 'package:mobile/user_service.dart';

class ChatService {
  final _userService = UserService();

  Future<ChatModel> getClientChatByIds(int driverId) async {
    final url = Uri.http(AppConfig.baseUrl, "/api/chats/$driverId");
    final token = await _userService.getToken();

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return ChatModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get chat.");
    }
  }

  Future<MessageModel> sendMessage(int chatId, CreateMessageModel createMessageModel) async {
    // u zavisnosti od role samo url promijeni
    final url = Uri.http(AppConfig.baseUrl, "/api/chats/send-client/$chatId");
    final token = await _userService.getToken();

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(createMessageModel.toJson())
    );

    if (response.statusCode == 200) {
      return MessageModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to send message");
    }
  }

  Future<List<ChatCardModel>> getDriverChats() async {
    final url = Uri.http(AppConfig.baseUrl, "/api/chats/driver-chats");
    final token = await _userService.getToken();

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List<dynamic>).map((e) => ChatCardModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to get chats");
    }
  }
}