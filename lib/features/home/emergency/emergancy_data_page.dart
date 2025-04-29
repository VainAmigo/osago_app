import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/my_text_field.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/common/localization/language_constants.dart';
import 'package:osago_bloc_app/features/home/components/image_picker_container.dart';
import 'package:osago_bloc_app/features/home/components/my_description_input_tile_d.dart';
import 'package:osago_bloc_app/features/home/components/my_description_text_field.dart';

import '../components/emergancy_input_tile.dart';
import '../components/extended_tile_card.dart';


class EmergancyDataPage extends StatefulWidget {
  const EmergancyDataPage({super.key});

  @override
  State<EmergancyDataPage> createState() => _EmergancyDataPageState();
}

class _EmergancyDataPageState extends State<EmergancyDataPage> {
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectedDateTime;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topTextBlock(
                  title: 'Зафиксировать ДТП',
                  text: 'Сперва заполните данные об происшествии',
                ),
                const SizedBox(height: 8),

                // date and time picker
                EmergancyInputTile(
                  title: 'Дата и время',
                  firstWidget: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 1,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDateTime != null
                              ? DateFormat('dd.MM.yyyy   HH:mm')
                              .format(_selectedDateTime!)
                              : 'Выберите дату и время',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),

                        GestureDetector(
                          onTap: _pickDateTime,
                          child: Icon(Icons.date_range, color: Theme.of(context).colorScheme.primary,),
                        )
                      ],
                    ),
                  ),
                ),
                //
                ListTile(
                  leading: Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Внимание!! С момента происшествия не должно проити больше 10 дней',
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),

                // location
                EmergancyInputTileD(
                  title: 'Место происшествия',
                  firstWidget: MyTextField(controller: _descriptionController, hintText: "Адресс", obscureText: false),
                  secondWidget: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.inversePrimary,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                          width: 1,
                        )),
                    child: Icon(Icons.location_on_rounded, color: Theme.of(context).colorScheme.primary,),
                  ),
                ),

                // description
                EmergancyInputTile(
                  title: 'Опишите происшествие',
                  firstWidget: MyDescriptionTextField(controller: _descriptionController, hintText: 'Описание')
                ),

                // photo picker
                ImagePickerContainer(),

                // other
                ExpandableCard(),

                // button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, top: 16.0),
                  child: MyButton(text: translation(context).buttonContinue),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
