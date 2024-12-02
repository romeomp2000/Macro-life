// import 'package:fep/config/api_service.dart';
// import 'package:fep/helpers/usuario_controller.dart';
// import 'package:fep/models/contadores_model.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class ContadoresController extends GetxController {
//   Rx<ContadoresModel> contadores = ContadoresModel().obs;
//   final UsuarioController usuarioController = Get.put(UsuarioController());
//   RxBool loading = false.obs;

//   @override
//   void onInit() async {
//     loading.value = true;
//     await obtenerContadoresStorage();
//     await obtenerContadores();
//     loading.value = false;
//     super.onInit();
//   }

//   Future obtenerContadores() async {
//     try {
//       final apiService = ApiService();

//       int? idUsuario = usuarioController.usuario.value.idUsuario;

//       final response =
//           await apiService.fetchData('contadores/${idUsuario ?? 0}');

//       contadores.value = ContadoresModel.fromJson(response);

//       final box = GetStorage();
//       box.write('contadores', response);
//       contadores.refresh();
//     } catch (e) {
//       Get.snackbar(
//         'Contadores',
//         'Error al obtener contadores',
//         snackPosition: SnackPosition.TOP,
//         colorText: Colors.white,
//         backgroundColor: Colors.red,
//       );
//     }
//   }

//   Future obtenerContadoresStorage() async {
//     final box = GetStorage();
//     final data = box.read('contadores');
//     if (data != null) {
//       contadores.value = ContadoresModel.fromJson(data);
//       contadores.refresh();
//     }
//   }

//   void updateContadores() {
//     obtenerContadores();
//   }
// }
