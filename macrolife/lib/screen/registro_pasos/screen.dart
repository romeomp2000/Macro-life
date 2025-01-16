import 'package:macrolife/helpers/funciones_globales.dart';
import 'package:macrolife/models/list_tile_model.dart';
import 'package:macrolife/screen/registro_pasos/paso_1.dart';
import 'package:macrolife/screen/registro_pasos/paso_10.dart';
import 'package:macrolife/screen/registro_pasos/paso_11.dart';
import 'package:macrolife/screen/registro_pasos/paso_12.dart';
import 'package:macrolife/screen/registro_pasos/paso_13.dart';
import 'package:macrolife/screen/registro_pasos/paso_14.dart';
import 'package:macrolife/screen/registro_pasos/paso_15.dart';
import 'package:macrolife/screen/registro_pasos/paso_16.dart';
import 'package:macrolife/screen/registro_pasos/paso_17.dart';
import 'package:macrolife/screen/registro_pasos/paso_18.dart';
import 'package:macrolife/screen/registro_pasos/paso_2.dart';
import 'package:macrolife/screen/registro_pasos/paso_3.dart';
import 'package:macrolife/screen/registro_pasos/paso_4.dart';
import 'package:macrolife/screen/registro_pasos/paso_5_.dart';
import 'package:macrolife/screen/registro_pasos/paso_5_5.dart';
import 'package:macrolife/screen/registro_pasos/paso_6.dart';
import 'package:macrolife/screen/registro_pasos/paso_7_.dart';
import 'package:macrolife/screen/registro_pasos/paso_7_1.dart';
import 'package:macrolife/screen/registro_pasos/paso_7_2.dart';
import 'package:macrolife/screen/registro_pasos/paso_7_3.dart';
import 'package:macrolife/screen/registro_pasos/paso_7_4.dart';
import 'package:macrolife/screen/registro_pasos/paso_8.dart';
import 'package:macrolife/screen/registro_pasos/paso_9.dart';
import 'package:macrolife/widgets/Cinta_metrica.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:macrolife/widgets/custom_elevated_selected.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'controller.dart';

class RegistroPasosScreen extends StatelessWidget {
  const RegistroPasosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistroPasosController controller =
        Get.put(RegistroPasosController());

    // final UsuarioController controllerUsuario = Get.put(UsuarioController());
    // final TimerPickerController timePic = Get.put(TimerPickerController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        title: Row(
          spacing: 15,
          children: [
            Container(
              margin: EdgeInsets.only(top: 1, bottom: 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 237, 237, 237),
                        offset: Offset(0.1, 0.1),
                        blurRadius: 1),
                  ]),
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
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 237, 237, 237),
                        offset: Offset(0.1, 0.1),
                        blurRadius: 1,
                      ),
                    ]),
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
            //Genero
            paso_1(controller),

            //Nivel de actividad
            paso_2(controller),

            //Otras apps de calorías
            paso_3(controller),

            //Grafica de potencial
            paso_4(controller),

            //Edad
            paso_5(controller),

            //Altura
            paso_5_5(controller),

            //Peso
            paso_6(controller),

            //Cual es tu objetivo
            paso_7(controller),

            //Objetivo de peso
            if (controller.objetivo.value == 'Aumentar' ||
                controller.objetivo.value == 'Perder')
              paso_7_1(controller),

            //Velocidad para la meta
            if (controller.objetivo.value != 'Mantener') paso_7_2(controller),

            //Grafica de barras para mostrar el uso de la app
            if (controller.mostrarGrafica.value == true) paso_7_3(controller),

            //Vista para  mostrar el objetivo y mensaje
            if (controller.objetivo.value != 'Mantener') paso_7_4(controller),

            //GRafica de resultados a largo plazo
            paso_8(controller),

            //Que le gustaria conseguir
            paso_9(controller),

            //Dieta
            paso_10(controller),

            //Notificaciones
            paso_11(controller),

            //Opiniones
            paso_12(controller),

            //Hora de notificaciones
            paso_13(controller),

            //Codigo de referencia
            paso_14(controller),

            //Apple Health
            if (GetPlatform.isIOS) paso_15(controller),

            //Inicio de sesión
            paso_16(controller),

            //Felicidades del registro
            paso_17(controller),

            //Plan muestra
            paso_18(controller),
            // paso_19(controller),
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
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 237, 237, 237),
                    offset: Offset(0.1, 0.1),
                    blurRadius: 0.0001,
                  ),
                ]),
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
                        : Color.fromARGB(255, 193, 193, 193),
                  ),
                  Text(
                    genero,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: selected == true
                          ? Colors.black
                          : Color.fromARGB(255, 193, 193, 193),
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
      child: Container(
        width: Get.width * 0.4,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 246, 246, 246)),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  imagen,
                  width: 25,
                ),
                VerticalDivider(
                  color: Colors.grey.shade800,
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      puntaje,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                value: .5,
                color: Colors.black,
              ),
            )
          ],
        ),
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
  final bool? enableScroll;
  final bool? enablePadding;
  final bool? isBascula;
  final bool? isRuler;
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
    this.enableScroll = false,
    this.decoration,
    this.enablePadding = false,
    this.isBascula = false,
    this.selectedOptions,
    this.enabledButtonSaltar = false,
    required this.isActivo,
    this.isRuler = false,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: enableScroll ?? false
  //         ? SingleChildScrollView(
  //             child: _buildContent(),
  //           )
  //         : _buildContent(),
  //     extendBody: false,
  //     bottomNavigationBar: Container(
  //       margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
  //       child: Row(
  //         spacing: 10,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           if (enabledButtonSaltar == true)
  //             Expanded(
  //               child: Container(
  //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(50),
  //                     border: Border.all(
  //                       color: Color.fromARGB(255, 237, 237, 237),
  //                     )),
  //                 child: TextButton(
  //                   onPressed: onNext,
  //                   child: Text(
  //                     'Saltar',
  //                     style: TextStyle(
  //                         color: Colors.black, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           Expanded(
  //             child: buttonTest(textBTN ?? 'Siguiente', onNext, isActivo.value),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _buildContent(),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              spacing: 10,
              children: [
                if (enabledButtonSaltar == true)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Color.fromARGB(255, 237, 237, 237),
                          )),
                      child: TextButton(
                        onPressed: onNext,
                        child: Text(
                          'Saltar',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: buttonTest(
                    textBTN ?? 'Siguiente',
                    onNext,
                    isActivo.value,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      child: Column(
        spacing: isBascula! || isRuler! ? 0 : 15,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isBascula! ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (description != null)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      description ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
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
