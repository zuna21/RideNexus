import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  String? _token;
  String? _role;
  final _secureStorage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    if (_token != null) return _token!;
    _token = await _secureStorage.read(key: "token");
    return _token;
  }

  Future<void> setToken(String token) async {
    _token = token;
    await _secureStorage.write(key: "token", value: _token);
  }

  Future<String?> getRole() async {
    if (_role != null) return _role;
    _role = await _secureStorage.read(key: "role");
    return _role;
  }

  Future<void> setRole(String role) async {
    _role = role;
    await _secureStorage.write(key: "role", value: _role);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}