import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:get/get.dart';

class RegistroPasosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistroPasosController());
  }
}
