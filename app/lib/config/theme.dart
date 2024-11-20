import 'package:flutter/material.dart';

const greenTheme1_ = Color.fromARGB(255, 0, 0, 0);
const blackTheme1_ = Color(0xFF002A3A);
const fondoTheme1_ = Color.fromARGB(255, 247, 247, 247); // F2F2F2

const blackTheme2_ = Color.fromRGBO(1, 0, 7, 1); // 44, 47, 58

const blackTheme3_ = Color.fromRGBO(10, 9, 15, 1); // 10, 10, 10

const blackTheme4_ = Color.fromRGBO(29, 31, 41, 1); // 10, 10, 10

const blackTheme5_ = Color.fromRGBO(121, 120, 130, 1); // 255, 255, 255

const clearTheme1_ = Color.fromRGBO(175, 171, 186, 1); // 0, 0, 0

const clearTheme2_ = Color.fromRGBO(229, 229, 229, 1); // 0, 0, 0

const clearTheme3_ = Color.fromRGBO(207, 203, 216, 1); // 0, 0, 0

const clearTheme4_ = Color.fromRGBO(233, 229, 243, 1); // 0, 0, 0

const clearTheme5_ = Color.fromRGBO(242, 242, 242, 1); // 0, 0, 0

const whiteTheme_ = Color.fromRGBO(255, 255, 255, 1); // 255, 255, 255

const blackTheme_ = Color.fromRGBO(0, 0, 0, 1); // 0, 0, 0

const pink_ = Color.fromRGBO(253, 73, 92, 1);

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: greenTheme1_,
    secondary: blackTheme1_,
    surface: fondoTheme1_,
  ),
  useMaterial3: true,
  fontFamily: 'Urbanist-Medium',
  appBarTheme: const AppBarTheme(
    backgroundColor: fondoTheme1_,
    toolbarTextStyle: TextStyle(
      color: blackTheme1_,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    elevation: 0,
    titleTextStyle: TextStyle(color: blackTheme1_, fontSize: 20),
    iconTheme: IconThemeData(color: blackTheme1_),
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16,
      color: blackTheme1_,
    ),
    subtitleTextStyle: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      color: blackTheme5_,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: greenTheme1_,
    linearTrackColor: Colors.transparent,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: greenTheme1_,
    foregroundColor: whiteTheme_,
  ),

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     backgroundColor: WidgetStateProperty.all(purpleTheme5_),
  //     shape: WidgetStateProperty.all(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     textStyle: WidgetStateProperty.all(
  //       const TextStyle(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   ),
  // ),
  // textButtonTheme: TextButtonThemeData(
  //   style: ButtonStyle(
  //     foregroundColor: WidgetStateProperty.all(purpleTheme5_),
  //     textStyle: WidgetStateProperty.all(
  //       const TextStyle(
  //         fontSize: 16,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   ),
  // ),
  dividerColor: clearTheme1_,
  dividerTheme: const DividerThemeData(
    color: clearTheme1_,
    thickness: 1,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: whiteTheme_,
    titleTextStyle: TextStyle(
      color: blackTheme1_,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: TextStyle(
      color: blackTheme1_,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dialogBackgroundColor: whiteTheme_,
);
