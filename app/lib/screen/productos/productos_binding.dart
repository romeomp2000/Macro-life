import 'package:fep/screen/productos/lista/productos_lista_controller.dart';
import 'package:fep/screen/productos/nuevo/productos_nuevo_controller.dart';
import 'package:get/get.dart';

class ProductosNuevoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductosNuevoController());
  }
}

class ProductosListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductosListaController());
  }
}

// class ProductosEditarBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => ProductosEditarController());
//   }
// }
