import 'package:flutter/material.dart';
class MyTextButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyTextButton({
    super.key, this.onTap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}