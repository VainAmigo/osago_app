import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFF4F6FA), // background for scaffold
    primary: Color(0xFF185294),
    onPrimary: Color(0xFF2C3E50), // secondary primary
    inversePrimary: Color(0xFFFFFFFF), // background surface
    tertiary: Color(0xFF1E2022), // text
    secondary: Color(0xFF7C819A), // grey
    onSecondary: Color(0xFFE9ECF2), // border color
  ),
  scaffoldBackgroundColor: Color(0xFFF4F6FA),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF151515),
    primary: Color(0xFF1C5EAA),
    onPrimary: Color(0xFF49647E),
    inversePrimary: Color(0xFF202020),
    tertiary: Color(0xFFDDDFE1),
    secondary: Color(0xFF969AAE),
    onSecondary: Color(0xFF2D2D2D),
  ),
  scaffoldBackgroundColor: Color(0xFF151515),

);
