import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/osago/presentation/components/my_cost_block.dart';
import 'package:osago_bloc_app/features/osago/presentation/components/period_selector.dart';
import 'package:osago_bloc_app/features/osago/presentation/pages/confirm_info_page.dart';

import '../../../../common/components/top_text_block.dart';
import '../../../cars/domain/entities/car.dart';

class PeriodSelectorPage extends StatefulWidget {
  final String osagoType;
  final Car car;
  final String carOwnerName;
  final String polisOwnerName;

  const PeriodSelectorPage({
    super.key,
    required this.car,
    required this.osagoType, required this.carOwnerName, required this.polisOwnerName,
  });

  @override
  State<PeriodSelectorPage> createState() => _TestCarPageState();
}

class _TestCarPageState extends State<PeriodSelectorPage> {
  late int periodOfPolis;
  double? costOfOsago;

  void getCostOfOsago() {
    final engineVolume = double.tryParse(widget.car.engineVolume)?.toInt() ?? 0;

    final engineVolumeCov = switch (widget.car.carType) {
      'Sedan' => engineVolume > 2.4 ? 1.2 : 1.0,
      'Bus'   => engineVolume > 3.5 ? 1.65 : 1.45,
      'Truck' => engineVolume > 5.0 ? 2.0 : 1.6,
      _       => 1.5,
    };

    final cardCov = widget.car.certificate ? 0.8 : 1.0;

    final periodCov = {
      15: 0.2,
      30: 0.3,
      90: 0.5,
      180: 0.7,
      270: 0.9,
      365: 1.0,
    }[periodOfPolis] ?? 1.0;


    costOfOsago = (2000 * engineVolumeCov * periodCov * cardCov).roundToDouble();
    // costOfOsago = (1680 * engineVolumeCov * periodCov * cardCov).roundToDouble();

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
                    if (costOfOsago != null)
                      myCostBlock(cost: costOfOsago.toString()),
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
                              carOwnerName: widget.carOwnerName,
                              polisOwnerName: widget.polisOwnerName,
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
