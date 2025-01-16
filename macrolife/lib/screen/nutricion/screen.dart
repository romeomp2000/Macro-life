import 'package:cached_network_image/cached_network_image.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/models/alimento.model.dart';
import 'package:macrolife/screen/IngredientesEditar/screen.dart';
import 'package:macrolife/screen/IngredientesEditarNombre/screen.dart';
import 'package:macrolife/screen/home/controller.dart';
import 'package:macrolife/screen/nutricion/controller.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';
import 'package:macrolife/widgets/puntuacion_salud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';

class NutricionScreen extends StatelessWidget {
  final AlimentoModel alimento;
  const NutricionScreen({super.key, required this.alimento});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NutricionController());
    final WeeklyCalendarController controllerCalendario = Get.find();

    controller.alimento.value = alimento;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (controller.alimento.value.imageUrl != null)
            CachedNetworkImage(
              imageUrl: controller.alimento.value.imageUrl ?? '',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              width: Get.width,
              height: 550,
            ),
          if (controller.alimento.value.imageUrl != null)
            DraggableScrollableSheet(
              snap: false,
              initialChildSize: 0.63,
              minChildSize: 0.63,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return contenido(
                  scrollController: scrollController,
                  controller: controller,
                  controllerCalendario: controllerCalendario,
                );
              },
            )
          else
            contenido(
              scrollController: ScrollController(),
              controller: controller,
              controllerCalendario: controllerCalendario,
            ),
          Positioned(
            top: Get.height - 94,
            child: Container(
              decoration: const BoxDecoration(
                border:
                    Border.fromBorderSide(BorderSide(color: Colors.black12)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: Get.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/icono_inteligencia_artificial_120x120_negro.png',
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                // Usar Wrap para manejar el texto largo
                                const Text(
                                  'Corregir\n resultados',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                  softWrap:
                                      true, // Habilitar el ajuste de línea
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // controller.actualizarComidaAlimento();
                            controller.editarAlimento();
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: IconButton(
                        iconSize: 23,
                        color: Colors.white,
                        icon: const Icon(Icons.keyboard_backspace),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const Text(
                      'Nutrición',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey[400],
                        //     borderRadius:
                        //         const BorderRadius.all(Radius.circular(30)),
                        //   ),
                        //   child: IconButton(
                        //     iconSize: 23,
                        //     color: Colors.white,
                        //     icon: const Icon(Icons.ios_share),
                        //     onPressed: () => Get.back(),
                        //   ),
                        // ),
                        // const SizedBox(width: 8),
                        PullDownButton(
                          routeTheme: PullDownMenuRouteTheme(
                            borderRadius: BorderRadius.circular(15),
                            shadow: BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(
                                1.0,
                                1.0,
                              ),
                              blurRadius: 15.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                          ),
                          itemBuilder: (context) => [
                            PullDownMenuItem(
                              onTap: () {
                                reportarComida(controller);
                                // Lógica para Reportar comida
                              },
                              title: 'Reportar comida',
                              icon: Icons.comment_outlined,
                            ),
                            PullDownMenuItem(
                              onTap: () {
                                controller.deleteAlimento();
                              },
                              title: 'Eliminar alimento',
                              isDestructive: true,
                              icon: Icons.delete_outline_outlined,
                            ),
                          ],
                          buttonBuilder: (context, showMenu) => CupertinoButton(
                            onPressed: showMenu,
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            padding: EdgeInsets.all(15),
                            child: const Icon(
                              Icons.more_horiz_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container contenido({
    ScrollController? scrollController,
    required NutricionController controller,
    required WeeklyCalendarController controllerCalendario,
  }) {
    return Container(
      margin: EdgeInsets.only(top: scrollController == null ? 0 : 70),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        controller: scrollController,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Obx(
                    () => IconButton(
                      onPressed: () => controller.actualizarFavoritoAlimento(),
                      icon: controller.alimento.value.favorito == true
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_border),
                    ),
                  ),
                  Text(controller.alimento.value.time ?? '')
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () async {
                      final nombreRaname = await Get.to(
                        () => IngredienteEditarNombreScreen(
                          nombre: controller.alimento.value.name ?? '',
                          id: controller.alimento.value.id ?? '',
                        ),
                      );

                      if (nombreRaname != null) {
                        controller.alimento.value.name = nombreRaname!;
                        controller.alimento.refresh();
                      }
                    },
                    child: Obx(
                      () => Text(
                        '${controller.alimento.value.name}${controller.alimento.value.porcion != 1 ? ' x${controller.alimento.value.porcion}' : ''}',
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(20), // Borde redondeado
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (controller.alimento.value.porcion == 0.0) return;
                          if (controller.alimento.value.porcion == 0.25) return;

                          controller.alimento.update((alimento) {
                            if (alimento != null) {
                              double caloriasUnitaria =
                                  (controller.alimento.value.calories ?? 0) /
                                      (alimento.porcion ?? 0);

                              double proteinaUnitaria =
                                  (controller.alimento.value.calories ?? 0) /
                                      (alimento.porcion ?? 0);

                              double carbohidratosUnitaria =
                                  (controller.alimento.value.carbs ?? 0) /
                                      (alimento.porcion ?? 0);

                              double grasaUnitaria =
                                  (controller.alimento.value.fats ?? 0) /
                                      (alimento.porcion ?? 0);

                              if (alimento.porcion! == 0.25) {
                                alimento.porcion = alimento.porcion! - 0.25;
                              } else if (alimento.porcion! == 0.5) {
                                alimento.porcion = alimento.porcion! - 0.25;
                              } else {
                                alimento.porcion = alimento.porcion! - 0.5;
                              }

                              double nuevoCaloria =
                                  (alimento.porcion ?? 0) * (caloriasUnitaria);

                              double nuevoProteina =
                                  (alimento.porcion ?? 0) * (proteinaUnitaria);

                              double nuevoCarbohidratoss =
                                  (alimento.porcion ?? 0) *
                                      (carbohidratosUnitaria);

                              double nuevoGrasas =
                                  (alimento.porcion ?? 0) * (grasaUnitaria);

                              controller.alimento.value.calories =
                                  nuevoCaloria.toInt();

                              controller.alimento.value.protein =
                                  nuevoProteina.toInt();

                              controller.alimento.value.carbs =
                                  nuevoCarbohidratoss.toInt();

                              controller.alimento.value.fats =
                                  nuevoGrasas.toInt();
                            }
                          });
                        },
                        iconSize: 18,
                      ),
                      Obx(
                        () => Text(
                          '${controller.alimento.value.porcion}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          controller.alimento.update((alimento) {
                            double caloriasUnitaria =
                                (controller.alimento.value.calories ?? 0) /
                                    (alimento?.porcion ?? 0);

                            double proteinaUnitaria =
                                (controller.alimento.value.calories ?? 0) /
                                    (alimento?.porcion ?? 0);

                            double carbohidratosUnitaria =
                                (controller.alimento.value.carbs ?? 0) /
                                    (alimento?.porcion ?? 0);

                            double grasaUnitaria =
                                (controller.alimento.value.fats ?? 0) /
                                    (alimento?.porcion ?? 0);

                            if (alimento != null) {
                              if (alimento.porcion! == 0.25) {
                                alimento.porcion = alimento.porcion! + 0.25;
                              } else if (alimento.porcion! == 0.5) {
                                alimento.porcion = alimento.porcion! + 0.5;
                              } else {
                                alimento.porcion = alimento.porcion! + 0.5;
                              }

                              double nuevoCaloria =
                                  (alimento.porcion ?? 0) * (caloriasUnitaria);

                              double nuevoProteina =
                                  (alimento.porcion ?? 0) * (proteinaUnitaria);

                              double nuevoCarbohidratoss =
                                  (alimento.porcion ?? 0) *
                                      (carbohidratosUnitaria);

                              double nuevoGrasas =
                                  (alimento.porcion ?? 0) * (grasaUnitaria);

                              controller.alimento.value.calories =
                                  nuevoCaloria.toInt();

                              controller.alimento.value.protein =
                                  nuevoProteina.toInt();

                              controller.alimento.value.carbs =
                                  nuevoCarbohidratoss.toInt();

                              controller.alimento.value.fats =
                                  nuevoGrasas.toInt();
                              // controller.editarAlimento();
                            }
                          });
                        },
                        iconSize: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CupertinoListTile(
                title: const Text('Calorías'),
                subtitle: Obx(
                  () => Text(
                    '${controller.alimento.value.calories}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing: const Icon(
                  Icons.edit,
                  color: Colors.black87,
                ),
                leadingSize: 25,
                leading: Image.asset(
                  'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                  width: Get.width,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => NutritionalInfoRow(
                    icon: Image.asset(
                      'assets/icons/icono_filetecarne_90x69_nuevo.png',
                      width: 13,
                    ),
                    label: 'Proteína',
                    value: '${controller.alimento.value.protein}g',
                  ),
                ),
                Obx(
                  () => NutritionalInfoRow(
                    icon: Image.asset(
                      'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
                      width: 13,
                    ),
                    label: 'Carbohidratos',
                    value: '${controller.alimento.value.carbs}g',
                  ),
                ),
                Obx(
                  () => NutritionalInfoRow(
                    icon: Image.asset(
                      'assets/icons/icono_almedraazul_74x70_nuevo.png',
                      width: 13,
                    ),
                    label: 'Grasas',
                    value: '${controller.alimento.value.fats}g',
                  ),
                ),
              ],
            ),
            if (controller.alimento.value.puntuacionSalud?.score != 0)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12, // Color del borde
                    width: 1.2, // Grosor del borde
                  ),
                  borderRadius: BorderRadius.circular(
                      15), // Borde redondeado para todo el contenedor
                ),
                child: CupertinoListTile(
                  onTap: () => Get.to(
                    () => PuntuacionSaludScreen(
                        puntuacion: controller.alimento.value.puntuacionSalud!),
                  ),
                  title: const Text('Puntuación de salud'),
                  subtitle: LinearProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    value: ((controller.alimento.value.puntuacionSalud?.score ??
                                0) as num)
                            .toDouble() *
                        0.1,
                    color: Colors.yellow,
                  ),
                  trailing: Text(
                    '${controller.alimento.value.puntuacionSalud?.score}/10',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  leadingSize: 25,
                  leading: Image.asset(
                    'assets/icons/icono_corazonrosa_50x50_nuevo.png',
                  ),
                ),
              ),
            if (controller.alimento.value.ingredientes?.isNotEmpty ?? false)
              const Text(
                'Ingredientes',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (controller.alimento.value.ingredientes != null)
                    for (var ingrediente
                        in controller.alimento.value.ingredientes!)
                      GestureDetector(
                        onTap: () async {
                          if (ingrediente.eliminado == true) {
                            try {
                              final apiService = ApiService();

                              final response = await apiService.fetchData(
                                'alimentos/agregar-ingrediente/${ingrediente.id}',
                                body: {},
                                method: Method.PUT,
                              );

                              final AlimentoModel alimentoResponse =
                                  AlimentoModel.fromJson(response['alimento']);

                              controller.alimento.value = alimentoResponse;
                              controller.alimento.refresh();

                              controllerCalendario.cargaAlimentos();
                            } catch (e) {
                              print(e);
                            }
                          } else {
                            final respuesta = await Get.to(
                              () => IngredienteEditarScreen(
                                ingrediente: ingrediente,
                              ),
                            );

                            if (respuesta != null) {
                              AlimentoModel alimentoRespuesta =
                                  respuesta['alimento'];

                              controller.alimento.value = alimentoRespuesta;
                              controllerCalendario.cargaAlimentos();
                              controller.alimento.refresh();
                            }
                          }
                        },
                        child: NutritionalInfoRow(
                          label: '${ingrediente.nombre}',
                          value: '${ingrediente.calorias?.floor()}g',
                          eliminado: ingrediente.eliminado,
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  void reportarComida(NutricionController controller) {
    Get.dialog(
      Dialog(
        elevation: 0,
        alignment: Alignment.bottomCenter,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reportar comida',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  hinttext:
                      '¿Cuál es el problema con este registro de alimento?',
                  focus: true,
                  controller: controller.reportarComidaController,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.reporteAlimento(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Reportar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      width: (Get.width / 3) - 14,
      // height: 70,
      padding: eliminado == true
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: eliminado == true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11.5),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
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
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (icon != null)
                      Container(color: Colors.grey[100], child: icon),
                    Flexible(
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 11.5),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.edit,
                      size: 12,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
