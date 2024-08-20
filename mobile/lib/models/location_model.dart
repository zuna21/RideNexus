class LocationModel {
  double? latitude;
  double? longitude;
  String? location;

  LocationModel({this.latitude, this.longitude, this.location});

  LocationModel.fromJson(Map<String, dynamic> json) {
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    return data;
  }
}