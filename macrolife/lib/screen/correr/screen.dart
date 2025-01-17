import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/models/Ejercicio.dart';
import 'package:macrolife/models/Entrenamiento.dart';
import 'package:macrolife/screen/correr/controller.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CorrerScreen extends StatelessWidget {
  final Entrenamiento? entrenamiento;
  final String? id;
  const CorrerScreen({
    super.key,
    this.entrenamiento,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CorrerController());

    if (id != null) {
      controller.id.value = id ?? '';
      if (entrenamiento?.intensidad == 'Ligero') {
        controller.ejercioSlicer.value = 0.0;
        controller.intensidad.value = Intensidad.ligero;
        controller.ejercicio.value = 'Caminata';
      } else if (entrenamiento?.intensidad == 'Moderado') {
        controller.ejercioSlicer.value = 1.0;
        controller.intensidad.value = Intensidad.moderado;
        controller.ejercicio.value = 'Trotar';
      } else if (entrenamiento?.intensidad == 'Intenso') {
        controller.ejercioSlicer.value = 2.0;
        controller.intensidad.value = Intensidad.intenso;
        controller.ejercicio.value = 'Correr';
      }

      controller.duracion.value = entrenamiento?.tiempo ?? 0;
      controller.duracionController.text = '${entrenamiento?.tiempo}';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Ejercicio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (id != null)
            PullDownButton(
              routeTheme: PullDownMenuRouteTheme(
                borderRadius: BorderRadius.circular(10),
                width: 200,
              ),
              itemBuilder: (context) => [
                PullDownMenuItem(
                  onTap: () {
                    controller.eliminarEjercicio(id!);
                  },
                  title: 'Eliminar ejercicio',
                  isDestructive: true,
                  // icon: Icons.delete_outline_outlined,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/icono_registrar_ejercicio_68x68_intensidad.png',
                        width: 25,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Establecer intensidad',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Column con las etiquetas
                        Obx(
                          () => Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var item in controller.elementos)
                                  GestureDetector(
                                    onTap: () {
                                      controller.intensidad.value =
                                          item['value'] as Intensidad;
                                      controller.ejercioSlicer.value =
                                          item['intensidad'] as double;

                                      controller.ejercicio.value =
                                          '${item['titulo']}';
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item['titulo']}',
                                            style: TextStyle(
                                              fontSize: item['value'] ==
                                                      controller
                                                          .intensidad.value
                                                  ? 18
                                                  : 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${item['descripcion']}',
                                            style: TextStyle(
                                              fontSize: item['value'] ==
                                                      controller
                                                          .intensidad.value
                                                  ? 14
                                                  : 12,
                                              color: item['value'] ==
                                                      controller
                                                          .intensidad.value
                                                  ? Colors.black
                                                  : Colors.grey,
                                              fontWeight: item['value'] ==
                                                      controller
                                                          .intensidad.value
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 210,
                            child: Obx(
                              () => RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  value: controller.ejercioSlicer.value,
                                  min: 0.0,
                                  max: 2.0,
                                  divisions: 2,
                                  onChanged: (value) {
                                    if (value == 0.0) {
                                      controller.intensidad.value =
                                          Intensidad.ligero;
                                      controller.ejercicio.value = 'Caminata';
                                    } else if (value == 1.0) {
                                      controller.intensidad.value =
                                          Intensidad.moderado;
                                      controller.ejercicio.value = 'Trotar';
                                    } else if (value == 2.0) {
                                      controller.intensidad.value =
                                          Intensidad.intenso;
                                      controller.ejercicio.value = 'Correr';
                                    }

                                    controller.ejercioSlicer.value = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Image.asset(
                          'assets/icons/icono_cronometro_negro_34x38_nuevo.png',
                          width: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Duración',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(4, (index) {
                          List<int> values = [15, 30, 60, 90];
                          return GestureDetector(
                            onTap: () {
                              controller.duracion.value = values[index];
                              controller.duracionController.text =
                                  '${values[index]}';
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color:
                                    controller.duracion.value == values[index]
                                        ? Colors.black
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      controller.duracion.value == values[index]
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                              child: Text(
                                '${values[index]} min.',
                                style: TextStyle(
                                  color:
                                      controller.duracion.value == values[index]
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hinttext: 'Minutos',
                    controller: controller.duracionController,
                    keyboardType: TextInputType.number,
                    onChanged: (p0) {
                      controller.duracion.value =
                          int.parse(controller.duracionController.text);
                    },
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.registrarEntrenamiento();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Añadir'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
