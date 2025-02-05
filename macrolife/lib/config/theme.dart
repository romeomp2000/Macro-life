import 'package:flutter/material.dart';

const blackTheme5_ = Color.fromRGBO(121, 120, 130, 1); // 255, 255, 255

const greenTheme_ = Color.fromRGBO(124, 172, 49, 1);
const whiteTheme_ = Color.fromRGBO(255, 255, 255, 1); // 255, 255, 255
const blackTheme2_ = Color.fromRGBO(0, 0, 0, 1); // 44, 47, 58

//Nuevo colores
const blackTheme_ = Color.fromRGBO(42, 48, 42, 1);
const redTheme_ = Color.fromRGBO(206, 84, 96, 1);
const yellowTheme_ = Color.fromRGBO(218, 142, 96, 1);
const blueTheme_ = Color.fromRGBO(100, 148, 218, 1);
const greyTheme_ = Color.fromRGBO(238, 239, 234, 1);

const blackThemeText = Color.fromRGBO(81, 96, 84, 1);

const backGround = Color.fromRGBO(252, 252, 252, 1);

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
      color: blackThemeText,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    // shadowColor: Colors.white,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: blackTheme_, fontSize: 20),
    iconTheme: IconThemeData(color: blackTheme_),
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      color: blackTheme_,
    ),
    subtitleTextStyle: TextStyle(
      fontSize: 14,
      color: blackTheme5_,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: blackTheme_,
    linearTrackColor: Colors.transparent,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: blackTheme_,
    foregroundColor: whiteTheme_,
  ),
  dividerColor: blackTheme_,
  dividerTheme: const DividerThemeData(
    color: Colors.white,
    thickness: 1,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: blackTheme_,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: TextStyle(
      color: blackTheme_,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dialogBackgroundColor: Colors.white,
);
