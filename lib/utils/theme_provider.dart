import 'package:flutter/material.dart';

const Color softPink = Color(0xFFF8BBD0);
const Color hintPink = Color(0xFFF48FB1);
const Color darkText = Color(0xFF4E342E);
const Color softWhite = Color(0xFFFFF8F8);
const Color correctGreen = Color(0xFFC8E6C9);
const Color darkBackground = Color(0xFF2C1D1A);
const Color darkCard = Color(0xFF4E342E);
const Color darkWhite = Color(0xFFFFF8F8);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: softPink,
  scaffoldBackgroundColor: softWhite,
  fontFamily: 'CustomFont',
  appBarTheme: AppBarTheme(
    backgroundColor: softPink,
    foregroundColor: darkText,
    elevation: 0,
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: softPink,
      foregroundColor: darkText,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(fontFamily: 'CustomFont', color: hintPink),
    filled: true,
    fillColor: Colors.white.withOpacity(0.8),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: softPink, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: hintPink, width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: softPink,
  scaffoldBackgroundColor: darkBackground,
  fontFamily: 'CustomFont',
  appBarTheme: AppBarTheme(
    backgroundColor: darkCard,
    foregroundColor: softWhite,
    elevation: 0,
  ),

  cardTheme: CardThemeData(
    color: darkCard,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: hintPink,
      foregroundColor: darkText,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(fontFamily: 'CustomFont', color: hintPink),
    filled: true,
    fillColor: darkCard.withOpacity(0.8),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: softPink, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: hintPink, width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}