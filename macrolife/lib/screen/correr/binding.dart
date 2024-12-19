import 'package:get/get.dart';
import 'package:macrolife/screen/correr/controller.dart';

class CorrerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CorrerController());
  }
}
