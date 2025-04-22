import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/cars/presentation/pages/components/car_detail_modal_sheet.dart';
import 'package:osago_bloc_app/features/osago/presentation/cubits/osago_cubit.dart';

import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../plateParser/car_plate_parser.dart';
import '../../../plateParser/new_car_plate.dart';
import '../../../plateParser/old_car_plate.dart';
import '../../domain/entities/car.dart';
import '../cubits/car_cubit.dart';
import '../cubits/car_states.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  late final carCubit = context.read<CarCubit>();
  late final authCubit = context.read<AuthCubit>();
  late final osagoCubit = context.read<OsagoCubit>();

  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    fetchMyCars();
  }

  void getCurrentUser() async {
    final authCubit = context.read()<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  void fetchMyCars() {
    carCubit.fetchMyCars(currentUser!.inn);
  }

  void showCarDetailModalSheet(
      BuildContext context, Car car, String inn) async {
    final exist = await FirebaseFirestore.instance
        .collection('osago')
        .where('carPlate', isEqualTo: car.govPlate.toUpperCase().trim())
        .where('status', isEqualTo: true)
        .get();

    if (exist.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation(context).carPlateAlreadyHasPolis),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => CarDetailModalSheet(
          car: car,
          inn: inn,
          carOwnerName: '',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).myCarsAppBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: BlocBuilder<CarCubit, CarState>(builder: (context, state) {
          // loading
          if (state is CarLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // loaded
          else if (state is CarLoaded) {
            final allCars = state.car;

            if (allCars.isEmpty) {
              return Center(
                child: Text(translation(context).myCarsCarNotFound),
              );
            }

            return ListView.builder(
              itemCount: allCars.length,
              itemBuilder: (context, index) {
                final car = allCars[index];
                final parser = CarPlateParser(car.govPlate);

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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () =>
                        showCarDetailModalSheet(context, car, currentUser!.inn),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${car.brand} ${car.model}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    translation(context).myCarsCardYearText,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    car.year,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
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
              },
            );
          }

          // error
          else if (state is CarError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
