import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/my_text_field.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/cars/presentation/pages/find_car_by_plate.dart';

class CarPlatePage extends StatelessWidget {
  final String inn;

  const CarPlatePage({super.key, required this.inn});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topTextBlock(
              title: translation(context).carPlateTopTitle,
              text: translation(context).carPlateTopText,
            ),
            SizedBox(height: 25),
            MyTextField(
              controller: controller,
              hintText: '000 AAA',
              obscureText: false,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: MyButton(
                text: translation(context).buttonContinue,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindCarByPlate(
                        carPlate: controller.text,
                        inn: inn,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
