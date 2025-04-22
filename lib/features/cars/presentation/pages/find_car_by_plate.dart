import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/cars/presentation/pages/components/car_detail_modal_sheet.dart';

import '../../../plateParser/car_plate_parser.dart';
import '../../../plateParser/new_car_plate.dart';
import '../../../plateParser/old_car_plate.dart';
import '../../domain/entities/car.dart';
import '../cubits/car_cubit.dart';
import '../cubits/car_states.dart';

class FindCarByPlate extends StatefulWidget {
  final String carPlate;
  final String inn;
  final String carOwnerName;

  const FindCarByPlate({
    super.key,
    required this.carPlate,
    required this.inn, required this.carOwnerName,
  });

  @override
  State<FindCarByPlate> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<FindCarByPlate> {
  late final carCubit = context.read<CarCubit>();

  @override
  void initState() {
    super.initState();
    fetchMyCars();
  }

  void fetchMyCars() {
    carCubit.fetchMyCars(widget.inn);
  }

  void showCarDetailModalSheet(BuildContext context, Car car, inn) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CarDetailModalSheet(
        car: car,
        inn: inn,
        carOwnerName: widget.carOwnerName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).carPlateAppBarTitle),
      ),
      body: BlocBuilder<CarCubit, CarState>(builder: (context, state) {
        // loading
        if (state is CarLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // loaded
        else if (state is CarLoaded) {
          final filteredCars = state.car.where(
            (car) =>
                car.govPlate.trim() == widget.carPlate.toUpperCase().trim(),
          );

          if (filteredCars.isEmpty) {
            return const Center(child: Text('Машина не найдена'));
          }

          final selectedCar = filteredCars.first;

          if (selectedCar == null) {
            return const Center(
              child: Text('No cars'),
            );
          }

          final parser = CarPlateParser(selectedCar.govPlate);

          final isFormatOne = parser.isFormatOne();
          final isFormatTwo = parser.isFormatTwo();

          String region = '', country = '', number = '', letters = '';
          String firstLetter = '', lastLetters = '';

          if (isFormatOne) {
            var parts = parser.parseFormatOne();
            region = parts[0];
            country = parts[1];
            number = parts[2];
            letters = parts[3];
          } else if (isFormatTwo) {
            var parts = parser.parseFormatTwo();
            firstLetter = parts[0];
            number = parts[1];
            lastLetters = parts[2];
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
            child: InkWell(
              onTap: () =>
                  showCarDetailModalSheet(context, selectedCar, widget.inn),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.inversePrimary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Row(
                  children: [
                    if (isFormatOne)
                      CarPlate(
                          region: region,
                          country: country,
                          number: number,
                          letter: letters),
                    if (isFormatTwo)
                      OldCarPlate(
                          firstLetter: firstLetter,
                          number: number,
                          lastLetters: lastLetters),
                    SizedBox(width: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${selectedCar.brand} ${selectedCar.model}',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              translation(context).carPlateCardYear,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              selectedCar.year,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // error
        else if (state is CarError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
