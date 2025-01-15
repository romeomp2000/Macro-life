import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gif_view/gif_view.dart';
import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/EditarNutrientes/screen.dart';
import 'package:macrolife/screen/registro_pasos/paso_1.dart';
import 'package:macrolife/screen/registro_pasos/paso_2.dart';
import 'package:macrolife/screen/registro_pasos/paso_3.dart';
import 'package:macrolife/screen/registro_pasos/paso_4.dart';
import 'package:macrolife/screen/registro_pasos/paso_5.dart';
import 'package:macrolife/screen/registro_pasos/paso_6.dart';
import 'package:macrolife/screen/registro_pasos/paso_7.dart';
import 'package:macrolife/screen/registro_pasos/paso_8.dart';
// import 'package:macrolife/screen/objetivos/controller.dart';
// import 'package:macrolife/widgets/AnimatedWeightPicker.dart';
import 'package:macrolife/widgets/Cinta_metrica.dart';
// import 'package:macrolife/widgets/FechaNacimientoPicker.dart';
import 'package:macrolife/widgets/SinpleRulerPicker.dart';
import 'package:macrolife/widgets/TimerPicker.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:macrolife/widgets/custom_elevated_selected.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/widgets/custom_text_form_field.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:video_player/video_player.dart';
import 'controller.dart';

class RegistroPasosScreen extends StatelessWidget {
  const RegistroPasosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistroPasosController controller =
        Get.put(RegistroPasosController());

    final UsuarioController controllerUsuario = Get.put(UsuarioController());
    final TimerPickerController timePic = Get.put(TimerPickerController());
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        toolbarHeight: 45,
        // backgroundColor: Colors.grey.shade100,
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),

        title: Row(
          spacing: 15,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                  
                ]
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => {controller.back()},
              ),
            ),
            Obx(
              () => Container(
                height: 40,
                width: Get.width - 95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.symmetric(vertical: 19, horizontal: 15),
                child: LinearProgressIndicator(
                  minHeight: 3.5,
                  value: controller.progress.value,
                  color: Colors.black,
                  backgroundColor: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ],
        ),
        // backgroundColor: Colors.white,
      ),
      body: Obx(
        () => PageView(
          physics: const NeverScrollableScrollPhysics(), // Desactiva el swipe
          controller: controller.pageController, // Controlador de PageView
          onPageChanged: (index) => controller.currentStep.value = index + 1,
          children: [
            // Paso 1: Selección de género

            paso_1(controller),

            paso_2(controller),

            paso_3(controller),

            paso_4(controller),

            paso_5(controller),

            paso_6(controller),

            paso_7(controller),

            if (controller.objetivo.value == 'Aumentar' ||
                controller.objetivo.value == 'Perder')
              Obx(
                () {
                  // Verifica si el objetivo es 'Aumentar'
                  return Steep(
                    enableScroll: false,
                    isActivo: true.obs,
                    title: '¿Cuál es tu objetivo de peso?',
                    options: const [],
                    body: SizedBox(
                      height: 270,
                      child: Column(
                        spacing: 15,
                        children: [
                          // Otros widgets dentro del Column
                          SizedBox(
                            width: Get.width,
                            child: SimpleRulerPicker(
                              unitString: 'kg',
                              axis: Axis.horizontal,
                              minValue: 1,
                              currentWeight: controller.peso.value,
                              maxValue: 300,
                              initialValue: controller.pesoDeseado.value,
                              onValueChanged: (value) {
                                controller.pesoDeseado.value = value;
                                controller.ajustarLabelPeso();
                              },
                              scaleLabelSize: 16,
                              scaleBottomPadding: 20,
                              scaleItemWidth: 12,
                              longLineHeight: 50,
                              shortLineHeight: 14,
                              lineColor: Colors.grey,
                              selectedColor: Colors.black,
                              labelColor: Colors.black,
                              lineStroke: 2,
                              height: 200,
                            ),
                          ),
                          Text(controller.pesoDeseadoLabel.value),
                          Text(
                            controller.pesoDeseadoValue.value,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onOptionSelected: (probado) {
                      controller.probado.value = probado;
                    },
                    selectedOption: controller.probado.value,
                    onNext: controller.isProbadoSelected()
                        ? controller.nextStep
                        : null,
                  );
                },
              ),
            if (controller.objetivo.value != 'Mantener')
              Obx(
                () => Steep(
                  enableScroll: false,
                  isActivo: true.obs,
                  enablePadding: true,
                  body: Column(
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
                            'assets/icons/icono_tortuga_outline_200x98_activo.png',
                            color: Colors.black,
                            height: 25,
                          ),
                          Image.asset(
                            'assets/icons/icono_ardilla_outline_144x137_activo.png',
                            color: Colors.black,
                            height: 25,
                          ),
                          Image.asset(
                            'assets/icons/icono_gacela_outline_200x137_activo.png',
                            color: Colors.black,
                            height: 25,
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
                          // ignore: unrelated_type_equality_checks
                          controller.rapidoMeta == 0.1
                              ? 'Lento y constante'
                              : controller.rapidoMeta > 0.1 &&
                                      controller.rapidoMeta < 1.5
                                  ? 'Recomendado'
                                  : 'Puede sentirse muy cansado',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: '¿Qué tan rápido quieres alcanzar tu meta?',
                  options: const [],
                  onOptionSelected: (probado) =>
                      controller.probado.value = probado,
                  selectedOption: controller.probado.value,
                  onNext: controller.nextStep,
                ),
              ),

            if (controller.mostrarGrafica.value == true)
              Obx(() {
                controller.controllerVideo = VideoPlayerController.asset(
                  'assets/videos/animacion_barras_comparativas_658x984_.mp4', // Use 'VideoPlayerController.network' for URLs
                )
                  ..initialize().then((_) {})
                  ..setLooping(false)
                  ..play();
                return Steep(
                  enableScroll: true,
                  enablePadding: true,
                  isActivo: true.obs,
                  body: Column(
                    spacing: 30,
                    children: [
                      // GifView.asset(
                      //   'assets/gifs/animacion_barras_comparativas_658x984_ (2).gif',
                      //   height: 250,
                      //   loop: false,
                      //   filterQuality: FilterQuality.high,
                      //   frameRate: 20,
                      //   fadeDuration: Duration(seconds: 1),
                      // ),
                      // GifView.asset(
                      //   'assets/gifs/grafica_inicial_902x474.gif',
                      //   width: Get.width - 50,
                      //   loop: false,
                      //   filterQuality: FilterQuality.high,
                      //   frameRate: 30,
                      //   fadeDuration: Duration(seconds: 2),
                      // ),
                      SizedBox(
                        width: 220,
                        height: 300,
                        child: VideoPlayer(controller.controllerVideo),
                      ),
                      Text(
                        'Macro Life lo hace fácil y te hace responsable',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  title: controller.labelGraficaDoble.value,
                  options: const [],
                  onOptionSelected: (probado) =>
                      controller.probado.value = probado,
                  selectedOption: controller.probado.value,
                  onNext: controller.nextStep,
                );
              }),
            if (controller.objetivo.value != 'Mantener')
              Obx(
                () => Steep(
                  enableScroll: false,
                  enablePadding: true,
                  isActivo: true.obs,
                  body: Center(
                    child: SizedBox(
                      // height: Get.height - 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 30,
                        children: [
                          Text(
                            controller.objetivo.value == 'Aumentar'
                                ? 'Ganando'
                                : 'Perdiendo',
                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.pesoDeseadoValue.value,
                            style: const TextStyle(
                              fontSize: 60,
                            ),
                          ),
                          Text(
                            'Es un objetivo realista.\nNo es nada difícil.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // const SizedBox(height: 30),
                          // e
                          // Spacer(),
                          Text(
                            'El 90% de los usuarios informan de resultados notables después de usar Macro Life, con un progreso sostenido que es difícil de revertir.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                // fontSize: 20,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  title: '',
                  options: [],
                  onOptionSelected: (probado) =>
                      controller.probado.value = probado,
                  selectedOption: controller.probado.value,
                  onNext: controller.nextStep,
                ),
              ),

            Obx(
              () => Steep(
                enablePadding: false,
                enableScroll: true,
                isActivo: true.obs,
                body: Column(
                  spacing: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'El 80% de los usuarios de Macro Life mantienen su peso ideal incluso 6 meses después',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Tu peso',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    GifView.asset(
                      'assets/gifs/grafica_dieta_mes_952x780.gif',
                      width: Get.width - 50,
                      loop: false,
                      filterQuality: FilterQuality.high,
                      frameRate: 20,
                      fadeDuration: Duration(seconds: 0),
                    ),
                  ],
                ),
                title: 'Crea resultados a largo plazo',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              ),
            ),

            paso_8(controller),
            // Obx(
            //   () => Steep(
            //     enableScroll: true,
            //     title: '¿Qué le gustaría conseguir?',
            //     isActivo: true.obs,
            //     options: [
            //       ListTileModel(
            //         check: false,
            //         title: 'Comer y vivir más sano',
            //         // subtitle: '',
            //         leading: Image.asset(
            //           'assets/icons/icono_logros_alimenticios_outline_63x63_5.png',
            //           height: 25,
            //         ),
            //       ),
            //       ListTileModel(
            //         title: 'Aumentar mi energía y mi estado de ánimo',
            //         check: false,
            //         leading: Image.asset(
            //           'assets/icons/icono_logros_alimenticios_outline_63x63_6.png',
            //           height: 25,
            //         ),
            //       ),
            //       ListTileModel(
            //         check: false,
            //         title: 'Mantener la motivación y la constancia',
            //         leading: Image.asset(
            //           'assets/icons/icono_logros_alimenticios_outline_63x63_7.png',
            //           height: 25,
            //         ),
            //       ),
            //       ListTileModel(
            //         check: false,
            //         title: 'Sentirme mejor con mi cuerpo',
            //         leading: Image.asset(
            //           'assets/icons/icono_brazo_outline_100x100_activo.png',
            //           height: 25,
            //         ),
            //       ),
            //     ],
            //     body: null,
            //     selectedOptions: controller.lograr.value,
            //     onOptionSelected: (lograr) {
            //       if (controller.lograr.value.contains(lograr)) {
            //         controller.lograr.value.remove(lograr);
            //       } else {
            //         controller.lograr.value.add(lograr);
            //       }
            //       controller.lograr.refresh();
            //     },
            //     onNext:
            //         controller.isLograrSelected() ? controller.nextStep : null,
            //   ),
            // ),

            Obx(
              () => Steep(
                enableScroll: true,
                isActivo: true.obs,
                title: '¿Sigue una dieta específica?',
                options: [
                  ListTileModel(
                    check: false,
                    title: 'Clásico',
                    leading: Image.asset(
                      'assets/icons/icono_dietas_alimenticias_outline_60x60_clasico.png',
                      height: 25,
                    ),
                  ),
                  ListTileModel(
                    check: false,
                    title: 'Pescetariana',
                    leading: Image.asset(
                      'assets/icons/icono_dietas_alimenticias_outline_60x60_pescetario.png',
                      height: 25,
                    ),
                  ),
                  ListTileModel(
                    check: false,
                    title: 'Vegetariano',
                    leading: Image.asset(
                      'assets/icons/icono_dietas_alimenticias_outline_60x60_vegetariano.png',
                      height: 25,
                    ),
                  ),
                  ListTileModel(
                    check: false,
                    title: 'Vegano',
                    leading: Image.asset(
                      'assets/icons/icono_dietas_alimenticias_outline_60x60_vegano.png',
                      height: 25,
                    ),
                  ),
                  ListTileModel(
                    check: false,
                    title: 'Otro',
                    leading: SizedBox.shrink(),
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
            Obx(() {
              FuncionesGlobales.getDeviceToken();

              return Steep(
                enableScroll: true,
                enablePadding: true,
                isActivo: true.obs,
                body: Column(
                  spacing: 10,
                  children: [
                    const Text(
                      'Desactivar las notificaciones en cualquier momento en ajustes',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.black12,
                          )),
                      child: Image.asset(
                        'assets/icons/icono_campana_notificacion_156x156_activo.png',
                        width: 40,
                      ),
                    ),
                  ],
                ),
                title: '¡Recibe notificaciones!',
                options: const [],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext: controller.nextStep,
              );
            }),
            Obx(
              () {
                controller.calificarApp();

                return Steep(
                  enablePadding: true,
                  isActivo: true.obs,
                  title: 'Danos tu opinión',
                  description: '¿Está satisfecho con nuestra aplicación?',
                  options: const [],
                  body: Scrollable(
                    axisDirection: AxisDirection.down,
                    viewportBuilder: (context, offset) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.black, size: 40),
                                Icon(Icons.star, color: Colors.black, size: 40),
                                Icon(Icons.star, color: Colors.black, size: 40),
                                Icon(Icons.star, color: Colors.black, size: 40),
                                Icon(Icons.star, color: Colors.black, size: 40),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  onOptionSelected: (entrenamiento) =>
                      controller.entrenamiento.value = entrenamiento,
                  selectedOption: controller.entrenamiento.value,
                  onNext: controller.nextStep,
                  enableScroll: true,
                );
              },
            ),
            Steep(
              enablePadding: true,
              isActivo: true.obs,
              enableScroll: true,
              title: '¿Qué hora te viene bien?',
              options: [
                ListTileModel(
                  check: false,
                  title: 'Desayuno',
                  subtitle: 'Define la hora de tu desayuno',
                  trailing: Row(
                    spacing: 10,
                    children: [
                      Text(
                        controller.formatTimeOfDay(controller.desayuno.value),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                ListTileModel(
                  check: false,
                  title: 'Comida',
                  subtitle: 'Define la hora de tu comida',
                  trailing: Row(
                    spacing: 10,
                    children: [
                      Text(
                        controller.formatTimeOfDay(controller.comida.value),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                ListTileModel(
                  check: false,
                  title: 'Cena',
                  subtitle: 'Define la hora de tu cena',
                  trailing: Row(
                    spacing: 10,
                    children: [
                      Text(
                        controller.formatTimeOfDay(controller.cena.value),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ],
              onOptionSelected: (value) {
                if (value == 'Desayuno') {
                  timePic.onChagueHorario(
                    controller.desayuno.value,
                    title: 'Desayuno',
                    onSave: (TimeOfDay horaSeleccionada) {
                      controller.desayuno.value = horaSeleccionada;
                    },
                  );
                }

                if (value == 'Comida') {
                  timePic.onChagueHorario(
                    controller.comida.value,
                    title: 'Comida',
                    onSave: (TimeOfDay horaSeleccionada) {
                      controller.comida.value = horaSeleccionada;
                    },
                  );
                }

                if (value == 'Cena') {
                  timePic.onChagueHorario(
                    controller.cena.value,
                    title: 'Cena',
                    onSave: (TimeOfDay horaSeleccionada) {
                      controller.cena.value = horaSeleccionada;
                    },
                  );
                }
              },
              selectedOption: controller.codigoController.value.text,
              onNext: controller.nextStep,
            ),

            Steep(
              enablePadding: true,
              enableScroll: true,
              isActivo: true.obs,
              body: Column(
                spacing: 50,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Image.asset(
                      'assets/icons/icono_usuarios_80x80_activo.png',
                      width: 40,
                    ),
                  ),
                  CustomTextFormField(
                    focus: false,
                    keyboardType: TextInputType.text,
                    controller: controller.codigoController,
                    onChanged: (p0) {
                      controller.correo.value = p0;
                    },
                    label: 'Código de referencia',
                  ),
                ],
              ),
              enabledButtonSaltar: true,
              title: '¿Tienes un código de referencia?',
              options: const [],
              selectedOption: controller.codigoController.value.text,
              onNext: controller.nextStep,
            ),

            Builder(builder: (context) {
              controller.connectAppleHealth();

              return Steep(
                enablePadding: true,
                isActivo: true.obs,
                enableScroll: true,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Image.asset(
                      'assets/images/imagen_health_1125x1125_original (1).png',
                      width: Get.width - 50,
                    ),
                    Text(
                      'Macro Life realiza un seguimiento de tus ascensos y ajusta tus objetivos en consecuencia.',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                enabledButtonSaltar: true,
                title: 'Conectar con Apple Health',
                description:
                    'puede cambiarlo en cualquier momento en la configuración',
                options: const [],
                selectedOption: controller.codigoController.value.text,
                onNext: controller.nextStep,
              );
            }),

            Steep(
              isActivo: true.obs,
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 25,
                    children: [
                      if (Platform.isIOS)
                        SizedBox(
                          width: Get.width,
                          height: 50,
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
                        height: 50,
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
                    ],
                  ),
                ),
              ),
              title: 'Crear una cuenta',
              options: const [],
              onOptionSelected: (nombre) {},
              selectedOption: controller.correoController.value.text,
              onNext: null,
            ),
            Obx(
              () => Steep(
                isActivo: true.obs,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/icons/confetti3.gif',
                    ),
                  ),
                ),
                body: Column(
                  spacing: 20,
                  children: [
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 7,
                    ),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/icons/icono_check_genero_115x115_2025_negro (1).png',
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
                            (controller.peso.value -
                                            controller.pesoDeseado.value)
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
                                          'assets/icons/icono_logros_alimenticios_outline_63x63_4.png',
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
                                                color: Colors.black,
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
                        // const SizedBox(height: 25),
                        // Container(
                        //   width: Get.width,
                        //   padding: const EdgeInsets.all(12),
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey[100],
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(15))),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       const Text(
                        //         'Cómo alcanzar tus objetivos:',
                        //         style: TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       const SizedBox(height: 15),
                        //       objetivos(
                        //           'assets/icons/icono_corazonrosa_50x50_nuevo.png',
                        //           'Utilice puntuaciones de salud para mejorar su rutina.'),
                        //       const SizedBox(height: 15),
                        //       objetivos(
                        //         'assets/icons/icono_almedraazul_74x70_nuevo.png',
                        //         'Sigue tu comida.',
                        //       ),
                        //       const SizedBox(height: 15),
                        //       objetivos(
                        //           'assets/icons/icono_calorias_negro_99x117_nuevo.png',
                        //           'Sigue tu recomendación diaria de calorías.'),
                        //       const SizedBox(height: 15),
                        //       objetivos(
                        //           'assets/icons/icono_calendario_azul_94x104_nuevo.png',
                        //           'Equilibra tus carbohidratos, proteínas y grasas.'),
                        //       const SizedBox(height: 15),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 75),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.grey[100],
                      // width: Get.width - 20,
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
            Steep(
              isActivo: true.obs,
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 25,
                    children: [
                      if (Platform.isIOS)
                        SizedBox(
                          width: Get.width,
                          height: 50,
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
                        height: 50,
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
                    ],
                  ),
                ),
              ),
              title: 'Crear una cuenta',
              options: const [],
              onOptionSelected: (nombre) {},
              selectedOption: controller.correoController.value.text,
              onNext: null,
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

class GeneroSelect extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  final String genero;
  final bool selected;

  const GeneroSelect({
    super.key,
    required this.icon,
    this.onTap,
    required this.genero,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FuncionesGlobales.vibratePress();
        if (onTap != null) {
          onTap!();
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: selected == true ? Colors.white : Colors.white,
              border: Border.all(
                width: selected == true ? 2 : 1,
                color: selected == true
                    ? Colors.black
                    : Color.fromARGB(255, 237, 237, 237),
              ),
              borderRadius: BorderRadius.circular(300),
            ),
            child: SizedBox(
              width: 78,
              height: 78,
              child: Column(
                spacing: 10,
                children: [
                  Image.asset(
                    icon,
                    width: 47,
                    height: 47,
                    color: selected == true
                        ? Colors.black
                        : const Color.fromARGB(255, 246, 246, 246),
                  ),
                  Text(
                    genero,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: selected == true
                          ? Colors.black
                          : const Color.fromARGB(255, 246, 246, 246),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (selected == true)
            Positioned(
              right: 0,
              top: 0,
              child: Image.asset(
                'assets/icons/icono_check_genero_115x115_2025_negro.png',
                width: 40,
              ),
            )
        ],
      ),
    );
  }
}

class Recomendaciones extends StatelessWidget {
  final String title;
  final String puntaje;
  final Function() onPressed;
  final String imagen;

  const Recomendaciones({
    super.key,
    required this.title,
    required this.puntaje,
    required this.onPressed,
    required this.imagen,
  });

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
                      width: 80,
                      height: 110,
                      child: BarChart(
                        BarChartData(
                          barGroups: [
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  toY: 50,
                                  fromY: 0,
                                  color: Colors.black,
                                  width: 35,
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 100,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          titlesData: FlTitlesData(
                            show: false,
                            leftTitles: AxisTitles(),
                            bottomTitles:
                                AxisTitles(drawBelowEverything: false),
                            topTitles: AxisTitles(drawBelowEverything: false),
                          ),
                          gridData: FlGridData(
                            show: false,
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barTouchData: BarTouchData(
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  imagen,
                  width: 25,
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
  final ValueChanged<String>? onOptionSelected;
  final String? selectedOption;
  final List<String>? selectedOptions;
  final VoidCallback? onNext;
  final BoxDecoration? decoration;
  final bool? enableScroll; // Bandera para habilitar o deshabilitar el scroll
  final bool? enablePadding;
  final bool? isBascula;
  final bool? enabledButtonSaltar;
  final RxBool isActivo;
  const Steep({
    super.key,
    required this.title,
    this.textBTN = 'Siguiente',
    this.description,
    required this.options,
    this.onOptionSelected,
    this.selectedOption,
    required this.onNext,
    this.body,
    this.enableScroll = false, // Inicializar la bandera
    this.decoration,
    this.enablePadding = false,
    this.isBascula = false,
    this.selectedOptions,
    this.enabledButtonSaltar = false,
    required this.isActivo,
  });

  @override
  Widget build(BuildContext context) {
    // Usar SingleChildScrollView solo si enableScroll es true
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: enableScroll ?? false
          ? SingleChildScrollView(
              // Envolver en un SingleChildScrollView si enableScroll es true
              child: _buildContent(),
            )
          : _buildContent(), // Si no, simplemente mostrar el contenido sin scroll
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (enabledButtonSaltar == true)
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                    side: WidgetStateProperty.all(
                      BorderSide(color: Colors.black12, width: 1.5),
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 17),
                    ),
                  ),
                  onPressed: onNext,
                  child: Text('Saltar'),
                ),
              ),
            Expanded(
                child:
                    buttonTest(textBTN ?? 'Siguiente', onNext, isActivo.value)
                // CustomElevatedButton(
                //   message: textBTN ?? 'Siguiente',
                //   function: onNext,
                // ),
                ),
          ],
        ),
      ),
    );
  }

  // Método que construye todo el contenido
  Widget _buildContent() {
    return Container(
      decoration: decoration,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left: isBascula! ? 0 : 10, right: isBascula! ? 0 : 10),
      // height: Get.height - 90,
      child: Column(
        spacing: isBascula! ? 0 : 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isBascula! ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (description != null)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      description ?? '',
                      textAlign: TextAlign.center,
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: enablePadding == true ? 12.0 : 0.0,
              vertical: enablePadding == true ? 10 : 0.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                body != null ? body! : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10,
            ),
            child: Column(
              spacing: 15,
              children: [
                ...options.map(
                  (option) => Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        // decoration: BoxDecoration(
                        //   color: Colors.transparent,
                        //   boxShadow: [
                        //     BoxShadow(
                        //         color: Colors.black,
                        //         offset: Offset(1, 1),
                        //         blurRadius: 1)
                        //   ],
                        // ),
                        child: CustomElevatedSelected(
                          check: option.check,
                          message: option.title ?? '',
                          icon: option.icon,
                          widget: option.leading,
                          subtitle: option.subtitle,
                          trailing: option.trailing,
                          function: () {
                            if (onOptionSelected != null) {
                              onOptionSelected!(option.title ?? '');
                            }
                          },
                          activo: selectedOption == option.title ||
                              (selectedOptions?.contains(option.title) ??
                                  false),
                        ),
                      ),
                    ],
                  ),
                ),
                if (options.length > 2) const SizedBox(height: 10)
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
        child: SizedBox(
          height: 130,
          width: Get.width,
          child: CintaMetrica(
            start: 60,
            min: 10,
            max: 300,
            step: 1,
            value: 60,
            onChanged: onPesoChanged,
          ),
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

class TrackSlider extends StatefulWidget {
  /// It will return the current position of the slider
  final ValueChanged<int> onChange;

  const TrackSlider({
    super.key,
    this.selectedTrackColor = Colors.blue,
    this.unselectedTrackColor = const Color.fromRGBO(224, 224, 224, 1),
    this.steps = 100,
    required this.onChange,
    this.defaultValue = 0,
    this.marginTop = 0,
  });

  /// It defines the initial position of the slider
  final int defaultValue;

  /// It is used to align the slider in center if widget is wrapped by a padding or margin.
  final double marginTop;

  /// color of selected track
  final Color selectedTrackColor;

  /// color of unselected tracks
  final Color unselectedTrackColor;

  /// Number of tracks in the slider
  final int steps;

  @override
  State<TrackSlider> createState() => _TrackSliderState();
}

class _TrackSliderState extends State<TrackSlider> {
  late ScrollController scrollController;

  setPosition(ScrollPosition position) {
    if (widget.defaultValue > 0) {
      position.animateTo(
        widget.defaultValue * 10.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    }
  }

  int scaleValue = 0;

  @override
  void initState() {
    scrollController = ScrollController(
      onAttach: setPosition,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    scrollController.addListener(() {
      int pixel = (scrollController.offset ~/ 10).toInt();
      setState(() {
        Future.delayed(const Duration(seconds: 1));
        if (pixel <= 100) {
          scaleValue = pixel;
        }
      });
      widget.onChange(scaleValue);
    });

    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Cambiar a vertical
      controller: scrollController,
      child: Container(
        width:
            80, // Cambiar a ancho fijo para adaptarlo a la dirección vertical
        margin: EdgeInsets.symmetric(vertical: height / 2 - widget.marginTop),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            widget.steps + 1,
            (index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              width: index == scaleValue ? 80 : (index % 4 == 0 ? 40 : 20),
              height:
                  2, // Cambiar la altura fija para adaptarse a la dirección vertical
              color: index == scaleValue
                  ? widget.selectedTrackColor
                  : widget.unselectedTrackColor,
            ),
          ),
        ),
      ),
    );
  }
}
