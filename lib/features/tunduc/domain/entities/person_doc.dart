import 'package:cloud_firestore/cloud_firestore.dart';

class PersonDoc {
  final String id;
  final String inn;
  final String firstName;
  final String secondName;
  final String docId;
  final String dateOfBirthday;
  final String docCategory;
  final String docDate;

  PersonDoc({
    required this.id,
    required this.inn,
    required this.firstName,
    required this.secondName,
    required this.docId,
    required this.dateOfBirthday,
    required this.docCategory,
    required this.docDate,
  });

  PersonDoc copyWith() {
    return PersonDoc(
      id: id,
      inn: inn,
      firstName: firstName,
      secondName: secondName,
      docId: docId,
      dateOfBirthday: dateOfBirthday,
      docCategory: docCategory,
      docDate: docDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inn': inn,
      'firstName': firstName,
      'secondName': secondName,
      'docId': docId,
      'dateOfBirthday': dateOfBirthday,
      'docCategory': docCategory,
      'docData': docDate,
    };
  }

  factory PersonDoc.fromJson(Map<String, dynamic> json) {
    return PersonDoc(
      id: json['id'],
      inn: json['inn'],
      firstName: json['firstName'],
      secondName: json['secondName'],
      docId: json['docId'],
      dateOfBirthday: json['dateOfBirthday'],
      docCategory: json['docCategory'],
      docDate: json['docDate'],
    );
  }
}
