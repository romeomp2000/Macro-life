import 'package:fep/screen/nutricion/controller.dart';
import 'package:get/get.dart';

class NutricionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NutricionController());
  }
}
