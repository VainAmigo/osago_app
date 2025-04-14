import 'package:country_icons/country_icons.dart';
import 'package:flutter/material.dart';

class CarPlate extends StatelessWidget {
  final String region;
  final String country;
  final String number;
  final String letter;

  const CarPlate({
    super.key,
    required this.region,
    required this.country,
    required this.number,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  region,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 15,
                  child: CountryIcons.getSvgFlag(country),
                ),
                Text(
                  country.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            indent: 0,
            endIndent: 0,
            width: 1,
            thickness: 1,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    letter.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
