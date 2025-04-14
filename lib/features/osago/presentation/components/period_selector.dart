import 'package:flutter/material.dart';

import '../../../../common/localization/language_constants.dart';

class PeriodSelector extends StatefulWidget {
  final Function(int) onPeriodSelected;

  const PeriodSelector({super.key, required this.onPeriodSelected});

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  int selectedIndex = 0; // Индекс по умолчанию

  late List<String> periods = [
    translation(context).period15Days,
    translation(context).period1Month,
    translation(context).period3Month,
    translation(context).period6Month,
    translation(context).period9Month,
    translation(context).period12Month,
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(periods.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            widget.onPeriodSelected(selectedIndex);
          },
          child: Container(
            width: (width - 60) / 2,
            height: 100,

            // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color:
                  selectedIndex == index ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Theme.of(context).colorScheme.inversePrimary,
              border: Border.all(
                color:
                    selectedIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSecondary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                periods[index],
                style: TextStyle(
                  color: selectedIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}
