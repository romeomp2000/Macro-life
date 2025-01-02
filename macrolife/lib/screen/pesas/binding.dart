import 'package:get/get.dart';
import 'package:macrolife/screen/pesas/controller.dart';

class PesasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PesasController());
  }
}
