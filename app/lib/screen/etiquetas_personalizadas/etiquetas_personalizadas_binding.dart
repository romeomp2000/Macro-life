import 'package:fep/screen/etiquetas_personalizadas/editar/etiquetas_personalizadas_editar_controller.dart';
import 'package:fep/screen/etiquetas_personalizadas/lista/etiquetas_personalizadas_lista_controller.dart';
import 'package:fep/screen/etiquetas_personalizadas/nuevo/etiquetas_personalizadas_nuevo_controller.dart';
import 'package:get/get.dart';

class EtiquetasPersonalizadasNuevoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EtiquetasPersonalizadasNuevoController());
  }
}

class EtiquetasPersonalizadasListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EtiquetasPersonalizadasListaController());
  }
}

class EtiquetasPersonalizadasEditarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EtiquetasPersonalizadasEditarController());
  }
}
