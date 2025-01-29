import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable_plus_plus/flutter_slidable_plus_plus.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/screen/nutricion/controller.dart';
import 'package:macrolife/screen/nutricion/screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget caloriasHome(double caloriasPorcentaje) {
  return Stack(
    children: [
      Stack(
        children: [
          CircularPercentIndicator(
            radius: 55.0,
            lineWidth: 12.0,
            animation: true,
            percent: caloriasPorcentaje,
            center: Image.asset(
              'assets/icons/icono_flama_original_54x54_activo.png',
              width: 25,
              color: blackTheme_,
            ),
            progressColor: blackTheme_,
            backgroundColor: greyTheme_,
            widgetIndicator: caloriasPorcentaje == 0.0
                ? const Center()
                : Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: blackTheme_,
                          )),
                    ),
                  ),
          ),
          caloriasPorcentaje == 0
              ? const SizedBox()
              : CircularPercentIndicator(
                  radius: 55.0,
                  lineWidth: 12.0,
                  animation: true,
                  percent: 0,
                  progressColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  widgetIndicator: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: blackTheme_,
                          )),
                    ),
                  ),
                ),
        ],
      ),
    ],
  );
}

// class NutritionWidget extends StatelessWidget {
//   final AlimentoModel nutritionInfo;
//   const NutritionWidget({super.key, required this.nutritionInfo});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => NutricionScreen(alimento: nutritionInfo));
//       },
//       child: Slidable(
//         key: const ValueKey(0),
//         endActionPane: ActionPane(
//           extentRatio: 0.29,
//           motion: ScrollMotion(),
//           children: [
//             SlidableAction(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(16),
//                 bottomRight: Radius.circular(16),
//               ),
//               onPressed: (context) {
//                 final NutricionController controller =
//                     Get.put((NutricionController()));
//                 controller.alimento.value = nutritionInfo;
//                 controller.deleteAlimento();
//               },
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               icon: Icon(
//                 Icons.delete,
//                 color: Colors.white,
//               ),
//               label: 'Eliminar',
//             ),
//           ],
//         ),
//         child: Container(
//           height: 120,
//           decoration: BoxDecoration(
//             color: whiteTheme_,
//             borderRadius: BorderRadius.circular(16.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.08),
//                 blurRadius: 4.0,
//                 offset: Offset(1, 1),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (nutritionInfo.imageUrl != null)
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         bottomRight: Radius.circular(16.0),
//                         topRight: Radius.circular(16.0),
//                         topLeft: Radius.circular(16.0),
//                         bottomLeft: Radius.circular(16.0),
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: '${nutritionInfo.imageUrl}',
//                         width: 120,
//                         height: 120,
//                         fit: BoxFit
//                             .fitWidth, // Ajusta la imagen al ancho sin distorsionar
//                         alignment: Alignment.center,
//                         progressIndicatorBuilder: (context, url, progress) =>
//                             CircularProgressIndicator.adaptive(),
//                         errorWidget: (context, url, error) => Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             spacing: 5,
//                             children: [
//                               Icon(
//                                 Icons.error,
//                                 color: Colors.red,
//                               ),
//                               Text(
//                                 'Error al cargar la imagen',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 11.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ), // Widget de error
//                       ),
//                     ),
//                   SizedBox(
//                     height: 200,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         spacing: 10,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox.shrink(),
//                           SizedBox(
//                             width: Get.width - 233,
//                             child: Text(
//                               FuncionesGlobales.capitalize(
//                                   nutritionInfo.name ?? ''),
//                               style: const TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               overflow: TextOverflow
//                                   .ellipsis, // Muestra tres puntos cuando el texto no cabe
//                               maxLines: 1, // Limita a una línea
//                             ),
//                           ),
//                           Row(
//                             spacing: 8,
//                             children: [
//                               Image.asset(
//                                 'assets/icons/icono_flama_original_54x54_activo.png',
//                                 width: 15,
//                                 height: 15,
//                               ),
//                               Text(
//                                 '${nutritionInfo.calories} calorías',
//                                 style: TextStyle(
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             spacing: 12,
//                             children: [
//                               _buildNutritionItem(
//                                 'assets/icons/icono_filetecarne_90x69_nuevo_1.png',
//                                 '${nutritionInfo.protein}g', // Usamos el parámetro de proteínas
//                               ),
//                               _buildNutritionItem(
//                                 'assets/icons/icono_panintegral_amarillo_76x70_nuevo_1.png',
//                                 '${nutritionInfo.carbs}g', // Usamos el parámetro de carbohidratos
//                               ),
//                               _buildNutritionItem(
//                                 'assets/icons/icono_almedraazul_74x70_nuevo_1.png',
//                                 '${nutritionInfo.fats}g', // Usamos el parámetro de grasas
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 top: 10,
//                 right: 0,
//             child: Container(
//               padding: EdgeInsets.all(5),
//               margin: EdgeInsets.only(top: 10, right: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: greyTheme_,
//               ),
//               child: Text(
//                 '${nutritionInfo.time}',
//                 style: TextStyle(fontSize: 10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// );
//   }

//   Widget _buildNutritionItem(String iconUrl, String value) {
//     return Row(
//       spacing: 8,
//       children: [
//         Image.asset(
//           iconUrl,
//           width: 15,
//           height: 15,
//         ),
//         Text(value, style: TextStyle(fontSize: 13)),
//       ],
//     );
//   }
// }

class NutritionWidget extends StatelessWidget {
  final AlimentoModel nutritionInfo;
  const NutritionWidget({super.key, required this.nutritionInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NutricionScreen(alimento: nutritionInfo));
      },
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          extentRatio: 0.29,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              onPressed: (context) {
                final NutricionController controller =
                    Get.put((NutricionController()));
                controller.alimento.value = nutritionInfo;
                controller.deleteAlimento();
              },
              backgroundColor: blackTheme_,
              foregroundColor: whiteTheme_,
              icon: Icon(
                Icons.delete,
                color: whiteTheme_,
              ),
              label: 'Eliminar',
            ),
          ],
        ),
        child: Container(
          height: 120,
          width: Get.width,
          decoration: BoxDecoration(
            color: whiteTheme_,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4.0,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              if (nutritionInfo.imageUrl != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${nutritionInfo.imageUrl}',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          Text(
                            'Error al cargar la imagen',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ), // Widget de error
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 70,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 10, top: 8, bottom: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: greyTheme_,
                        ),
                        child: Text(
                          '${nutritionInfo.time}',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: blackThemeText),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 5),
                      width: Get.width - 200,
                      child: Text(
                        FuncionesGlobales.capitalize(nutritionInfo.name ?? ''),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: blackThemeText,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        spacing: 8,
                        children: [
                          Image.asset(
                            'assets/icons/icono_flama_original_54x54_activo.png',
                            width: 23,
                            height: 23,
                            color: blackTheme_,
                          ),
                          Text(
                            '${nutritionInfo.calories} calorías',
                            style: TextStyle(
                              color: blackTheme_,
                              fontSize: 23.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
