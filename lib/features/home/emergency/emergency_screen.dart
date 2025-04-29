import 'package:flutter/material.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/features/home/emergency/emergancy_data_page.dart';
import '../../../common/components/my_outlined_button.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> steps = [
      'Остановите машину и включите аварийку',
      'Проверьте наличие пострадавших',
      'Вызовите полицию и скорую при необходимости',
      'Вызовите аварийного комиссара',
      'Зафиксируйте место ДТП (фото, видео)',
      'Сообщите в страховую компанию',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Помощь',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTextBlock(
                title: 'Попали в аварию?',
                text: 'Быстрые действия при аварии.',
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '${index + 1}. ${steps[index]}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    MyOutlinedButton(
                      text: 'Вызвать аварийную службу',
                    ),
                    const SizedBox(height: 16),
                    MyOutlinedButton(
                      text: 'Зафиксировать ПДД',
                      onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmergancyDataPage(),
                        ),
                      ),
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
