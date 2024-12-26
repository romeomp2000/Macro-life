import 'dart:io';

import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/EditarNutrientes/screen.dart';
import 'package:macrolife/screen/objetivos/controller.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:macrolife/widgets/custom_elevated_selected.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'controller.dart';

class RegistroPasosScreen extends StatelessWidget {
  const RegistroPasosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistroPasosController controller =
        Get.put(RegistroPasosController());

    final UsuarioController controllerUsuario = Get.put(UsuarioController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {controller.back()},
        ),
        title: Obx(
          () => LinearProgressIndicator(
            minHeight: 3.5,
            value: controller.progress.value,
            color: Colors.black,
            backgroundColor: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(), // Desactiva el swipe
          controller: controller.pageController, // Controlador de PageView
          onPageChanged: (index) {
            controller.currentStep.value = index + 1;
          },
          children: [
            // Paso 1: Selección de género

            Obx(
              () => Steep(
                title: 'Elige tu género',
                description:
                    'Esto se utilizará para calibrar tu plan personalizado',
                options: [
                  ListTileModel(title: 'Masculino'),
                  ListTileModel(title: 'Femenino'),
                  ListTileModel(title: 'Otro'),
                ],
                onOptionSelected: (gender) {
                  controller.selectedGender.value = gender;
                  FuncionesGlobales.vibratePress();
                },
                selectedOption: controller.selectedGender.value,
                onNext:
                    controller.isGenderSelected() ? controller.nextStep : null,
              ),
            ),
            Obx(
              () => Steep(
                title: '¿Cuantos entrenamiento haces por semana?',
                description:
                    'Esto se utilizará para calibrar tu plan personalizado',
                options: [
                  ListTileModel(
                    title: '0-2',
                    subtitle: 'Entrenamiento de vez en cuando',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_entrenamiento_semanal_100x100_nuevo_0-2.png',
                        color: controller.entrenamiento.value == '0-2'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        width: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: '3-5',
                    subtitle: 'Unos cuatro entrenamientos por semana',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_entrenamiento_semanal_100x100_nuevo_3-5.png',
                        color: controller.entrenamiento.value == '3-5'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        width: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: '6+',
                    subtitle: 'Atleta dedicado',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_entrenamiento_semanal_100x100_nuevo_6+.png',
                        color: controller.entrenamiento.value == '6+'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        width: 45,
                      ),
                    ),
                  ),
                ],
                onOptionSelected: (entrenamiento) async {
                  controller.entrenamiento.value = entrenamiento;
                  FuncionesGlobales.vibratePress();
                },
                selectedOption: controller.entrenamiento.value,
                onNext: controller.isEntrenamientoSelected()
                    ? controller.nextStep
                    : null,
              ),
            ),
            Obx(
              () => Steep(
                title: '¿Has probado otras aplicaciones para contar calorías?',
                options: [
                  ListTileModel(
                    title: 'No',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_si_no_120x120_nuevo_no.png',
                        width: 25,
                        color: controller.probado.value == 'No'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Si',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_si_no_120x120_nuevo_si.png',
                        width: 25,
                        color: controller.probado.value == 'Si'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                ],
                onOptionSelected: (probado) {
                  controller.probado.value = probado;
                  FuncionesGlobales.vibratePress();
                },
                selectedOption: controller.probado.value,
                onNext:
                    controller.isProbadoSelected() ? controller.nextStep : null,
              ),
            ),

            Obx(
              () => Steep(
                body: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15.0), // Define el radio de los bordes
                  child: Image.asset(
                    'assets/images/grafica_barras_477x372_nuevo_1.png',
                    color: Colors.black,
                  ),
                ),
                title: 'Macro Life crea resultados a largo plazo',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),

            Obx(
              () => Steep(
                body: AlturaPesoPicker(
                  onAlturaSelected: (value) => controller.altura,
                  onPesoSelected: (value) {
                    controller.peso.value = value;
                  },
                  defaultPeso: controller.peso.value,
                  defaultAltura: controller.altura.value,
                ),
                title: 'Altura y peso',
                description:
                    'Esto se utilizará para calibrar tu plan personalizado',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                body: FechaNacimientoPicker(
                  defaultAnio: controller.anio.value,
                  defaultMes: controller.mes.value,
                  defaultDia: controller.dia.value,
                  onFechaSeleccionada: (fecha) =>
                      {controller.fechaNacimiento.value = fecha},
                ),
                title: '¿Cuando naciste?',
                description:
                    'Esto se utilizará para calibrar tu plan personalizado',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.isFechaNacimientoSelected()
                    ? controller.nextStep
                    : null,
              ),
            ),
            Obx(
              () => Steep(
                title: '¿Cúal es tu objetivo?',
                description:
                    'Esto se utilizará para calibrar tu plan personalizado',
                options: [
                  ListTileModel(
                    title: 'Perder peso',
                  ),
                  ListTileModel(
                    title: 'Mantener',
                  ),
                  ListTileModel(
                    title: 'Aumentar de peso',
                  ),
                ],
                onOptionSelected: (objetivo) {
                  controller.objetivo.value = objetivo;
                  FuncionesGlobales.vibratePress();
                },
                selectedOption: controller.objetivo.value,
                onNext: controller.isObjetivoSelected()
                    ? controller.nextStep
                    : null,
              ),
            ),

            Obx(
              () => Steep(
                title: '¿Cuál es tu peso deseado?',
                options: const [],
                body: cintaMedirWidget(
                  pesoActual: controller.pesoDeseado.value.toDouble(),
                  onPesoChanged: (peso) {
                    controller.pesoDeseado.value = peso.toInt();
                    FuncionesGlobales.vibratePress();
                  },
                ),
                onOptionSelected: (probado) {
                  controller.probado.value = probado;
                },
                selectedOption: controller.probado.value,
                onNext:
                    controller.isProbadoSelected() ? controller.nextStep : null,
              ),
            ),
            Obx(
              () => Steep(
                title: '¿Sigues alguna dieta especifica?',
                options: [
                  ListTileModel(
                    title: 'Clásico',
                    // subtitle: '',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_dietas_alimenticias_120x120_nuevo_clasico.png',
                        color: controller.dieta.value == 'Clásico'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Pescetariana',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_dietas_alimenticias_120x120_nuevo_pescetario.png',
                        color: controller.dieta.value == 'Pescetariana'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Vegetariano',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_dietas_alimenticias_120x120_nuevo_vegetariano.png',
                        color: controller.dieta.value == 'Vegetariano'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Vegano',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_dietas_alimenticias_120x120_nuevo_vegano.png',
                        color: controller.dieta.value == 'Vegano'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                ],
                body: null,
                onOptionSelected: (dieta) {
                  controller.dieta.value = dieta;
                  FuncionesGlobales.vibratePress();
                },
                selectedOption: controller.dieta.value,
                onNext:
                    controller.isDietadoSelected() ? controller.nextStep : null,
              ),
            ),
            Obx(
              () => Steep(
                title: '¿Qué te gustaría lograr?',
                options: [
                  ListTileModel(
                    title: 'Come y vive más sano',
                    // subtitle: '',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_logros_alimenticios_120x120_nuevo_1.png',
                        color: controller.lograr.value == 'Come y vive más sano'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Aumentar mi energía y estado de ánimo',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_logros_alimenticios_120x120_nuevo_2.png',
                        color: controller.lograr.value ==
                                'Aumentar mi energía y estado de ánimo'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Manténgase motivado y constante',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_logros_alimenticios_120x120_nuevo_3.png',
                        color: controller.lograr.value ==
                                'Manténgase motivado y constante'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Sentirse mejor con mi cuerpo',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_logros_alimenticios_120x120_nuevo_4.png',
                        color: controller.lograr.value ==
                                'Sentirse mejor con mi cuerpo'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                ],
                body: null,
                onOptionSelected: (lograr) => controller.lograr.value = lograr,
                selectedOption: controller.lograr.value,
                onNext:
                    controller.isLograrSelected() ? controller.nextStep : null,
              ),
            ),

            Obx(
              () => Steep(
                body: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15.0), // Define el radio de los bordes
                  child: Image.asset(
                    'assets/images/grafico_alcance_meta_982x1190_nuevo.png',
                    width: Get.width,
                    height: 280,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
                title: 'Tienes un gran potencial para aplastar tu objetivo.',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),

            Obx(
              () => Steep(
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'LLegar a ',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '${controller.pesoDeseado} kg',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  ' es un objetivo realista. ¡No es difícil en absoluto!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'El 90% de los usuarios dice que el cambio es obvio después de usar Macro Life y no es fácil recaer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                title: '',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Velocidad de pérdida de peso por semana',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${((controller.rapidoMeta * 10).truncateToDouble()) / 10} Kg',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/icons/icono_tortuga_194x91_nuevo_roja.png',
                              color: ((controller.rapidoMeta * 10)
                                              .truncateToDouble() /
                                          10) ==
                                      0.1
                                  ? Colors.red
                                  : Colors.black,
                              height: 30,
                            ),
                            Image.asset(
                              'assets/icons/icono_ardilla_137x130_nuevo_amarillo.png',
                              color: ((controller.rapidoMeta * 10)
                                              .truncateToDouble() /
                                          10) ==
                                      0.8
                                  ? const Color(0xFFDD9A70)
                                  : Colors.black,
                              height: 30,
                            ),
                            Image.asset(
                              'assets/icons/icono_gacela_194x130_nuevo_negro.png',
                              color: ((controller.rapidoMeta * 10)
                                              .truncateToDouble() /
                                          10) ==
                                      1.5
                                  ? Colors.blue
                                  : Colors.black,
                              height: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.width,
                          child: CupertinoSlider(
                            min: 0.1,
                            max: 1.5,
                            thumbColor: Colors.black, // Color del círculo

                            value: controller.rapidoMeta.value,
                            onChanged: (meta) {
                              controller.rapidoMeta.value = meta;
                              FuncionesGlobales.vibratePress();
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            controller.rapidoMeta == 0.1
                                ? 'Lento y constante'
                                : controller.rapidoMeta > 0.1 &&
                                        controller.rapidoMeta < 1.5
                                    ? 'Recomendado'
                                    : 'Puede sentirse muy cansado y desarrollar piel flácida',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                title: '¿Qué tan rápido quieres alcanzar tu meta?',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),

            Obx(
              () => Steep(
                body: Container(
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15)),
                  width: Get.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15.0), // Define el radio de los bordes
                            child: Image.asset(
                              'assets/images/grafico_barra_comparativa_306x596_nuevo_sin_macrolife.png',
                              width: 100,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                15.0), // Define el radio de los bordes
                            child: Image.asset(
                              'assets/images/grafico_barra_comparativa_306x596_nuevo_con_macrolife.png',
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Macro Life lo hace fácil y te hace fácil y te hace responsable',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                title:
                    'Pierda el doble de peso con Macro life que por su cuenta',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),

            Obx(
              () => Steep(
                enableScroll: true,
                title: '¿Qué te impide alcanzar tus metas?',
                options: [
                  ListTileModel(
                    title: 'Falta de constancia',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_metas_alimenticias_120x120_nuevo_1.png',
                        color: controller.impedimento.value ==
                                'Falta de constancia'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Hábitos alimenticios poco saludables',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_metas_alimenticias_120x120_nuevo_2.png',
                        color: controller.impedimento.value ==
                                'Hábitos alimenticios poco saludables'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Falta de apoyo',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_metas_alimenticias_120x120_nuevo_3.png',
                        color: controller.impedimento.value == 'Falta de apoyo'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Agenda ocupada',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_metas_alimenticias_120x120_nuevo_4.png',
                        color: controller.impedimento.value == 'Agenda ocupada'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                  ListTileModel(
                    title: 'Falta de inspiración para la comida',
                    widget: ClipOval(
                      child: Image.asset(
                        'assets/icons/icono_metas_alimenticias_120x120_nuevo_5.png',
                        color: controller.impedimento.value ==
                                'Falta de inspiración para la comida'
                            ? null
                            : Colors.black,
                        colorBlendMode: BlendMode.color,
                        height: 45,
                      ),
                    ),
                  ),
                ],
                onOptionSelected: (impedimento) {
                  controller.impedimento.value = impedimento;
                  FuncionesGlobales.vibratePress();
                },
                selectedOption: controller.impedimento.value,
                onNext: controller.iaImpedimentoSelected()
                    ? controller.nextStep
                    : null,
              ),
            ),

            Steep(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 25,
                    children: [
                      if (Platform.isIOS)
                        SizedBox(
                          width: Get.width,
                          child: ElevatedButton.icon(
                            icon: Icon(FontAwesomeIcons.apple),
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.black),
                              iconColor: WidgetStateProperty.all(Colors.white),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                            ),
                            onPressed: controller.signWithApple,
                            label: Text('Iniciar sesión con Apple'),
                          ),
                        ),
                      SizedBox(
                        width: Get.width,
                        child: ElevatedButton.icon(
                          icon: Icon(FontAwesomeIcons.google),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.black),
                            iconColor: WidgetStateProperty.all(Colors.white),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                          ),
                          onPressed: controller.signWithGoogle,
                          label: Text('Iniciar sesión con Google'),
                        ),
                      ),
                      SizedBox(
                        width: Get.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.black),
                            shadowColor: WidgetStateProperty.all(Colors.white),
                            overlayColor: WidgetStateProperty.all(Colors.white),
                            surfaceTintColor:
                                WidgetStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            FuncionesGlobales.vibratePress();
                            controller.nextStep();
                          },
                          child: Text('Saltar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: 'Crear una cuenta',
              options: const [],
              onOptionSelected: (nombre) {},
              selectedOption: controller.correoController.value.text,
              onNext: controller.nextStep,
            ),

            Obx(
              () => Steep(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      focus: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.correoController,
                      onChanged: (p0) {
                        controller.correo.value = p0;
                      },
                      label: 'Correo electrónico',
                    ),
                  ),
                ),
                title:
                    '¿Cuál es tu correo electrónico para registrar tu cuenta?',
                options: const [],
                onOptionSelected: (nombre) {},
                selectedOption: controller.correoController.value.text,
                onNext: controller.correo.value.isEmpty
                    ? null
                    : controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      focus: true,
                      controller: controller.nombreController,
                      onChanged: (p0) {
                        controller.nombre.value = p0;
                      },
                      label: 'Nombre completo',
                    ),
                  ),
                ),
                title: '¿Cuál es tu nombre completo para registrar tu cuenta?',
                options: const [],
                onOptionSelected: (nombre) {},
                selectedOption: controller.nombreController.value.text,
                onNext: controller.nombre.value.isEmpty
                    ? null
                    : controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      keyboardType: TextInputType.number,
                      focus: true,
                      controller: controller.telefonoController,
                      onChanged: (p0) {
                        controller.telefono.value = p0;
                      },
                      label: 'Celular',
                    ),
                  ),
                ),
                title: '¿Cuál es tu celular para registrar tu cuenta?',
                options: const [],
                onOptionSelected: (telefono) {},
                selectedOption: controller.telefonoController.value.text,
                onNext: controller.telefono.value.length != 10
                    ? null
                    : controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                title: 'Danos calificación',
                options: const [],
                body: Scrollable(
                    axisDirection: AxisDirection.down,
                    viewportBuilder: (context, offset) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 40),
                                Icon(Icons.star, color: Colors.amber, size: 40),
                                Icon(Icons.star, color: Colors.amber, size: 40),
                                Icon(Icons.star, color: Colors.amber, size: 40),
                                Icon(Icons.star, color: Colors.amber, size: 40),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Macro Life creado para',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const Text(
                            'gente como tú',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(height: 30),
                          AvatarStack(
                            height: 70,
                            borderColor: Colors.white,
                            borderWidth: 3,
                            settings: RestrictedPositions(
                              minCoverage: 0.3,
                              align: StackAlign.left,
                            ),
                            avatars: const [
                              AssetImage(
                                  'assets/avatars/avatar_persona_212x212_.png'),
                              AssetImage(
                                  'assets/avatars/avatar_persona_212x212_2.png'),
                              AssetImage(
                                  'assets/avatars/avatar_persona_212x212_3.png'),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            '+ 1000 usuarios en Macro life',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 30),
                          review('José Antonio García',
                              'Excelente app para llevar un control fácil y rápido de mis macronutrientes. La interfaz es muy intuitiva.'),
                          const SizedBox(height: 15),
                          review('María Teresa Rodríguez',
                              'Me encanta la base de datos de alimentos y la opción de escanear códigos de barras. Hace todo mucho más sencillo.'),
                          const SizedBox(height: 25),
                          review('Carlos Alberto López',
                              'Perfecta para quienes quieren objetivos personalizados. Me ayuda a alcanzar mis metas nutricionales de manera efectiva.'),
                          const SizedBox(height: 15),
                        ],
                      );
                    }),
                onOptionSelected: (entrenamiento) =>
                    controller.entrenamiento.value = entrenamiento,
                selectedOption: controller.entrenamiento.value,
                onNext: controller.nextStep,
                enableScroll: true,
              ),
            ),
            Obx(
              () => Steep(
                enableScroll: true,
                body: Column(
                  children: [
                    Image.asset(
                      'assets/images/imagen_corredor_1023x883_.png',
                      width: Get.width,
                      height: 350,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Alcanza tus objetivos con notificaciones',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/cuadro_permitir_notificaciones_913x415_original.png',
                      width: Get.width,
                      height: 120,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        'Puedes desactivar cualquiera de los recordatorios en cualquier momento en la configuración. No te enviaremos correo basura.'),
                    const SizedBox(height: 20),
                  ],
                ),
                title:
                    'Pierda el doble de peso con Macro life que por su cuenta',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      focus: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.correoController,
                      onChanged: (p0) {
                        controller.correo.value = p0;
                      },
                      label: 'Código de referencia',
                    ),
                  ),
                ),
                title: '¿Tienes un código de referencia?',
                options: const [],
                onOptionSelected: (nombre) {},
                selectedOption: controller.correoController.value.text,
                onNext: controller.correo.value.isEmpty
                    ? null
                    : controller.nextStep,
              ),
            ),
            Obx(
              () => Steep(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/icons/confetti3.gif',
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/icono_checkverde_53x53_nuevo.png',
                          width: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text('¡Todo listo!')
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Gracias por confiar en nosotros',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Prometemos mantener siempre su información personal privada y segura.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                textBTN: 'Crear mi perfil',
                title: '',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: () => controller.onRegistrarLoader(),
              ),
            ),

            Obx(
              () => Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/icons/icono_checkverde_53x53_nuevo.png',
                            width: 25,
                            height: 25,
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
                          'Debes ${(controller.peso.value - controller.pesoDeseado.value) < 0 ? 'perder' : 'ganar'}:',
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
                            '${(controller.peso.value - controller.pesoDeseado.value).abs()} Kg el ${controllerUsuario.usuario.value.fechaMetaObjetivo ?? ''}',
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recomendación diaría Puedes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'estar esto en cualquier momento',
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Recomendaciones(
                                        imagen:
                                            'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                                        title: 'Calorías',
                                        puntaje:
                                            '${controllerUsuario.usuario.value.macronutrientesDiario?.value.calorias ?? 0}',
                                        color: Colors.black,
                                        onPressed: () {
                                          Get.to(
                                            () => EditarNutrientesScreen(
                                              textField: 'Calorías',
                                              color: Colors.black,
                                              imageUrl:
                                                  'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                                              title:
                                                  'Editar Objetivo de Calorías',
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
                                                controllerUsuario.usuario
                                                    .refresh();
                                              },
                                            ),
                                          );
                                        }),
                                  ),
                                  Obx(
                                    () => Recomendaciones(
                                      imagen:
                                          'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
                                      title: 'Carbohidratos',
                                      puntaje:
                                          '${controllerUsuario.usuario.value.macronutrientesDiario?.value.carbohidratos ?? 0}g',
                                      color: Colors.orange,
                                      onPressed: () {
                                        Get.to(
                                          () => EditarNutrientesScreen(
                                            textField: 'Carbohidratos',
                                            color: Colors.orange,
                                            imageUrl:
                                                'assets/icons/icono_panintegral_amarillo_76x70_nuevo.png',
                                            title:
                                                'Editar Objetivo de Carbohidratos',
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
                                              controllerUsuario.usuario
                                                  .refresh();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Recomendaciones(
                                        imagen:
                                            'assets/icons/icono_filetecarne_90x69_nuevo.png',
                                        title: 'Proteínas',
                                        puntaje:
                                            '${controllerUsuario.usuario.value.macronutrientesDiario?.value.proteina ?? 0}g',
                                        color: Colors.red,
                                        onPressed: () {
                                          Get.to(
                                            () => EditarNutrientesScreen(
                                              textField: 'Proteínas',
                                              color: Colors.red,
                                              imageUrl:
                                                  'assets/icons/icono_filetecarne_90x69_nuevo.png',
                                              title:
                                                  'Editar Objetivo de Proteínas',
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
                                                controllerUsuario.usuario
                                                    .refresh();
                                              },
                                            ),
                                          );
                                        }),
                                  ),
                                  Obx(
                                    () => Recomendaciones(
                                      imagen:
                                          'assets/icons/icono_almedraazul_74x70_nuevo.png',
                                      title: 'Grasas',
                                      puntaje:
                                          '${controllerUsuario.usuario.value.macronutrientesDiario?.value.grasas ?? 0}g',
                                      color: Colors.blue,
                                      onPressed: () {
                                        Get.to(
                                          () => EditarNutrientesScreen(
                                            textField: 'Grasas',
                                            color: Colors.blue,
                                            imageUrl:
                                                'assets/icons/icono_almedraazul_74x70_nuevo.png',
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
                                              controllerUsuario.usuario
                                                  .refresh();
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
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/icono_corazonrosa_50x50_nuevo.png',
                                          width: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 8),
                                            const Text('Puntuación de salud'),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: Get.width - 110,
                                              child: LinearProgressIndicator(
                                                value: controllerUsuario
                                                        .usuario
                                                        .value
                                                        .puntuacionSalud! /
                                                    10,
                                                color: Colors.green,
                                                backgroundColor:
                                                    Colors.grey[100],
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
                        const SizedBox(height: 25),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Cómo alcanzar tus objetivos:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              objetivos(
                                  'assets/icons/icono_corazonrosa_50x50_nuevo.png',
                                  'Utilice puntuaciones de salud para mejorar su rutina.'),
                              const SizedBox(height: 15),
                              objetivos(
                                'assets/icons/icono_almedraazul_74x70_nuevo.png',
                                'Sigue tu comida.',
                              ),
                              const SizedBox(height: 15),
                              objetivos(
                                  'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                                  'Sigue tu recomendación diaria de calorías.'),
                              const SizedBox(height: 15),
                              objetivos(
                                  'assets/icons/icono_calendario_azul_94x104_nuevo.png',
                                  'Equilibra tus carbohidratos, proteínas y grasas.'),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.grey[100],
                      width: Get.width - 25,
                      child: CustomElevatedButton(
                        message: 'Siguiente',
                        function: () {
                          FuncionesGlobales.actualizarMacronutrientes();
                          Get.offAllNamed('/layout');
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect objetivos(String url, String title) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(10), // Ajusta el radio de las esquinas
      child: CupertinoListTile(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        backgroundColor: Colors.white,
        leading: Image.asset(
          url,
          width: 30,
        ),
        title: Text(
          title,
          maxLines: 3,
        ),
      ),
    );
  }

  Container review(String nombre, String texto) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        // border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                nombre,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(texto),
        ],
      ),
    );
  }
}

class Recomendaciones extends StatelessWidget {
  final String title;
  final String puntaje;
  final Color color;
  final Function() onPressed;
  final String imagen;

  const Recomendaciones({
    Key? key,
    required this.title,
    required this.puntaje,
    required this.color,
    required this.onPressed,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: 155,
            height: 180,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 85,
                      height: 110,
                      child: SfCartesianChart(
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: 100,
                          interval: 50,
                          opposedPosition: true,
                          borderColor: Colors.black12,
                        ),
                        plotAreaBackgroundColor: Colors.black12,
                        primaryXAxis: CategoryAxis(
                          isVisible: false,
                        ),
                        enableSideBySideSeriesPlacement: false,
                        series: <CartesianSeries>[
                          ColumnSeries<ChartData, String>(
                            dataSource: [
                              ChartData('', 50.0, Colors.white),
                            ],
                            width: 1,
                            color: color,
                            xValueMapper: (ChartData data, _) => data.label,
                            yValueMapper: (ChartData data, _) => data.value,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  imagen,
                  width: 25,
                  color: color,
                )
              ],
            ),
          ),
          // Container(
          //   width: 180,
          //   height: 180,
          //   padding: const EdgeInsets.all(10),
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(15)),
          //   ),
          //   child: Column(
          //     children: [
          //       Text(title),
          //       const SizedBox(height: 15),
          //       CircularPercentIndicator(
          //         radius: 45.0,
          //         lineWidth: 5.0,
          //         percent: 0.5, // Ajusta el valor de progreso
          //         center: Text(
          //           puntaje,
          //         ),
          //         progressColor: color, // Color del progreso
          //         backgroundColor:
          //             Colors.black12, // Color del fondo del círculo
          //       ),
          //     ],
          //   ),
          // ),
          const Positioned(
            bottom: 35,
            right: 10,
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

class Steep extends StatelessWidget {
  final String title;
  final String? textBTN;

  final String? description;
  final List<ListTileModel> options;
  final Widget? body;
  final ValueChanged<String> onOptionSelected;
  final String selectedOption;
  final VoidCallback? onNext;
  final BoxDecoration? decoration;
  final bool? enableScroll; // Bandera para habilitar o deshabilitar el scroll

  const Steep({
    super.key,
    required this.title,
    this.textBTN = 'Siguiente',
    this.description,
    required this.options,
    required this.onOptionSelected,
    required this.selectedOption,
    required this.onNext,
    this.body,
    this.enableScroll = false, // Inicializar la bandera
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    // Usar SingleChildScrollView solo si enableScroll es true
    return enableScroll ?? false
        ? SingleChildScrollView(
            // Envolver en un SingleChildScrollView si enableScroll es true
            child: _buildContent(context),
          )
        : _buildContent(
            context); // Si no, simplemente mostrar el contenido sin scroll
  }

  // Método que construye todo el contenido
  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                if (description != null)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        description ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Column(
            children: [
              body != null ? body! : Container(),
              ...options.map(
                (option) => Column(
                  children: [
                    CustomElevatedSelected(
                      message: option.title ?? '',
                      icon: option.icon,
                      widget: option.widget,
                      subtitle: option.subtitle,
                      function: () => onOptionSelected(option.title ?? ''),
                      activo: selectedOption == option.title,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Center(
                child: CustomElevatedButton(
                  message: textBTN ?? 'Siguiente',
                  function: onNext,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class AlturaPesoPicker extends StatelessWidget {
  final ValueChanged<int> onAlturaSelected;
  final ValueChanged<int> onPesoSelected;

  // Agregar parámetros para los valores predeterminados reales
  final int defaultAltura;
  final int defaultPeso;

  // Constructor que recibe las funciones de callback y los valores predeterminados reales
  AlturaPesoPicker({
    super.key,
    required this.onAlturaSelected,
    required this.onPesoSelected,
    this.defaultAltura = 60, // Valor por defecto de altura
    this.defaultPeso = 20, // Valor por defecto de peso
  });

  final List<int> alturas =
      List<int>.generate(184, (i) => 60 + i); // Genera alturas de 60 a 243 cm
  final List<int> pesos =
      List<int>.generate(341, (i) => 20 + i); // Genera pesos de 20 a 360 kg

  @override
  Widget build(BuildContext context) {
    // Encuentra el índice correspondiente al valor de altura y peso predeterminados
    int defaultAlturaIndex = alturas.indexOf(defaultAltura);
    int defaultPesoIndex = pesos.indexOf(defaultPeso);

    return Center(
      child: Column(
        children: [
          const Text(
            "Métrica",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Altura",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // Texto en negritas
                    ),
                    SizedBox(
                      height: 170,
                      child: CupertinoPicker(
                        itemExtent: 32.0,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                defaultAlturaIndex), // Índice correspondiente
                        onSelectedItemChanged: (int index) {
                          // Llama a la función callback con el valor seleccionado
                          onAlturaSelected(alturas[index]);
                        },
                        children: alturas.map((altura) {
                          return Center(child: Text('$altura cm'));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Peso",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold), // Texto en negritas
                    ),
                    SizedBox(
                      height: 170,
                      child: CupertinoPicker(
                        itemExtent: 32.0,
                        scrollController: FixedExtentScrollController(
                            initialItem:
                                defaultPesoIndex), // Índice correspondiente
                        onSelectedItemChanged: (int index) {
                          // Llama a la función callback con el valor seleccionado
                          onPesoSelected(pesos[index]);
                        },
                        children: pesos.map((peso) {
                          return Center(child: Text('$peso kg'));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FechaNacimientoPicker extends StatelessWidget {
  final ValueChanged<DateTime> onFechaSeleccionada;

  // Agregar parámetros para los valores predeterminados de fecha
  final int defaultMes;
  final int defaultDia;
  final int defaultAnio;

  // Constructor que recibe las funciones de callback y los valores predeterminados reales
  FechaNacimientoPicker({
    super.key,
    required this.onFechaSeleccionada,
    this.defaultMes = 1, // Mes por defecto (Enero)
    this.defaultDia = 1, // Día por defecto (1)
    this.defaultAnio = 2000, // Año por defecto (2000)
  });

  final List<String> meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  final List<int> dias =
      List<int>.generate(31, (i) => i + 1); // Días del 1 al 31
  final List<int> anios =
      List<int>.generate(131, (i) => 1900 + i); // Años de 1900 a 2030

  @override
  Widget build(BuildContext context) {
    // Encuentra el índice correspondiente al valor de mes, día y año predeterminados
    int defaultMesIndex =
        defaultMes - 1; // Los índices empiezan desde 0, por lo que restamos 1
    int defaultDiaIndex = dias.indexOf(defaultDia);
    int defaultAnioIndex = anios.indexOf(defaultAnio);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Text(
                //   "Día",
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 170,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: defaultDiaIndex), // Índice de día
                    onSelectedItemChanged: (int index) {
                      // Llama a la función callback con la fecha seleccionada
                      DateTime selectedDate = DateTime(
                          anios[defaultAnioIndex],
                          meses[defaultMesIndex] == "Enero"
                              ? 1
                              : (defaultMesIndex + 1),
                          index + 1);
                      onFechaSeleccionada(selectedDate);
                    },
                    children: dias.map((dia) {
                      return Center(child: Text('$dia'));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Text(
                //   "Mes",
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 170,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: defaultMesIndex), // Índice de mes
                    onSelectedItemChanged: (int index) {
                      // Llama a la función callback con la fecha seleccionada
                      DateTime selectedDate = DateTime(anios[defaultAnioIndex],
                          index + 1, dias[defaultDiaIndex]);
                      onFechaSeleccionada(selectedDate);
                    },
                    children: meses.map((mes) {
                      return Center(child: Text(mes));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Text(
                //   "Año",
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: 170,
                  child: CupertinoPicker(
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                        initialItem: defaultAnioIndex), // Índice de año
                    onSelectedItemChanged: (int index) {
                      // Llama a la función callback con la fecha seleccionada
                      DateTime selectedDate = DateTime(
                          anios[index],
                          meses[defaultMesIndex] == "Enero"
                              ? 1
                              : (defaultMesIndex + 1),
                          dias[defaultDiaIndex]);
                      onFechaSeleccionada(selectedDate);
                    },
                    children: anios.map((anio) {
                      return Center(child: Text('$anio'));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget cintaMedirWidget({
  required double pesoActual,
  required Function(double) onPesoChanged,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Perder peso',
        style: TextStyle(fontSize: 20),
      ),
      Text(
        '${pesoActual.toInt()} kg',
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SfLinearGauge(
              minimum: 5,
              maximum: 350,
              interval: 50,
              minorTicksPerInterval: 5,
              axisLabelStyle: const TextStyle(fontSize: 13),
              markerPointers: [
                LinearWidgetPointer(
                  value: pesoActual,
                  child: Container(
                    height: 70,
                    width: 3,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0, // Posiciona el Slider encima del medidor
              left: -20,
              right: -20,
              child: Slider(
                activeColor: Colors.transparent,
                thumbColor: Colors.black,
                inactiveColor: Colors.transparent,
                secondaryActiveColor: Colors.transparent,
                min: 5,
                max: 350,
                value: pesoActual,
                label: '${pesoActual.toInt()} kg',
                onChanged: (value) {
                  onPesoChanged(
                    value,
                  ); // Llamamos a la función para notificar el cambio
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class RulerPainter extends CustomPainter {
  final bool isMultipleOfTen;

  RulerPainter({required this.isMultipleOfTen});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    if (isMultipleOfTen) {
      // Dibujar línea larga apuntando hacia arriba
      canvas.drawLine(
        Offset(size.width / 2, size.height),
        Offset(size.width / 2, 0),
        paint,
      );
    } else {
      // Dibujar línea corta apuntando hacia arriba
      canvas.drawLine(
        Offset(size.width / 2, size.height),
        Offset(size.width / 2, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
