import 'package:cloud_firestore/cloud_firestore.dart';

class Osago {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String carPlate;
  final String osagoType;
  final String costOfOsago;
  final bool status;

  Osago({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.carPlate,
    required this.osagoType,
    required this.costOfOsago,
    required this.status,
  });

  Osago copyWith() {
    return Osago(
      id: id,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      carPlate: carPlate,
      osagoType: osagoType,
      costOfOsago: costOfOsago,
      status: status,
    );
  }

  // convert osago to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'carPlate': carPlate,
      'osagoType': osagoType,
      'costOfOsago': costOfOsago,
      'status': status,
    };
  }

  // convert json to data
  factory Osago.fromJson(Map<String, dynamic> json) {
    return Osago(
      id: json['id'],
      userId: json['userId'],
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      carPlate: json['carPlate'],
      osagoType: json['osagoType'],
      costOfOsago: json['costOfOsago'],
      status: json['status']
    );
  }
}
