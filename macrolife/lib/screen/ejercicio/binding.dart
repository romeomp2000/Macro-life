import 'package:get/get.dart';
import 'package:macrolife/screen/ejercicio/controller.dart';

class EjercicioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EjercicioController());
  }
}
