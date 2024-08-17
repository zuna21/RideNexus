import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/review_model.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<ReviewModel> create(CreateReviewModel createReviewModel, int driverId) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "clientToken");
    final url = Uri.http(AppConfig.baseUrl, "/api/reviews/$driverId");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: json.encode(createReviewModel.toJson())
    );

    if(response.statusCode == 200) {
      return ReviewModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to create review");
    }
  }
}