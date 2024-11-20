import 'package:fep/screen/series/editar/series_editar_controller.dart';
import 'package:fep/screen/series/lista/series_lista_controller.dart';
import 'package:fep/screen/series/nuevo/series_nuevo_controller.dart';
import 'package:get/get.dart';

class SeriesNuevoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeriesNuevoController());
  }
}

class SeriesListaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeriesListaController());
  }
}

class SeriesEditarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeriesEditarController());
  }
}
