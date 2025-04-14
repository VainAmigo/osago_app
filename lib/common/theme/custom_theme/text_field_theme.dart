import 'package:flutter/material.dart';

class MyTextFieldTheme {
  MyTextFieldTheme._();

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(

    errorMaxLines: 3,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    prefixIconColor: Colors.black,

    prefixStyle: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    suffixIconColor: Colors.grey,
    hintStyle: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF969AAE)),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(width: 1, color: Color(0xFF32A3D6)),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Color(0xFF32A3D6))),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 2, color: Colors.red)),
  );
}