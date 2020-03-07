import 'package:flutter/material.dart';

//ThemeData defaultTheme = _buildTheme();

const Color PrimaryColor = Color(0xFF2F74C5);
const Color PrimaryColorLight = Color(0xFF36B1FF);
const Color PrimaryColorDark = Color(0xFF2437A9);

const Color SecondaryColor = Color(0xFFA90085);
const Color SecondaryColorLight = Color(0xFFA90085);
const Color SecondaryColorDark = Color(0xFFA90085);

const Color Background = Color(0xFFfffdf7);
const Color TextColor = Color(0xFF004d40);

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    accentColor: SecondaryColor,
    accentColorBrightness: Brightness.dark,
    primaryColor: PrimaryColor,
    primaryColorDark: PrimaryColorDark,
    primaryColorLight: PrimaryColorLight,
    primaryColorBrightness: Brightness.dark,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: SecondaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: Background,
    cardColor: Background,
    textSelectionColor: PrimaryColorLight,
    backgroundColor: Background,
    textTheme: base.textTheme.copyWith(
        title: base.textTheme.title.copyWith(color: TextColor),
        body1: base.textTheme.body1.copyWith(color: TextColor),
        body2: base.textTheme.body2.copyWith(color: TextColor)),

    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      filled: true,
      fillColor: Background,
      hintStyle: TextStyle(color: Colors.grey)

    )
  );
}

