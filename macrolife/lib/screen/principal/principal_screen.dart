import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/principal/principal_controller.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrincipalController>(builder: ((controller) {
      return Scaffold(
        body: Center(),
      );
    }));
  }
}
