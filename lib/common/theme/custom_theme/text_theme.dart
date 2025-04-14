import 'package:flutter/material.dart';

class MyTextTheme {
  MyTextTheme._();

  static TextTheme myTextTheme = TextTheme(
    // headline
    headlineSmall: const TextStyle().copyWith(
        fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black),

    // body
    bodyLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: const Color(0xff23262F)),
    bodySmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: const Color(0xff7C819A)),

    labelLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: const Color.fromARGB(124, 129, 154, 1)),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(124, 129, 154, 1)),
  );
}