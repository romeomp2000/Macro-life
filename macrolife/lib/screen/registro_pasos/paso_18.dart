import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/EditarNutrientes/screen.dart';
import 'package:macrolife/screen/registro_pasos/controller.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';

Widget paso_18(RegistroPasosController controller) {
  final UsuarioController controllerUsuario = Get.put(UsuarioController());
  return SizedBox(
    child: Obx(
      () => Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 7,
            ),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/icons/icono_configuracion_lista_146x146_activo.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  '¡Felicidades, tu plan personalizado está listo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Tu objetivo es: ',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Text(
                    (controller.peso.value - controller.pesoDeseado.value)
                                .abs() ==
                            0
                        ? 'Mantener tu peso'
                        : '${controller.objetivo.value == 'Aumentar' ? 'Ganando' : 'Perdiendo'} ${(controller.peso.value - controller.pesoDeseado.value).abs()} Kg antes del ${controllerUsuario.usuario.value.fechaMetaObjetivo ?? ''}',
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recomendación diaria',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Recomendaciones(
                                imagen:
                                    'assets/icons/icono_calorias_outline_120x120_activo.png',
                                title: 'Calorías',
                                puntaje:
                                    '${controllerUsuario.usuario.value.macronutrientesDiario?.value.calorias ?? 0}',
                                onPressed: () {
                                  Get.to(
                                    () => EditarNutrientesScreen(
                                      textField: 'Calorías',
                                      // color: Colors.black,
                                      imageUrl:
                                          'assets/icons/icono_calorias_outline_120x120_activo.png',
                                      title: 'Editar Objetivo de Calorías',
                                      initialValue: controllerUsuario
                                              .usuario
                                              .value
                                              .macronutrientesDiario
                                              ?.value
                                              .calorias ??
                                          0,
                                      onSave: (value) {
                                        controllerUsuario
                                            .usuario
                                            .value
                                            .macronutrientesDiario
                                            ?.value
                                            .calorias = value;

                                        Get.back();
                                        controllerUsuario.usuario.refresh();
                                      },
                                    ),
                                  );
                                }),
                          ),
                          Obx(
                            () => Recomendaciones(
                              imagen:
                                  'assets/icons/icono_panintegral_outline_79x79_activo.png',
                              title: 'Carbohidratos',
                              puntaje:
                                  '${controllerUsuario.usuario.value.macronutrientesDiario?.value.carbohidratos ?? 0}g',
                              onPressed: () {
                                Get.to(
                                  () => EditarNutrientesScreen(
                                    textField: 'Carbohidratos',
                                    // color: Colors.orange,
                                    imageUrl:
                                        'assets/icons/icono_panintegral_outline_79x79_activo.png',
                                    title: 'Editar Objetivo de Carbohidratos',
                                    initialValue: controllerUsuario
                                            .usuario
                                            .value
                                            .macronutrientesDiario
                                            ?.value
                                            .carbohidratos ??
                                        0,
                                    onSave: (value) {
                                      controllerUsuario
                                          .usuario
                                          .value
                                          .macronutrientesDiario
                                          ?.value
                                          .carbohidratos = value;

                                      Get.back();
                                      controllerUsuario.usuario.refresh();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Recomendaciones(
                                imagen:
                                    'assets/icons/icono_filetecarne_outline_93x93_activo.png',
                                title: 'Proteínas',
                                puntaje:
                                    '${controllerUsuario.usuario.value.macronutrientesDiario?.value.proteina ?? 0}g',
                                onPressed: () {
                                  Get.to(
                                    () => EditarNutrientesScreen(
                                      textField: 'Proteínas',
                                      // color: Colors.red,
                                      imageUrl:
                                          'assets/icons/icono_filetecarne_outline_93x93_activo.png',
                                      title: 'Editar Objetivo de Proteínas',
                                      initialValue: controllerUsuario
                                              .usuario
                                              .value
                                              .macronutrientesDiario
                                              ?.value
                                              .proteina ??
                                          0,
                                      onSave: (value) {
                                        controllerUsuario
                                            .usuario
                                            .value
                                            .macronutrientesDiario
                                            ?.value
                                            .proteina = value;

                                        Get.back();
                                        controllerUsuario.usuario.refresh();
                                      },
                                    ),
                                  );
                                }),
                          ),
                          Obx(
                            () => Recomendaciones(
                              imagen:
                                  'assets/icons/icono_almendra_outline_78x78_activo.png',
                              title: 'Grasas',
                              puntaje:
                                  '${controllerUsuario.usuario.value.macronutrientesDiario?.value.grasas ?? 0}g',
                              onPressed: () {
                                Get.to(
                                  () => EditarNutrientesScreen(
                                    textField: 'Grasas',
                                    imageUrl:
                                        'assets/icons/icono_almendra_outline_78x78_activo.png',
                                    title: 'Editar Objetivo de Grasas',
                                    initialValue: controllerUsuario
                                            .usuario
                                            .value
                                            .macronutrientesDiario
                                            ?.value
                                            .grasas ??
                                        0,
                                    onSave: (value) {
                                      controllerUsuario
                                          .usuario
                                          .value
                                          .macronutrientesDiario
                                          ?.value
                                          .grasas = value;

                                      Get.back();
                                      controllerUsuario.usuario.refresh();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 246, 246, 246)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/icono_logros_alimenticios_outline_63x63_4.png',
                                  width: 20,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 8),
                                    const Text('Puntuación de salud'),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: Get.width - 110,
                                      child: LinearProgressIndicator(
                                        value: controllerUsuario.usuario.value
                                                .puntuacionSalud! /
                                            10,
                                        color: Colors.black,
                                        backgroundColor: Colors.grey[100],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Text(
                                '${controllerUsuario.usuario.value.puntuacionSalud!}/10',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 75),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                // color: Colors.grey[100],
                // width: Get.width - 20,
                child: buttonTest('Siguiente', () {
                  FuncionesGlobales.actualizarMacronutrientes();
                  Get.offAllNamed('/pago');
                }, true)
                //  CustomElevatedButton(
                //   message: 'Siguiente',
                //   function: () {
                //     FuncionesGlobales.actualizarMacronutrientes();
                //     Get.offAllNamed('/layout');
                //   },
                // ),
                ),
          )
        ],
      ),
    ),
  );
}
