class AppConfig {
  static const String baseUrl = "10.0.2.2:5000";
  static const String defaultProfile = "http://10.0.2.2:5000/images/default/default-profile.jpg";

  static Map<String, String> getAuthHeaders(String token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
}