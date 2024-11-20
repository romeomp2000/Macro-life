import 'package:fep/screen/impuestos/editar/impuestos_editar_controller.dart';
import 'package:fep/screen/impuestos/lista/impuestos_lista_controller.dart';
import 'package:fep/screen/impuestos/nuevo/impuestos_nuevo_controller.dart';
import 'package:get/get.dart';

class ImpuestoNuevoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImpuestosNuevoController());
  }
}

class ImpuestoListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImpuestosListaController());
  }
}

class ImpuestosEditarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImpuestosEditarController());
  }
}
