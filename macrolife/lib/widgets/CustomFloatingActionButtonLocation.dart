import 'package:flutter/material.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double xOffset;
  final double yOffset;

  CustomFloatingActionButtonLocation(
      {required this.xOffset, required this.yOffset});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset standardOffset =
        FloatingActionButtonLocation.endDocked.getOffset(scaffoldGeometry);
    return Offset(standardOffset.dx + xOffset, standardOffset.dy + yOffset);
  }
}
