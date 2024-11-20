import 'package:get/get.dart';
import 'package:fep/screen/registro/registro_controller.dart';

class RegistroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistroController());
  }
}
