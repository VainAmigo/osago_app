import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/features/cars/domain/repos/car_repo.dart';
import 'package:osago_bloc_app/features/cars/presentation/cubits/car_states.dart';

import '../../domain/entities/car.dart';

class CarCubit extends Cubit<CarState> {
  final CarRepo carRepo;

  CarCubit({required this.carRepo}) : super(CarInitial());

  Future<void> fetchMyCars(String inn) async {
    try {
      emit(CarLoading());
      final cars = await carRepo.fetchMyCars(inn);
      emit(CarLoaded(cars));
        } catch (e) {
      emit(CarError('Failed to fetch my car: $e'));
    }
  }

  Future<void> addNewCar(Car car) async {
    try {
      emit(CarUploading());
      await carRepo.addNewCar(car);
    } catch (e) {
      throw Exception('Failed to add new car');
    }
  }


  Future<void> fetchCarByPlate(String carPlate) async {
    try {
      emit(CarLoading());
      final cars = await carRepo.fetchCarByPlate(carPlate);
      emit(CarLoadedByInn(cars));
    } catch (e) {
      throw Exception('Failed to add new car $e');
    }
  }
}
