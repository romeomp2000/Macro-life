import 'package:get/get.dart';
import 'package:macrolife/screen/recover_password/recovery_password_controller.dart';

class RecoveryPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecoveryPasswordController());
  }
}
