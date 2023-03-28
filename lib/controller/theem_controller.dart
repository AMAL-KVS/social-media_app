import 'package:flutter/material.dart';
import 'package:social_media/core/constants/constands.dart';

class TheemProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void tooggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: kblackcolor,
    colorScheme: const ColorScheme.dark(),
    dividerColor: kwhitecolor,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: kwhitecolor),
        iconTheme: IconThemeData(color: kwhitecolor)),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kwhitecolor,
    colorScheme: const ColorScheme.light(),
    dividerColor: kblackcolor,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: kblackcolor),
        iconTheme: IconThemeData(color: kblackcolor)),
  );
}
