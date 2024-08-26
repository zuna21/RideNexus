class CreateRideModel {
  int? driverId;
  int? passengers;

  CreateRideModel({this.driverId, this.passengers});

  CreateRideModel.fromJson(Map<String, dynamic> json) {
    driverId = int.tryParse(json['driverId'].toString());
    passengers = int.tryParse(json['passengers'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driverId'] = driverId;
    data['passengers'] = passengers;
    return data;
  }
}

class ActiveRideCardModel {
  int? id;
  int? clientId;
  String? username;
  double? latitude;
  double? longitude;
  String? location;
  int? passengers;
  String? createdAt;

  ActiveRideCardModel(
      {this.id,
      this.clientId,
      this.username,
      this.latitude,
      this.longitude,
      this.location,
      this.passengers,
      this.createdAt});

  ActiveRideCardModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    clientId = int.tryParse(json['clientId'].toString());
    username = json['username'];
    latitude = double.tryParse(json['latitude'].toString());
    longitude = double.tryParse(json['longitude'].toString());
    location = json['location'];
    passengers = int.tryParse(json['passengers'].toString());
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['clientId'] = clientId;
    data['username'] = username;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['passengers'] = passengers;
    data['createdAt'] = createdAt;
    return data;
  }
}

class FinishRideModel {
  double? price;

  FinishRideModel({this.price});

  FinishRideModel.fromJson(Map<String, dynamic> json) {
    price = double.tryParse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    return data;
  }
}

