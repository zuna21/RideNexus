class LoginDriverModel {
  String? username;
  String? password;

  LoginDriverModel({this.username, this.password});

  LoginDriverModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class DriverModel {
  int? id;
  String? username;
  String? token;

  DriverModel({this.id, this.username, this.token});

  DriverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['token'] = token;
    return data;
  }
}
