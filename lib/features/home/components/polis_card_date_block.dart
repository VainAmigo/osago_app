import 'package:flutter/material.dart';

class DateBlock extends StatelessWidget {
  final String dateText;
  final String text;

  const DateBlock({
    super.key, required this.dateText, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text,
            style: Theme.of(context).textTheme.bodySmall),
        Text(
          dateText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}