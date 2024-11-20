import 'package:get/get.dart';
import 'package:fep/screen/configuraciones/configuraciones_controller.dart';

class ConfiguracionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfiguracionesController());
  }
}
