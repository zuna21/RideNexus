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


class DriverCardModel {
  int? id;
  String? fullName;
  String? car;
  double? price;
  double? rating;
  int? ratingCount;

  DriverCardModel(
      {this.id,
      this.fullName,
      this.car,
      this.price,
      this.rating,
      this.ratingCount});

  DriverCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    car = json['car'];
    price = double.parse(json['price'].toString());
    rating = double.parse(json['rating'].toString());
    ratingCount = json['ratingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['car'] = car;
    data['price'] = price;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    return data;
  }
}


class DriverDetailsModel {
  int? id;
  String? username;
  String? fullName;
  String? car;
  String? registrationNumber;
  double? price;
  double? rating;
  int? ratingCount;
  String? phone;

  DriverDetailsModel(
      {this.id,
      this.username,
      this.fullName,
      this.car,
      this.registrationNumber,
      this.price,
      this.rating,
      this.ratingCount,
      this.phone});

  DriverDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    car = json['car'];
    registrationNumber = json['registrationNumber'];
    price = double.parse(json['price'].toString());
    rating = double.parse(json['rating'].toString());
    ratingCount = json['ratingCount'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullName'] = fullName;
    data['car'] = car;
    data['registrationNumber'] = registrationNumber;
    data['price'] = price;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['phone'] = phone;
    return data;
  }
}
