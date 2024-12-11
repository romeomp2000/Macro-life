import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:get/get.dart';

class ObjetivosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ObjetivosController());
  }
}
