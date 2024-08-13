class CarModel {
  int? id;
  String? make;
  String? model;
  String? registrationNumber;
  bool? isActive;
  String? createdAt;

  CarModel(
      {this.id,
      this.make,
      this.model,
      this.registrationNumber,
      this.isActive,
      this.createdAt});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['make'];
    model = json['model'];
    registrationNumber = json['registrationNumber'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['make'] = make;
    data['model'] = model;
    data['registrationNumber'] = registrationNumber;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    return data;
  }
}

class CreateCarModel {
  String? make;
  String? model;
  String? registrationNumber;
  bool? isActive;

  CreateCarModel(
      {this.make, this.model, this.registrationNumber, this.isActive});

  CreateCarModel.fromJson(Map<String, dynamic> json) {
    make = json['make'];
    model = json['model'];
    registrationNumber = json['registrationNumber'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['make'] = make;
    data['model'] = model;
    data['registrationNumber'] = registrationNumber;
    data['isActive'] = isActive;
    return data;
  }
}
