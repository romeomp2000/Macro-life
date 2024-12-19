import 'package:get/get.dart';
import 'package:macrolife/screen/food_database_alimento/controller.dart';

class FoodDatabaseAlimentoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodDatabaseAlimentoController());
  }
}
