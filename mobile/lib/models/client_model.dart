class ClientModel {
  int? id;
  String? username;
  String? token;

  ClientModel({this.id, this.username, this.token});

  ClientModel.fromJson(Map<String, dynamic> json) {
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


class LoginClientModel {
  String? username;
  String? password;

  LoginClientModel({this.username, this.password});

  LoginClientModel.fromJson(Map<String, dynamic> json) {
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
