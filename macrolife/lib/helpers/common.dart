import 'package:macrolife/config/theme.dart';
import 'package:flutter/material.dart';

class Common {
  Color maincolor = const Color(0xFF35C2C1);
  Color white = const Color(0xFFF5F5F5);
  Color black = const Color(0xFF1E232C);

  TextStyle titelTheme = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    // color: Colors.white
  );
  TextStyle mediumTheme = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: greenTheme1_);
  TextStyle mediumThemeblack = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w300, color: Colors.grey);
  TextStyle semiboldwhite = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle semiboldblack = const TextStyle(
    fontSize: 15,
    //  color: Colors.white
  );
  TextStyle hinttext = const TextStyle(
    fontSize: 15,
    color: Color(
      0xFF8391A1,
    ),
  );
}
