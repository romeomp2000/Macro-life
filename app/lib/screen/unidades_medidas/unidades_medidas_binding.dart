import 'package:fep/screen/unidades_medidas/editar/unidades_medidas_editar_controller.dart';
import 'package:fep/screen/unidades_medidas/lista/unidades_medidas_lista_controller.dart';
import 'package:fep/screen/unidades_medidas/nuevo/unidades_medidas_nuevo_controller.dart';
import 'package:get/get.dart';

class UnidadesMedidasNuevoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnidadesMedidasNuevoController());
  }
}

class UnidadesMedidasListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnidadesMedidasListaController());
  }
}

class UnidadesMedidasEditarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnidadesMedidasEditarController());
  }
}
