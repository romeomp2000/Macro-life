import 'package:flutter/material.dart';

const blackTheme5_ = Color.fromRGBO(121, 120, 130, 1); // 255, 255, 255

const redTheme_ = Color.fromRGBO(215, 105, 119, 1);
const yellowTheme_ = Color.fromRGBO(224, 160, 121, 1);
const blueTheme_ = Color.fromRGBO(124, 165, 225, 1);
const greenTheme_ = Color.fromRGBO(124, 172, 49, 1);
const greyTheme_ = Color.fromRGBO(224, 239, 252, 1);
const whiteTheme_ = Color.fromRGBO(255, 255, 255, 1); // 255, 255, 255
const blackTheme2_ = Color.fromRGBO(0, 0, 0, 1); // 44, 47, 58

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.black,
    secondary: Colors.black,
    surface: Colors.white,
  ),
  useMaterial3: true,
  fontFamily: 'InterTight',
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    toolbarTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    // shadowColor: Colors.white,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    subtitleTextStyle: TextStyle(
      fontSize: 14,
      color: blackTheme5_,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.black,
    linearTrackColor: Colors.transparent,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  dividerColor: Colors.black,
  dividerTheme: const DividerThemeData(
    color: Colors.white,
    thickness: 1,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dialogBackgroundColor: Colors.white,
);
