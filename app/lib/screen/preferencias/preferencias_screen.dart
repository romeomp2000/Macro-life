// import 'package:fep/screen/preferencias/preferencias_controller.dart';
// import 'package:fep/widgets/back_arrow.dart';
// import 'package:fep/widgets/custom_elevated_button.dart';
// import 'package:fep/widgets/custom_text_form_field.dart';
// import 'package:fep/widgets/fade_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PreferenciasScreen extends StatelessWidget {
//   const PreferenciasScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const BackArrow(text: 'Configuraciones'),
//         //quitar el boton de regresar
//         automaticallyImplyLeading: false,
//       ),
//       body: const SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Preferencias',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               FormularioPreferencias(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FormularioPreferencias extends StatelessWidget {
//   const FormularioPreferencias({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PreferenciasController>(
//       builder: (controller) {
//         return Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Form(
//             key: controller.loginFormKey,
//             child: Column(
//               children: [
//                 FadeInAnimation(
//                   delay: 0.9,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () => controller.changeColorPrincipal(),
//                         child: Container(
//                           padding: const EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.black, width: 1),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text('Color Principal',
//                                   style: TextStyle(fontSize: 16)),
//                               Obx(
//                                 () => Container(
//                                   width: 80,
//                                   height: 24,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.rectangle,
//                                     color: controller.colorPrincipal.value,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInAnimation(
//                   delay: 1.3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () => controller.changeColorSecundario(),
//                         child: Container(
//                           padding: const EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.black, width: 1),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text('Color Secundario',
//                                   style: TextStyle(fontSize: 16)),
//                               Obx(
//                                 () => Container(
//                                   width: 80,
//                                   height: 24,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.rectangle,
//                                     color: controller.colorSecundario.value,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInAnimation(
//                   delay: 1.7,
//                   child: CustomTextFormField(
//                     label: 'Número de decimales',
//                     controller: controller.numeroDecimalController,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 FadeInAnimation(
//                   delay: 2.1,
//                   child: CustomElevatedButton(
//                     message: "Guardar",
//                     function: () => controller.guardarPreferencias(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
