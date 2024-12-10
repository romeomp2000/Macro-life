// // import 'package:fep/widgets/custom_elevated_button.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get_storage/get_storage.dart';
// // import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// // class PreferenciasController extends GetxController {
// //   final loginFormKey = GlobalKey<FormState>();

// //   TextEditingController colorPrincipalController =
// //       TextEditingController(text: '');

// //   TextEditingController numeroDecimalController =
// //       TextEditingController(text: '2');

// //   TextEditingController colorSecundarioController =
// //       TextEditingController(text: '');

// //   Rx<Color> colorPrincipal = const Color(0xFF80BC00).obs;
// //   Rx<Color> colorSecundario = const Color(0xFF80BC00).obs;

// //   RxBool activaCapturaNomininaController = false.obs;

// //   Future guardarPreferencias() async {
// //     if (loginFormKey.currentState!.validate()) {
// //       try {
// //         final box = GetStorage();
// //         box.write('color', colorPrincipalController.text);
// //         Get.snackbar(
// //           'Preferencias',
// //           'Preferencias guardadas',
// //           snackPosition: SnackPosition.TOP,
// //           colorText: Colors.white,
// //           backgroundColor: Colors.green,
// //         );
// //       } catch (e) {
// //         Get.snackbar(
// //           'Preferencias',
// //           'Error al guardar preferencias',
// //           snackPosition: SnackPosition.TOP,
// //           colorText: Colors.white,
// //           backgroundColor: Colors.red,
// //         );
// //       }
// //     }
// //   }

// //   void changeColorPrincipal() {
// //     Get.bottomSheet(
// //       backgroundColor: Colors.white,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(20),
// //           topRight: Radius.circular(20),
// //         ),
// //       ),
// //       clipBehavior: Clip.antiAliasWithSaveLayer,
// //       isScrollControlled: true,
// //       Padding(
// //         padding: const EdgeInsets.all(10.0),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 10),
// //             const Text(
// //               'Color Principal',
// //               style: TextStyle(fontSize: 18),
// //             ),
// //             const SizedBox(height: 10),
// //             Obx(
// //               () => ColorPicker(
// //                 hexInputController: colorPrincipalController,
// //                 enableAlpha: false,
// //                 pickerColor: colorPrincipal.value,
// //                 onColorChanged: (Color color) {
// //                   colorPrincipal.value = color;
// //                 },
// //                 pickerAreaHeightPercent: 0.8,
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Center(
// //               child: CustomElevatedButton(
// //                 message: 'Guardar',
// //                 function: () => Get.back(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void changeColorSecundario() {
// //     Get.bottomSheet(
// //       backgroundColor: Colors.white,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(20),
// //           topRight: Radius.circular(20),
// //         ),
// //       ),
// //       clipBehavior: Clip.antiAliasWithSaveLayer,
// //       isScrollControlled: true,
// //       Padding(
// //         padding: const EdgeInsets.all(10.0),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 10),
// //             const Text(
// //               'Color Secundario',
// //               style: TextStyle(fontSize: 18),
// //             ),
// //             const SizedBox(height: 10),
// //             Obx(
// //               () => ColorPicker(
// //                 hexInputController: colorSecundarioController,
// //                 enableAlpha: false,
// //                 pickerColor: colorSecundario.value,
// //                 onColorChanged: (Color color) {
// //                   colorSecundario.value = color;
// //                 },
// //                 pickerAreaHeightPercent: 0.8,
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Center(
// //               child: CustomElevatedButton(
// //                 message: 'Guardar',
// //                 function: () => Get.back(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
