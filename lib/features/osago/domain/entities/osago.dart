import 'package:cloud_firestore/cloud_firestore.dart';

class Osago {
  final String id;
  final String userPin;
  final String polisOwnerPin;
  final String polisOwnerName;
  final String carOwnerPin;
  final String carOwnerName;
  final DateTime startDate;
  final DateTime endDate;
  final String carPlate;
  final String carModel;
  final String carBrand;
  final String carId;
  final String osagoType;
  final String costOfOsago;
  final bool status;

  Osago({
    required this.id,
    required this.userPin,
    required this.polisOwnerPin,
    required this.polisOwnerName,
    required this.carOwnerPin,
    required this.carOwnerName,
    required this.startDate,
    required this.endDate,
    required this.carPlate,
    required this.carModel,
    required this.carBrand,
    required this.carId,
    required this.osagoType,
    required this.costOfOsago,
    required this.status,
  });

  Osago copyWith() {
    return Osago(
      id: id,
      userPin: userPin,
      polisOwnerPin: polisOwnerPin,
      polisOwnerName: polisOwnerName,
      carOwnerPin: carOwnerPin,
      carOwnerName: carOwnerName,
      startDate: startDate,
      endDate: endDate,
      carPlate: carPlate,
      carModel: carModel,
      carBrand: carBrand,
      carId: carId,
      osagoType: osagoType,
      costOfOsago: costOfOsago,
      status: status,
    );
  }

  // convert osago to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userPin': userPin,
      'polisOwnerPin': polisOwnerPin,
      'polisOwnerName': polisOwnerName,
      'carOwnerPin': carOwnerPin,
      'carOwnerName': carOwnerName,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'carPlate': carPlate,
      'carModel': carModel,
      'carBrand': carBrand,
      'carId': carId,
      'osagoType': osagoType,
      'costOfOsago': costOfOsago,
      'status': status,
    };
  }

  // convert json to data
  factory Osago.fromJson(Map<String, dynamic> json) {
    return Osago(
      id: json['id'],
      userPin: json['userPin'],
      polisOwnerPin: json['polisOwnerPin'],
      polisOwnerName: json['polisOwnerName'],
      carOwnerPin: json['carOwnerPin'],
      carOwnerName: json['carOwnerName'],
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      carPlate: json['carPlate'],
      carModel: json['carModel'],
      carBrand: json['carBrand'],
      carId: json['carId'],
      osagoType: json['osagoType'],
      costOfOsago: json['costOfOsago'],
      status: json['status'],
    );
  }
}
