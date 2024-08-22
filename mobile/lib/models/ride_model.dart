class CreateRideModel {
  double? startLatitude;
  double? startLongitude;
  String? origin;
  int? passengers;

  CreateRideModel(
      {this.startLatitude, this.startLongitude, this.origin, this.passengers});

  CreateRideModel.fromJson(Map<String, dynamic> json) {
    startLatitude = double.tryParse(json['startLatitude'].toString()) ?? 0.0;
    startLongitude = double.tryParse(json['startLongitude'].toString()) ?? 0.0 ;
    origin = json['origin'];
    passengers = int.tryParse(json['passengers'].toString()) ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startLatitude'] = startLatitude;
    data['startLongitude'] = startLongitude;
    data['origin'] = origin;
    data['passengers'] = passengers;
    return data;
  }
}
