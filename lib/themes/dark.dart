import 'package:flutter/material.dart';

//ThemeData defaultTheme = _buildTheme();

const Color PrimaryColor = Color(0xFF2F74C5);
const Color PrimaryColorLight = Color(0xFF36B1FF);
const Color PrimaryColorDark = Color(0xFF2437A9);

const Color SecondaryColor = Color(0xFF2F74C5);
const Color SecondaryColorLight = Color(0xFFA90085);
const Color SecondaryColorDark = Color(0xFFA90085);

const Color Background = Color(0xFF000000);
const Color TextColor = Colors.grey;
const Color TextColorAccent = Colors.white70;

const Color ErrorColor = Color(0xFFDC1419);
const Color ButtonColor = Colors.white70;

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();

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
      buttonColor: ButtonColor,
      textTheme: base.textTheme.copyWith(
          title: base.textTheme.title.copyWith(color: TextColor),
          body1: base.textTheme.body1.copyWith(color: TextColor),
          body2: base.textTheme.body2.copyWith(color: TextColor)),
      accentTextTheme: base.textTheme.copyWith(
          title: base.textTheme.title.copyWith(color: TextColorAccent),
          body1: base.textTheme.body1.copyWith(color: TextColorAccent),
          body2: base.textTheme.body2.copyWith(color: TextColorAccent)),
      inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          filled: true,
          fillColor: Background.withOpacity(1.0),
          hintStyle: const TextStyle(color: Colors.grey)));
}
