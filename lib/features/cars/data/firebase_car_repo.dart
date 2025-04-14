import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osago_bloc_app/features/cars/domain/repos/car_repo.dart';

import '../domain/entities/car.dart';

class FirebaseCarRepo implements CarRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('cars');

  // fetch all my cars
  @override
  Future<List<Car>> fetchMyCars(String inn) async {
    try {
      final carSnapshot =
          await carCollection.where('inn', isEqualTo: inn).get();

      // convert firestore documents from json to list of cars
      final myCars = carSnapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return myCars;
    } catch (e) {
      throw Exception('Error fetching my car');
    }
  }

  @override
  Future<void> addNewCar(Car car) async {
    try {
      await carCollection.doc(car.id).set(car.toJson());
    } catch (e) {
      throw Exception('Error adding car: $e');
    }
  }

  @override
  Future<Car> fetchCarByPlate(String carPlate) async {
    try {
      final carSnapshot =
          await carCollection.where('carPlate', isEqualTo: carPlate).get();

      // convert firestore documents from json to list of cars
      final findingCar = carSnapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .first;

      return findingCar;
    } catch (e) {
      throw Exception('Error fetching car by Plate $e');
    }
  }
}
