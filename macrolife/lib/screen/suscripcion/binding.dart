import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/suscripcion/controller.dart';

class SuscripcionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuscripcionController());
  }
}
