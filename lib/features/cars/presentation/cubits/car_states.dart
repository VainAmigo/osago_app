import '../../domain/entities/car.dart';

abstract class CarState{}


// initial
class CarInitial extends CarState{}

// loading
class CarLoading extends CarState{}

// uploading
class CarUploading extends CarState{}

// error
class CarError extends CarState{
  final String message;
  CarError(this.message);
}

// loaded
class CarLoaded extends CarState{
  final List<Car> car;
  CarLoaded(this.car);
}

// loaded by car Plate
class CarLoadedByInn extends CarState{
  final Car car;
  CarLoadedByInn(this.car);
}