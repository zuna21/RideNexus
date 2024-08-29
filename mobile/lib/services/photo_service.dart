import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mobile/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/photo_model.dart';
import 'package:mobile/user_service.dart';

class PhotoService {
  final _picker = ImagePicker();
  final _userService = UserService();

  Future<File> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      throw Exception("Failed to pick image.");
    }

    return File(pickedFile.path);
  }

  Future<PhotoUrlModel> uploadDriverProfile(File image) async {
    final token = await _userService.getToken();
    if (token == null) {
      throw Exception("Failed to get token");
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.http(AppConfig.baseUrl, "/api/photos/driver-profile"),
    );

    request.headers.addAll(
      AppConfig.getAuthHeaders(token),
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', image.path),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      return PhotoUrlModel.fromJson(
        json.decode(
          await response.stream.bytesToString(),
        ),
      );
    } else {
      throw Exception("Failed to upload file.");
    }
  }

  Future<bool> deleteDriverProfile() async {
    var token = await _userService.getToken();
    if (token == null) {
      throw Exception("Failed to get token.");
    }

    var url = Uri.http(AppConfig.baseUrl, "/api/photos/driver-profile");
    final response = await http.delete(
      url,
      headers: AppConfig.getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete photo.");
    }
  }
}
