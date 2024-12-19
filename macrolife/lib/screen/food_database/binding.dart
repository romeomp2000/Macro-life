import 'package:get/get.dart';
import 'package:macrolife/screen/food_database/controller.dart';

class FoodDatabaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodDatabaseController());
  }
}
