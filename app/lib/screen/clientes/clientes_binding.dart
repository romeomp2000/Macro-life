import 'package:fep/screen/clientes/editar/clientes_editar_controller.dart';
import 'package:fep/screen/clientes/lista/clientes_lista_controller.dart';
import 'package:fep/screen/clientes/nuevo/clientes_nuevo_controller.dart';
import 'package:get/get.dart';

class ClientesNuevoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientesNuevoController());
  }
}

class ClientesListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientesListaController());
  }
}

class ClientesEditarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientesEditarController());
  }
}
