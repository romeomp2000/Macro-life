import 'package:fep/screen/preferencias/preferencias_controller.dart';
import 'package:get/get.dart';

class PreferenciasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreferenciasController());
  }
}
