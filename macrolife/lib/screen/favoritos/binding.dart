import 'package:macrolife/screen/favoritos/controller.dart';
import 'package:get/get.dart';

class FavoritosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoritosController());
  }
}
