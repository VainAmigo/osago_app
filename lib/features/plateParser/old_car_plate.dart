import 'package:country_icons/country_icons.dart';
import 'package:flutter/material.dart';

class OldCarPlate extends StatelessWidget {
  final String firstLetter;
  final String number;
  final String lastLetters;
  const OldCarPlate({
    super.key, required this.firstLetter, required this.number, required this.lastLetters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3.0),
              bottomLeft: Radius.circular(3.0),
            ),
            child: SizedBox(
              width: 15,
              height: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: CountryIcons.getSvgFlag('kg'),
              ),
            ),
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firstLetter.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              SizedBox(width: 5),
              Text(
                number,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              SizedBox(width: 5),
              Text(
                lastLetters.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ))

        ],
      ),
    );
  }
}