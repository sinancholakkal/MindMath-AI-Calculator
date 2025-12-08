import 'package:flutter/material.dart';

import '../colors/app_palette.dart';

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    primaryColor: AppPalette.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPalette.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.white,
      selectedItemColor: AppPalette.black,
      unselectedItemColor: AppPalette.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blue,
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    primaryColor: AppPalette.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppPalette.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.black,
      selectedItemColor: AppPalette.white,
      unselectedItemColor: AppPalette.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
