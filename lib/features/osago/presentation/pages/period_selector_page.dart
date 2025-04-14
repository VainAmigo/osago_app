import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/osago/presentation/components/my_cost_block.dart';
import 'package:osago_bloc_app/features/osago/presentation/components/period_selector.dart';
import 'package:osago_bloc_app/features/osago/presentation/pages/confirm_info_page.dart';

import '../../../../common/components/top_text_block.dart';
import '../../../cars/domain/entities/car.dart';
import '../../../../common/localization/language_constants.dart';

class PeriodSelectorPage extends StatefulWidget {
  final String osagoType;
  final Car car;

  const PeriodSelectorPage({
    super.key,
    required this.car,
    required this.osagoType,
  });

  @override
  State<PeriodSelectorPage> createState() => _TestCarPageState();
}

class _TestCarPageState extends State<PeriodSelectorPage> {
  late int periodOfPolis;
  double? costOfOsago;

  void getCostOfOsago() {
    double engineVolumeCov;
    double periodCov;
    // double ageCov;
    double cardCov = 1;

    int engineVolume = double.parse(widget.car.engineVolume).toInt();

    if (widget.car.carType == 'Sedan') {
      if (engineVolume > 2.4) {
        engineVolumeCov = 1.2;
      } else {
        engineVolumeCov = 1.0;
      }
    } else if (widget.car.carType == 'Bus') {
      if (engineVolume > 3.5) {
        engineVolumeCov = 1.65;
      } else {
        engineVolumeCov = 1.45;
      }
    } else if (widget.car.carType == 'Truck') {
      if (engineVolume > 5) {
        engineVolumeCov = 2.0;
      } else {
        engineVolumeCov = 1.6;
      }
    } else {
      engineVolumeCov = 1.5;
    }

    if (widget.car.certificate) {
      cardCov = 0.8;
    }

    switch (periodOfPolis) {
      case 15:
        periodCov = 0.2;
      case 30:
        periodCov = 0.3;
      case 90:
        periodCov = 0.5;
      case 180:
        periodCov = 0.7;
      case 270:
        periodCov = 0.9;
      case 365:
        periodCov = 1.0;
      default:
        periodCov = 1.0;
    }

    costOfOsago = 1680 * engineVolumeCov * periodCov * cardCov;

    costOfOsago = costOfOsago!.roundToDouble();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTextBlock(
                title: translation(context).periodTopTitle,
                text: translation(context).periodTopText,
              ),
              SizedBox(height: 24.0),

              // duration selector
              PeriodSelector(
                onPeriodSelected: (index) {
                  final periods = [15, 30, 90, 180, 270, 365];
                  periodOfPolis = periods[index];
                  getCostOfOsago();
                },
              ),

              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  children: [
                    if (costOfOsago != null) myCostBlock(cost: costOfOsago.toString()),
                    SizedBox(height: 24),
                    MyButton(
                      text: translation(context).buttonContinue,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmInfoPage(
                              car: widget.car,
                              periodOfPolis: periodOfPolis,
                              costOfOsago: costOfOsago.toString(),
                              osagoType: widget.osagoType,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
