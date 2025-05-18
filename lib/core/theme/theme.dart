import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xff55DDE0),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Color(0xff55DDE0)),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff55DDE0),
      iconTheme: IconThemeData(color: Colors.grey[900]),
    ),
    primaryTextTheme: TextTheme(),
    textTheme: const TextTheme(
      labelSmall: TextStyle(fontSize: 16, color: Colors.black),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
    ),
    hintColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Color(0xff55DDE0),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Color(0xff55DDE0)),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.grey[200]),
    ),
    primaryTextTheme: TextTheme(),
    textTheme: const TextTheme(
      labelSmall: TextStyle(fontSize: 16, color: Colors.white),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
    ),
    hintColor: Colors.black,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
  );
}
