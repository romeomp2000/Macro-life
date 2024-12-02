import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditarNutrientesController extends GetxController {
  final valueController = TextEditingController();
  var text = ''.obs; // obs hace que la variable sea reactiva
}
