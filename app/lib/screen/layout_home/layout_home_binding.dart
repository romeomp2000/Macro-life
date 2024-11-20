import 'package:get/get.dart';
import 'package:fep/screen/layout_home/home_controller.dart';

class LayoutHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutHomeController());
  }
}
