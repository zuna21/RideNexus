import 'dart:convert';

import 'package:mobile/app_config.dart';
import 'package:mobile/models/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/user_service.dart';

class ReviewService {
  final _userService = UserService();

  Future<ReviewModel> create(CreateReviewModel createReviewModel, int driverId) async {
    final token = await _userService.getToken();
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

  Future<ReviewDetailsModel> getReviewDetails(int driverId) async {
    final token = await _userService.getToken();
    final url = Uri.http(AppConfig.baseUrl, "/api/reviews/$driverId");
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return ReviewDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get review details");
    }
  }
}