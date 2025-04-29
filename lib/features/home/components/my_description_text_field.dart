import 'package:flutter/material.dart';

class MyDescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;


  const MyDescriptionTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 5,
      controller: controller,
      obscureText: false,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        fillColor: Theme.of(context).colorScheme.inversePrimary,
        filled: true,
      ),
    );
  }
}
