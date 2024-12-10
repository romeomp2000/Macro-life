import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fep/helpers/usuario_controller.dart';
import 'package:fep/models/alimento.model.dart';
import 'package:fep/screen/home/controller.dart';
import 'package:fep/screen/nutricion/screen.dart';
import 'package:fep/widgets/NutrientIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController controllerUsuario = Get.find();

    final WeeklyCalendarController controller =
        Get.put(WeeklyCalendarController());
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://macrolife.app/images/app/home/background_1125x2436_uno.jpg', // URL de tu imagen
          ),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://macrolife.app/images/app/logo/logo_macro_life.png',
                      width: 155,
                    ),
                    GestureDetector(
                      onTap: () => controller.onRachaDias(),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 7),
                            CachedNetworkImage(
                              imageUrl:
                                  'https://macrolife.app/images/app/home/icono_flama_chica_52x52_original.png',
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
                const SizedBox(height: 15),
                calendario(controller),
                GestureDetector(
                  onTap: () => Get.toNamed('/objetivos'),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: Get.width - 40,
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Text(
                                  '${controllerUsuario.macronutrientes.value.caloriasRestantes ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Text(
                                'Calorías restantes',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          // Círculo con icono de fuego
                          Obx(
                            () => CircularPercentIndicator(
                              radius: 55.0,
                              lineWidth: 8.0,
                              percent: controllerUsuario
                                      .macronutrientes.value.caloriasPorcentaje
                                      ?.toDouble() ??
                                  0.0,
                              center: const Icon(Icons.local_fire_department),
                              progressColor: Colors.black, // Color del progreso
                              backgroundColor:
                                  Colors.black12, // Color del fondo del círculo
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Indicador de Proteína
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
                          color: Colors.red,
                          icon:
                              'https://macrolife.app/images/app/home/iconografia_metas_28x28_proteinas.png',
                        ),
                      ),
                    ),
                    // Indicador de Carbohidratos
                    GestureDetector(
                      onTap: () => Get.toNamed('/objetivos'),
                      child: Obx(
                        () => NutrientIndicator(
                          amount: (controllerUsuario.macronutrientes.value
                                  .carbohidratosRestante ??
                              0),
                          nutrient: "Carbohidratos",
                          percent: controllerUsuario
                                  .macronutrientes.value.caloriasPorcentaje
                                  ?.toDouble() ??
                              0.0,
                          color: Colors.orange,
                          icon:
                              'https://macrolife.app/images/app/home/iconografia_metas_28x28_carbohidratos.png',
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
                          color: Colors.blueAccent,
                          icon:
                              'https://macrolife.app/images/app/home/iconografia_metas_28x28_grasas.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Obx(
                  () => controller.alimentosList.length == 0
                      ? Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No has subido ninguna comida',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Comienza a registrar las comidas de hoy tomando una foto rápido',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 70,
                              bottom: -30,
                              child: Image.network(
                                'https://macrolife.app/images/app/home/flecha_comida_113x149_negro.png',
                                width: 40,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(() {
                  return SingleChildScrollView(
                    // Permite que el contenido sea desplazable
                    child: Column(
                      // Se puede usar Column para manejar el tamaño dinámico
                      children: [
                        if (controller.loader.value)
                          const LinearProgressIndicator(),
                        for (var alimento in controller.alimentosList)
                          NutritionWidget(nutritionInfo: alimento),
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

  SizedBox calendario(WeeklyCalendarController controller) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: controller.pageController,
        reverse: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          DateTime weekStart = controller.getWeekStartDate(index);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (dayIndex) {
              DateTime day = weekStart.add(Duration(days: dayIndex));
              bool isFutureDay =
                  day.isAfter(DateTime.now()); // Verificar si el día es futuro

              return GestureDetector(
                onTap: () {
                  if (!isFutureDay) {
                    controller.today.value = day;
                    controller.cargaAlimentos();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Obx(() {
                    return Column(
                      children: [
                        DottedBorder(
                          color: controller.today.value == day
                              ? Colors.black
                              : Colors.black26,
                          borderType: BorderType.Circle,
                          dashPattern: const [3, 3],
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
                                color: controller.today.value == day
                                    ? Colors.black
                                    : Colors.black54,
                                fontWeight: controller.today.value == day
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Número del día sin borde ni fondo
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: controller.today.value == day
                                ? Colors
                                    .black // Color del número cuando está seleccionado
                                : Colors.black26,
                            fontWeight: controller.today.value == day
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

class NutritionWidget extends StatelessWidget {
  final AlimentoModel nutritionInfo;

  // Constructor con un solo parámetro
  const NutritionWidget({super.key, required this.nutritionInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NutricionScreen(alimento: nutritionInfo));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            // Imagen de la izquierda
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              ),
              child: Image.network(
                nutritionInfo.imageUrl,
                width: 135,
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            nutritionInfo
                                .name, // Usamos el parámetro del nombre
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                7.0), // Bordes redondeados
                          ),
                          child: Text(
                            nutritionInfo
                                .time, // Usamos el parámetro de la hora
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://macrolife.app/images/app/home/icono_flama_chica_negra_48x48_original.png', // Ícono de calorías
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${nutritionInfo.calories} calorías', // Usamos el parámetro de las calorías
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildNutritionItem(
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_proteinas.png', // Ícono de proteínas
                          '${nutritionInfo.protein}g', // Usamos el parámetro de proteínas
                        ),
                        _buildNutritionItem(
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_carbohidratos.png', // Ícono de carbohidratos
                          '${nutritionInfo.carbs}g', // Usamos el parámetro de carbohidratos
                        ),
                        _buildNutritionItem(
                          'https://macrolife.app/images/app/home/iconografia_metas_28x28_grasas.png', // Ícono de grasas
                          '${nutritionInfo.fats}g', // Usamos el parámetro de grasas
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String iconUrl, String value) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: iconUrl,
          width: 15,
          height: 15,
        ),
        const SizedBox(width: 8.0),
        Text(value),
        const SizedBox(width: 10),
      ],
    );
  }
}
