import '../entities/car.dart';

abstract class CarRepo {
  Future<List<Car>> fetchMyCars(String inn);
  Future<void> addNewCar(Car car);
  Future<Car> fetchCarByPlate(String carPlate);
}