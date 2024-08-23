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
