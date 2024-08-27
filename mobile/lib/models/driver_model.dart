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
  String? location;

  DriverCardModel(
      {this.id,
      this.fullName,
      this.car,
      this.price,
      this.rating,
      this.ratingCount,
      this.location
      });

  DriverCardModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    fullName = json['fullName'];
    car = json['car'];
    price = double.parse(json['price'].toString());
    rating = double.parse(json['rating'].toString());
    ratingCount = int.tryParse(json['ratingCount'].toString());
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['car'] = car;
    data['price'] = price;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['location'] = location;
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
  String? location;

  DriverDetailsModel(
      {this.id,
      this.username,
      this.fullName,
      this.car,
      this.registrationNumber,
      this.price,
      this.rating,
      this.ratingCount,
      this.phone,
      this.location});

  DriverDetailsModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    username = json['username'];
    fullName = json['fullName'];
    car = json['car'];
    registrationNumber = json['registrationNumber'];
    price = double.parse(json['price'].toString());
    rating = double.parse(json['rating'].toString());
    ratingCount = int.tryParse(json['ratingCount'].toString());
    phone = json['phone'];
    location = json['location'];
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
    data['location'] = location;
    return data;
  }
}


class DriverAccountDetailsModel {
  int? id;
  String? username;
  String? fullName;
  double? price;
  double? rating;
  int? ratingCount;
  int? unseenChats;

  DriverAccountDetailsModel(
      {this.id,
      this.username,
      this.fullName,
      this.price,
      this.rating,
      this.ratingCount,
      this.unseenChats});

  DriverAccountDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    price = double.parse(json['price'].toString());
    rating = double.parse(json['rating'].toString());
    ratingCount = json['ratingCount'];
    unseenChats = json['unseenChats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullName'] = fullName;
    data['price'] = price;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['unseenChats'] = unseenChats;
    return data;
  }
}

class DriverUpdateBasicDetailsModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  bool? hasPrice;
  double? price;

  DriverUpdateBasicDetailsModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.hasPrice,
      this.price});

  DriverUpdateBasicDetailsModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    hasPrice = json['hasPrice'];
    price = double.tryParse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['hasPrice'] = hasPrice;
    data['price'] = price;
    return data;
  }
}


class DriverUpdateMainDetailsModel {
  String? username;
  bool? changePassword;
  String? oldPassword;
  String? newPassword;
  String? repeatNewPassword;

  DriverUpdateMainDetailsModel(
      {this.username,
      this.changePassword,
      this.oldPassword,
      this.newPassword,
      this.repeatNewPassword});

  DriverUpdateMainDetailsModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    changePassword = json['changePassword'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    repeatNewPassword = json['repeatNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['changePassword'] = changePassword;
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    data['repeatNewPassword'] = repeatNewPassword;
    return data;
  }
}
