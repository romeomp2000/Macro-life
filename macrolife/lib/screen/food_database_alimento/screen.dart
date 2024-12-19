import 'package:macrolife/models/alimento.psd.dart';
import 'package:macrolife/screen/IngredientesEditarNombre/screen.dart';
import 'package:macrolife/screen/food_database_alimento/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodDatabaseAlimentoScreen extends StatelessWidget {
  final AlimentosPSD alimento;

  const FoodDatabaseAlimentoScreen({super.key, required this.alimento});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodDatabaseAlimentoController());

    controller.alimento?.value = alimento;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actions: [
        //   Container(
        //     margin: EdgeInsets.all(5),
        //     decoration: BoxDecoration(
        //       color: Colors.grey[400],
        //       borderRadius: const BorderRadius.all(Radius.circular(30)),
        //     ),
        //     child: PopupMenuButton(
        //       icon: const Icon(
        //         Icons.more_horiz,
        //         size: 20,
        //         color: Colors.white,
        //       ),
        //       onSelected: (value) {
        //         // Acción cuando se selecciona una opción
        //         if (value == 'Reportar comida') {
        //           Get.dialog(
        //             Dialog(
        //               elevation: 0,
        //               alignment: Alignment.bottomCenter,
        //               backgroundColor: Colors.transparent,
        //               child: Center(
        //                 child: Container(
        //                   width: Get.width,
        //                   padding: EdgeInsets.all(10),
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(20),
        //                     color: Colors.white,
        //                   ),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       Text(
        //                         'Reportar comida',
        //                         style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                           fontSize: 24,
        //                         ),
        //                       ),
        //                       const SizedBox(height: 25),
        //                       CustomTextFormField(
        //                         hinttext:
        //                             '¿Cuál es el problema con este registro de alimento?',
        //                         focus: true,
        //                         controller: controller.reportarComidaController,
        //                       ),
        //                       const SizedBox(height: 25),
        //                       Row(
        //                         children: [
        //                           Expanded(
        //                             child: ElevatedButton(
        //                               onPressed: () => Get.back(),
        //                               style: ElevatedButton.styleFrom(
        //                                 backgroundColor: Colors.white,
        //                                 foregroundColor: Colors.black,
        //                                 side: const BorderSide(
        //                                     color: Colors.black),
        //                                 shape: RoundedRectangleBorder(
        //                                   borderRadius:
        //                                       BorderRadius.circular(20),
        //                                 ),
        //                               ),
        //                               child: const Text('Cancelar'),
        //                             ),
        //                           ),
        //                           const SizedBox(width: 10),
        //                           Expanded(
        //                             child: ElevatedButton(
        //                               onPressed: () =>
        //                                   controller.reporteAlimento(),
        //                               style: ElevatedButton.styleFrom(
        //                                 backgroundColor: Colors.black,
        //                                 foregroundColor: Colors.white,
        //                                 shape: RoundedRectangleBorder(
        //                                   borderRadius:
        //                                       BorderRadius.circular(20),
        //                                 ),
        //                               ),
        //                               child: const Text('Reportar'),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           );
        //           // Lógica para Reportar comida
        //         }
        //       },
        //       itemBuilder: (BuildContext context) => [
        //         const PopupMenuItem<String>(
        //           value: 'Reportar comida',
        //           child: Row(
        //             children: [
        //               Text('Reportar comida'),
        //               SizedBox(width: 10),
        //               Icon(Icons.comment_outlined),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
        leading: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: IconButton(
            iconSize: 23,
            color: Colors.white,
            icon: const Icon(Icons.keyboard_backspace),
            onPressed: () => Get.back(),
          ),
        ),
        title: Text('Alimento seleccionado'),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            controller.actualizarComidaAlimento('${alimento.id}');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Guardar'),
          ),
        ),
      ),
      body: Container(
        // padding:
        //     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final nombreRaname = await Get.to(
                          () => IngredienteEditarNombreScreen(
                            nombre: controller.alimento?.value?.nombre ?? '',
                            id: controller.alimento?.value?.id ?? '',
                          ),
                        );

                        if (nombreRaname != null) {
                          controller.alimento?.value?.nombre = nombreRaname!;
                        }
                      },
                      child: Obx(
                        () => Text(
                          '${controller.alimento?.value?.nombre}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12, // Color del borde
                    width: 1.0, // Grosor del borde
                  ),
                  borderRadius: BorderRadius.circular(
                      15), // Borde redondeado para todo el contenedor
                ),
                child: CupertinoListTile(
                  title: const Text('Calorías'),
                  subtitle: Obx(
                    () => Text(
                      '${controller.alimento?.value?.calorias}g',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // trailing: const Icon(
                  //   Icons.edit,
                  //   color: Colors.blue,
                  // ),
                  leadingSize: 40,
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Borde redondeado
                      color: Colors.grey[100],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/icono_calorias_negro_99x117_nuevo.png', // Ícono de calorías
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NutritionalInfoRow(
                    icon: Image.asset(
                      'assets/icons/icono_filetecarne_90x69_nuevo.png',
                      width: 13,
                    ),
                    label: 'Proteína',
                    value: '${alimento.proteina}g',
                  ),
                  NutritionalInfoRow(
                    icon: Image.asset(
                      'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
                      width: 13,
                    ),
                    label: 'Carbohidratos',
                    value: '${alimento.carbohidratos}g',
                  ),
                  NutritionalInfoRow(
                    icon: Image.asset(
                      'assets/icons/icono_almedraazul_74x70_nuevo.png',
                      width: 13,
                    ),
                    label: 'Grasas',
                    value: '${alimento.grasas}g',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Otros datos nutrimentales',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: controller.alimento?.value?.propiedades.entries
                        .map((entry) {
                      return CupertinoListTile(
                        title: Text(entry.key),
                        trailing: Text(entry.value),
                      );
                    }).toList() ??
                    [
                      // Si `propiedades` es null, muestra una lista vacía.
                      CupertinoListTile(
                        title: Text('No hay propiedades disponibles'),
                        trailing: Text(''),
                      ),
                    ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NutritionalInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? icon;
  final bool? eliminado;

  const NutritionalInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.eliminado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Get.width / 3) - 16,
      // height: 70,
      padding: eliminado == true
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: eliminado == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                    decoration: TextDecoration
                        .lineThrough, // Hace que el texto aparezca tachado
                  ),
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10))),
                  child: Text(
                    'Añadir',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (icon != null)
                      Container(color: Colors.grey[100], child: icon),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      value,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // const Icon(Icons.edit, size: 12, color: Colors.blue),
                  ],
                ),
              ],
            ),
    );
  }
}
