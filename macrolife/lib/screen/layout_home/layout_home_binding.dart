import 'package:get/get.dart';
import 'package:macrolife/screen/layout_home/home_controller.dart';

class LayoutHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutHomeController());
  }
}
