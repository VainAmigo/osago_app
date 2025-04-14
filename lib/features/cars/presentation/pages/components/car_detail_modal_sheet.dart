import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/osago/presentation/pages/osago_types_page.dart';

import '../../../domain/entities/car.dart';

class CarDetailModalSheet extends StatelessWidget {
  final Car car;
  final String inn;

  const CarDetailModalSheet({super.key, required this.car, required this.inn});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      width: double.infinity,
      height: height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translation(context).carPlateModalSheetTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation(context).carPlateModalSheetPlate,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  car.govPlate,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                SizedBox(height: 8),
                Text(
                  translation(context).carPlateModalSheetBrand,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  car.brand,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                SizedBox(height: 8),
                Text(
                  translation(context).carPlateModalSheetModel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  car.model,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                SizedBox(height: 8),
                Text(
                  translation(context).carPlateModalSheetYear,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  car.year,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ],
            ),
          ),
          Spacer(),
          MyButton(
              text: translation(context).buttonContinue,
              onPress: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OsagoTypesPage(
                      car: car,
                      inn: inn,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
