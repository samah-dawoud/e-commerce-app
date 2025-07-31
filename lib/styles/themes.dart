import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: defaultColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.indigo
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo),
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      titleTextStyle: TextStyle(
        color: Colors.white, // Adjust this for lightTheme if needed
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white, // Adjust this for lightTheme if needed
      ),
      backgroundColor: Colors.transparent, // Make the AppBar background transparent
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set the status bar color to transparent
        statusBarIconBrightness: Brightness.light, // Adjust brightness based on dark/light theme
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey,
    ),
    textTheme:  TextTheme(
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: Colors.white
        )
    ),
    fontFamily: 'Inter'
);

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color:defaultColor
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: defaultColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      titleTextStyle: TextStyle(
        color: Colors.black, // Adjust this for lightTheme if needed
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.black, // Adjust this for lightTheme if needed
      ),
      backgroundColor: Colors.transparent, // Make the AppBar background transparent
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set the status bar color to transparent
        statusBarIconBrightness: Brightness.dark, // Adjust brightness based on dark/light theme
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor:defaultColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 20.0
    ),
    textTheme:  TextTheme(
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: Colors.black
        )
    ),
    fontFamily: 'Inter'



);