import 'dart:developer';

class VehicleUser {
  final String id;
  final String company;
  final String number;
  final String model;
  final String type;
  final String fuelType;
  final String? image;

  VehicleUser({
    required this.id,
    required this.company,
    required this.number,
    required this.model,
    required this.type,
    required this.fuelType,
    this.image,
  });

  factory VehicleUser.fromJson(Map<String, dynamic> json, String id) {
    return VehicleUser(
      id: id,
      company: json['vehicle_company'],
      number: json['vehicle_number'],
      model: json['vehicle_model'],
      type: json['vehicle_type'],
      fuelType: json['fuel_type'],
      image: (json['vehicle_image'] == null) ? "" : json['vehicle_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_company': company,
      'vehicle_number': number,
      'vehicle_model': model,
      'vehicle_type': type,
      'fuel_type': fuelType,
      'vehicle_image': image,
    };
  }
}

class VehiclePolice {
  final String id;
  final String company;
  final String number;
  final String model;
  final String violence;
  final String penalty;
  final String? image;
  final String latitude;
  final String longitude;
  VehiclePolice(
      {required this.id,
      required this.company,
      required this.number,
      required this.model,
      required this.violence,
      required this.penalty,
      this.image,
      required this.latitude,
      required this.longitude});

  factory VehiclePolice.fromJson(Map<String, dynamic> json, String id) {
    log("Vehicle police from json method :-- $id");
    return VehiclePolice(
      id: id,
      company: json['vehicle_company'],
      number: json['vehicle_number'],
      model: json['vehicle_model'],
      violence: json['violence'],
      penalty: json['penalty'],
      image: (json['vehicle_image']) ?? "",
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_company': company,
      'vehicle_number': number,
      'vehicle_model': model,
      'violence': violence,
      'penalty': penalty,
      'vehicle_image': image,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Police {
  final String id;
  final String PoliceID;
  final String password;

  Police({
    required this.id,
    required this.PoliceID,
    required this.password,
  });

  factory Police.fromJson(Map<String, dynamic> json, String id) {
    return Police(
      id: id,
      PoliceID: json['policeID'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'policeID': PoliceID,
      'password': password,
    };
  }
}
