import 'package:fep/screen/EditarNutrientes/controller.dart';
import 'package:get/get.dart';

class EditarNutrientesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditarNutrientesController());
  }
}
