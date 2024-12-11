import 'package:get/get.dart';
import 'package:macrolife/screen/principal/principal_controller.dart';

class PrincipalBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => PrincipalController());
}
