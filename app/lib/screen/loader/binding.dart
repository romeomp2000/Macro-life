import 'package:fep/screen/loader/controller.dart';
import 'package:get/get.dart';

class LoaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoaderController());
  }
}
