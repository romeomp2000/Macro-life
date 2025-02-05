import 'dart:io';
import 'package:flutter_slidable_plus_plus/flutter_slidable_plus_plus.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/Entrenamiento.dart';
import 'package:macrolife/screen/correr/controller.dart';
import 'package:macrolife/screen/correr/screen.dart';
import 'package:macrolife/screen/ejercicio_describir/controller.dart';
import 'package:macrolife/screen/ejercicio_describir/screen.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/home/widgetsHome.dart';
import 'package:macrolife/screen/pesas/controller.dart';
import 'package:macrolife/screen/pesas/screen.dart';
import 'package:macrolife/widgets/AnimatedFood.dart';
import 'package:macrolife/widgets/AppleHealth.dart';
import 'package:macrolife/widgets/NutrientIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget puntuaciones(UsuarioController controllerUsuario,
      WeeklyCalendarController controllerCalendario) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed('/objetivos'),
          child: Container(
            margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 0),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: Get.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Obx(
                      () => Text(
                        controllerUsuario.macronutrientes.value
                                        .caloriasRestantes !=
                                    null &&
                                controllerUsuario.macronutrientes.value
                                        .caloriasRestantes! <
                                    0
                            ? '${controllerUsuario.macronutrientes.value.caloriasRestantes!.abs()}'
                            : '${controllerUsuario.macronutrientes.value.caloriasRestantes ?? 0}',
                        style: const TextStyle(
                          fontSize: 34,
                          color: blackTheme_,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Column(
                          children: [
                            if (controllerUsuario.macronutrientes.value
                                        .caloriasQuemadas !=
                                    null &&
                                controllerUsuario.macronutrientes.value
                                        .caloriasQuemadas !=
                                    0 &&
                                controllerCalendario.isCaloriasQuemadas.value ==
                                    true)
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: greyTheme_,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: (controllerUsuario.macronutrientes.value
                                                .caloriasQuemadas ??
                                            0) >
                                        1000
                                    ? 76
                                    : 72,
                                child: Row(
                                  spacing: 5,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/icono_cajon_ejercicio_88x88_registrar.png',
                                      width: 12,
                                      color: blackTheme_,
                                    ),
                                    Text(
                                      '+${controllerUsuario.macronutrientes.value.caloriasQuemadas}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: blackThemeText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Text(
                    controllerUsuario.macronutrientes.value.caloriasRestantes !=
                                null &&
                            controllerUsuario
                                    .macronutrientes.value.caloriasRestantes! <
                                0
                        ? 'Calorías más'
                        : 'Calorías restantes',
                    style: TextStyle(
                      fontSize: 14,
                      color: blackThemeText,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1),
                  child: Obx(
                    () => caloriasHome(
                      (controllerUsuario
                                  .macronutrientes.value.caloriasPorcentaje ??
                              0)
                          .toDouble(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 2, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/objetivos'),
                child: Obx(
                  () => NutrientIndicator(
                    amount: (controllerUsuario
                            .macronutrientes.value.proteinaRestantes ??
                        0),
                    nutrient: "Proteína",
                    percent: controllerUsuario
                            .macronutrientes.value.proteinaPorcentaje
                            ?.toDouble() ??
                        0.0,
                    color: redTheme_,
                    icon: 'assets/icons/icono_filetecarne_90x69_nuevo_1.png',
                  ),
                ),
              ),
              // Indicador de Carbohidratos
              GestureDetector(
                onTap: () => Get.toNamed('/objetivos'),
                child: Obx(
                  () => NutrientIndicator(
                    amount: (controllerUsuario
                            .macronutrientes.value.carbohidratosRestante ??
                        0),
                    nutrient: "Carbohidratos",
                    percent: controllerUsuario
                            .macronutrientes.value.carbohidratosPorcentaje
                            ?.toDouble() ??
                        0.0,
                    color: yellowTheme_,
                    icon:
                        'assets/icons/icono_panintegral_amarillo_76x70_nuevo_1.png',
                  ),
                ),
              ),
              // Indicador de Grasa
              GestureDetector(
                onTap: () => Get.toNamed('/objetivos'),
                child: Obx(
                  () => NutrientIndicator(
                    amount: (controllerUsuario
                            .macronutrientes.value.grasasRestantes ??
                        0),
                    nutrient: "Grasa",
                    percent: controllerUsuario
                            .macronutrientes.value.grasasPorcentaje
                            ?.toDouble() ??
                        0.0,
                    color: blueTheme_,
                    icon: 'assets/icons/icono_almedraazul_74x70_nuevo_1.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();
    final AnimatedFoodController controllerAnimatedFood =
        // Get.put(AnimatedFoodController(), permanent: true);
        Get.put(AnimatedFoodController(), permanent: false);

    final WeeklyCalendarController controller =
        Get.put(WeeklyCalendarController(), permanent: false);

    return Container(
      decoration: BoxDecoration(color: backGround),
      height: Get.height,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Image.asset(
                        'assets/icons/logo_macro_life_1125x207.png',
                        width: 155,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onRachaDias(),
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            Image.asset(
                              'assets/icons/icono_rutina_60x60_nuevo.png',
                              width: 20,
                            ),
                            const SizedBox(width: 5),
                            Obx(
                              () => Text(
                                '${controllerUsuario.usuario.value.rachaDias}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                calendario(),
                SizedBox(
                  height: 375,
                  child: PageView(
                    onPageChanged: (value) {
                      if (value == 0) {
                        controller.verAppleHealth.value = false;
                      }
                      if (value == 1) {
                        controller.verAppleHealth.value = true;
                      }
                    },
                    controller: PageController(),
                    children: [
                      puntuaciones(controllerUsuario, controller),
                      if (GetPlatform.isIOS) HealthDataChart()
                    ],
                  ),
                ),
                Platform.isIOS
                    ? Obx(
                        () => Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.verAppleHealth.value == false)
                              Icon(Icons.circle, size: 10)
                            else
                              Icon(Icons.circle_outlined,
                                  color: blackTheme_, size: 10),
                            if (controller.verAppleHealth.value == true)
                              Icon(Icons.circle, size: 10)
                            else
                              Icon(Icons.circle_outlined, size: 10),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                Container(
                  // margin: EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'Registros recientes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      color: blackTheme_,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => controller.alimentosList.isEmpty &&
                          controller.entrenamientosList.isEmpty &&
                          controller.healthDataWorKout.isEmpty &&
                          controllerAnimatedFood.loading.value == false
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '¡No has subido ninguna comida!',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: blackTheme_,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width - 100,
                                      child: Text(
                                        'Comienza a registrar las comidas de tu día tomando una foto rápida',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: blackThemeText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: (Get.width / 2) - 20,
                              bottom: -30,
                              child: Image.asset(
                                'assets/icons/flecha_comida_113x149_negro.png',
                                width: 30,
                                color: blackTheme_,
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                AnimatedFood(),
                Obx(() {
                  return SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var alimento in controller.alimentosList)
                          NutritionWidget(nutritionInfo: alimento),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: [
                        for (var alimento in controller.entrenamientosList)
                          EjercicioWidget(entrenamiento: alimento),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: [
                        for (var exercise in controller.healthDataWorKout)
                          EjercicioAppleHealth(data: exercise)
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container calendario() {
    final WeeklyCalendarController controller = Get.find();

    return Container(
      margin: EdgeInsets.only(top: 7),
      height: 70,
      child: PageView.builder(
        controller: controller.pageController,
        reverse: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          DateTime weekStart = controller.getWeekStartDate(index);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (dayIndex) {
              DateTime day = weekStart.add(Duration(days: dayIndex)).toLocal();
              DateTime dayActual = DateTime.now();
              return GestureDetector(
                onTap: () {
                  if (day.isAfter(dayActual)) {
                    return;
                  }
                  controller.today.value = day;
                  controller.cargaAlimentos();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Obx(() {
                    bool isSelected =
                        controller.isSameDay(controller.today.value, day);

                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? blackTheme_ : blackThemeText,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected ? blackTheme_ : whiteTheme_,
                          ),
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat.E('es')
                                  .format(day)
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : blackThemeText,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Número del día
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: isSelected ? blackTheme_ : blackThemeText,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class SalesData {
  SalesData(DateTime dateTime, String s, double d, int i, int j, int k, int l);
}

class EjercicioWidget extends StatelessWidget {
  final Entrenamiento entrenamiento;
  const EjercicioWidget({super.key, required this.entrenamiento});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (entrenamiento.descripcion != null) {
          Get.to(
            () => EjercicioDescribirScreen(
              entrenamiento: entrenamiento,
              id: entrenamiento.sId,
            ),
          );
          return;
        }

        if (entrenamiento.nombre == 'Levantamiento de pesas') {
          Get.to(
            () => PesasScreen(
              entrenamiento: entrenamiento,
              id: entrenamiento.sId,
            ),
          );
        } else {
          Get.to(
            () => CorrerScreen(
              entrenamiento: entrenamiento,
              id: entrenamiento.sId,
            ),
          );
        }
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
                if (entrenamiento.descripcion != null) {
                  final controller = Get.put(EjercicioDescribirController());
                  controller.eliminarEjercicio(entrenamiento.sId!);
                  return;
                }

                if (entrenamiento.nombre == 'Levantamiento de pesas') {
                  final controller = Get.put(PesasController());
                  controller.eliminarEjercicio(entrenamiento.sId!);
                  return;
                } else {
                  final controller = Get.put(CorrerController());
                  controller.eliminarEjercicio(entrenamiento.sId!);
                  return;
                }
              },
              backgroundColor: blackTheme_,
              foregroundColor: Colors.white,
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              label: 'Eliminar',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: whiteTheme_,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.0,
                  offset: Offset(1, 1),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                entrenamiento.descripcion != null
                    ? 'assets/icons/icono_registrar_ejercicio_solido_180x180_anotar.png'
                    : entrenamiento.nombre == 'Levantamiento de pesas'
                        ? 'assets/icons/icono_registrar_ejercicio_solido_180x180_pesas.png'
                        : 'assets/icons/icono_registrar_ejercicio_solido_180x180_correr.png',
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entrenamiento.nombre}',
                    style: TextStyle(color: blackTheme_),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                        color: blackTheme_,
                        width: 15,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${entrenamiento.calorias} Calorías',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: blackTheme_),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/icono_intensidad_negro_38x24_nuevo.png',
                        width: 15,
                        color: blackTheme_,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Intensidad: ${entrenamiento.intensidad}',
                        style: TextStyle(color: blackTheme_),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 70,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: greyTheme_,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${entrenamiento.time}.',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: blackThemeText),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Image.asset(
                            'assets/icons/icono_cronometro_negro_34x38_nuevo.png',
                            color: blackTheme_,
                            width: 15),
                        SizedBox(width: 8),
                        Text(
                          '${entrenamiento.tiempo} min.',
                          style: TextStyle(fontSize: 10, color: blackTheme_),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EjercicioAppleHealth extends StatelessWidget {
  final WorkOutActivitiesData data;

  const EjercicioAppleHealth({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return
        // Slidable(
        //   key: const ValueKey(0),
        //   endActionPane: ActionPane(
        //     extentRatio: 0.29,
        //     motion: ScrollMotion(),
        //     children: [
        //       SlidableAction(
        //         borderRadius: BorderRadius.only(
        //           topRight: Radius.circular(16),
        //           bottomRight: Radius.circular(16),
        //         ),
        //         onPressed: (context) {
        //           // if (entrenamiento.descripcion != null) {
        //           //   final controller = Get.put(EjercicioDescribirController());
        //           //   controller.eliminarEjercicio(entrenamiento.sId!);
        //           //   return;
        //           // }

        //           // if (entrenamiento.nombre == 'Levantamiento de pesas') {
        //           //   final controller = Get.put(PesasController());
        //           //   controller.eliminarEjercicio(entrenamiento.sId!);
        //           //   return;
        //           // } else {
        //           //   final controller = Get.put(CorrerController());
        //           //   controller.eliminarEjercicio(entrenamiento.sId!);
        //           //   return;
        //           // }
        //         },
        //         backgroundColor: blackTheme_,
        //         foregroundColor: Colors.white,
        //         icon: Icon(
        //           Icons.delete,
        //           color: Colors.white,
        //         ),
        //         label: 'Eliminar',
        //       ),
        //     ],
        //   ),
        //   child:
        Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: whiteTheme_,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: Offset(1, 1),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/icons/health_icon.png',
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width / 2.5,
                child: Text(
                  '${data.nombre}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: blackTheme_),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                    color: blackTheme_,
                    width: 15,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${data.cal} Calorías',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: blackTheme_),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/icons/icono_intensidad_negro_38x24_nuevo.png',
                  //   width: 15,
                  //   color: blackTheme_,
                  // ),
                  Image.asset(
                      'assets/icons/icono_cronometro_negro_34x38_nuevo.png',
                      color: blackTheme_,
                      width: 15),
                  const SizedBox(width: 8),

                  Text(
                    ' ${data.tiempo ?? 0} minutos',
                    style: TextStyle(color: blackTheme_),
                  ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 70,
                margin: const EdgeInsets.only(bottom: 50),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: greyTheme_,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${data.hora}.',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: blackThemeText),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(5),
              //   child: Row(
              //     children: [
              //       Image.asset(
              //           'assets/icons/icono_cronometro_negro_34x38_nuevo.png',
              //           color: blackTheme_,
              //           width: 15),
              //       SizedBox(width: 8),
              //       Text(
              //         '${data.unidad} min.',
              //         style: TextStyle(fontSize: 10, color: blackTheme_),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
