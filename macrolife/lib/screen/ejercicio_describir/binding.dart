import 'package:get/get.dart';
import 'package:macrolife/screen/ejercicio_describir/controller.dart';

class EjercicioDescribirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EjercicioDescribirController());
  }
}
