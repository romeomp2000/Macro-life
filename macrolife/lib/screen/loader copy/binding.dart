import 'package:macrolife/screen/loader/controller.dart';
import 'package:get/get.dart';

class LoaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoaderController());
  }
}
