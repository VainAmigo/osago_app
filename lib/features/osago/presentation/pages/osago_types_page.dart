import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/osago/presentation/pages/period_selector_page.dart';

import '../../../cars/domain/entities/car.dart';
import '../../../tunduc/presentation/pages/person_doc_info_page.dart';
import '../components/osago_type_card.dart';

class OsagoTypesPage extends StatelessWidget {
  final Car car;
  final String inn;
  final String carOwnerName;

  const OsagoTypesPage({
    super.key,
    required this.inn,
    required this.car, required this.carOwnerName,
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topTextBlock(
              title: translation(context).osagoTypeTopTitle,
              text: translation(context).osagoTypeTopText,
            ),
            SizedBox(height: 24),
            OsagoTypeCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PeriodSelectorPage(car: car, osagoType: 'Неограничено', carOwnerName: carOwnerName, polisOwnerName: '',),
                  ),
                );
              },
              color: Colors.lightGreen,
              title: translation(context).osagoTypeCardTitle1,
              text: translation(context).osagoTypeCardText1,
            ),
            SizedBox(height: 8),
            OsagoTypeCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PersonDocInfo(car: car, osagoType: 'Для себя', inn: inn,),
                  ),
                );
              },
              color: Colors.deepOrangeAccent,
              title: translation(context).osagoTypeCardTitle2,
              text: translation(context).osagoTypeCardText2,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
