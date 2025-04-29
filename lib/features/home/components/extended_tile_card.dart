import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/my_text_field.dart';

class ExpandableCard extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _carPlateController = TextEditingController();
  final TextEditingController _polisController = TextEditingController();

  ExpandableCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isHaveEm = false;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        color: Theme.of(context).colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
            width: 1,
          ),
        ),
        child: ExpansionTile(
          title: Text(
            'Дополнительная информация',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Другие участники',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MyTextField(
                        controller: _nameController,
                        hintText: 'ФИО водителя',
                        obscureText: false),
                    const SizedBox(height: 8),
                    MyTextField(
                        controller: _phoneController,
                        hintText: 'Контактный номер',
                        obscureText: false),
                    const SizedBox(height: 8),
                    MyTextField(
                        controller: _carPlateController,
                        hintText: 'Номер авто',
                        obscureText: false),
                    const SizedBox(height: 8),
                    MyTextField(
                        controller: _polisController,
                        hintText: 'Номер полиса',
                        obscureText: false),
                  ],
                )),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Есть пострадавшие',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoSwitch(value: isHaveEm, onChanged: (value) {}),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Номер протокола',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MyTextField(
                    controller: _nameController,
                    hintText: 'Протокол',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
