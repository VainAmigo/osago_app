import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/osago/presentation/pages/create_osago_page.dart';

import '../../../../common/components/my_button.dart';
import '../../../cars/domain/entities/car.dart';
import '../components/info_tile.dart';

class ConfirmInfoPage extends StatelessWidget {
  final Car car;
  final int periodOfPolis;
  final String costOfOsago;
  final String osagoType;
  final String carOwnerName;
  final String polisOwnerName;

  const ConfirmInfoPage({
    super.key,
    required this.car,
    required this.periodOfPolis,
    required this.costOfOsago,
    required this.osagoType,
    required this.carOwnerName,
    required this.polisOwnerName,
  });

  @override
  Widget build(BuildContext context) {
    bool osagoTypeText;
    if (osagoType == 'Для себя') {
      osagoTypeText = true;
    } else {
      osagoTypeText = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(osagoTypeText
            ? translation(context).insuranceTypeMySelf
            : translation(context).insuranceTypeUnlimited),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation(context).confirmDataTopTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation(context).confirmDataListTitle1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Column(
                        children: [
                          InfoTile(
                            title: translation(context).confirmDataTilePlate,
                            content: car.govPlate,
                          ),
                          InfoTile(
                            title: translation(context).confirmDataTileBrand,
                            content: car.brand,
                          ),
                          InfoTile(
                            title: translation(context).confirmDataTileModel,
                            content: car.model,
                          ),
                          InfoTile(
                            title: translation(context).confirmDataTileYear,
                            content: car.year,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // total cost
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation(context).confirmDataListTitle2,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      child: Column(
                        children: [
                          InfoTile(
                              title: translation(context).confirmDataTileOsago,
                              content: translation(context)
                                  .confirmDataTileOsagoName),
                          InfoTile(
                            title:
                                translation(context).confirmDataTileOsagoType,
                            content: osagoTypeText
                                ? translation(context).insuranceTypeMySelf
                                : translation(context).insuranceTypeUnlimited,
                          ),
                          InfoTile(
                            title:
                                translation(context).confirmDataTileOsagoPeriod,
                            content:
                                '${(periodOfPolis / 30).round().toString()} ${translation(context).confirmDataTileOsagoPeriodMonth}',
                          ),
                          InfoTile(
                            title:
                                translation(context).confirmDataTileOsagoPlate,
                            content: car.govPlate,
                          ),
                          InfoTile(
                            title:
                                translation(context).confirmDataTileOsagoCost,
                            content: '${costOfOsago.toString()}c',
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Text(
                        translation(context).confirmDataConsentToProcessing,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 16),
                      MyButton(
                        text: translation(context).buttonPay,
                        onPress: () {
                          Navigator.of(context).pop();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateOsagoPage(
                                car: car,
                                periodOfPolis: periodOfPolis,
                                costOfOsago: costOfOsago,
                                osagoType: osagoType,
                                carOwnerName: carOwnerName,
                                polisOwnerName: polisOwnerName,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
