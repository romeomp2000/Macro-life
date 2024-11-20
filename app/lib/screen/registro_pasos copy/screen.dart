import 'package:fep/models/list_tile_model.dart';
import 'package:fep/widgets/custom_elevated_button.dart';
import 'package:fep/widgets/custom_elevated_selected.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistroPasosScreen extends StatelessWidget {
  const RegistroPasosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistroPasosController controller =
        Get.put(RegistroPasosController());

    return Scaffold(
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
                    icon: Icon(
                      Icons.circle,
                      color: controller.entrenamiento.value == '0-2'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTileModel(
                    title: '3-5',
                    subtitle: 'Unos cuatro entrenamientos por semana',
                    icon: Icon(
                      Icons.grid_3x3,
                      color: controller.entrenamiento.value == '3-5'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTileModel(
                    title: '6+',
                    subtitle: 'Atleta dedicado',
                    icon: Icon(
                      Icons.playlist_add_check,
                      color: controller.entrenamiento.value == '6+'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
                onOptionSelected: (entrenamiento) {
                  controller.entrenamiento.value = entrenamiento;
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
                    icon: Icon(
                      Icons.thumb_down,
                      color: controller.probado.value == 'No'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  ListTileModel(
                    title: 'Si',
                    icon: Icon(
                      Icons.thumb_up,
                      color: controller.probado.value == 'Si'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext:
                    controller.isProbadoSelected() ? controller.nextStep : null,
              ),
            ),

            Obx(
              () => Steep(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Define el radio de los bordes
                    child: Image.asset(
                      'assets/images/registro/grafica_peso.png',
                    ),
                  ),
                ),
                title: 'MACRO LIFE crea resultados a largo plazo',
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
                  onPesoSelected: (value) => controller.peso,
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
                title: 'Cual es tu objetivo',
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
                onOptionSelected: (objetivo) =>
                    controller.objetivo.value = objetivo,
                selectedOption: controller.objetivo.value,
                onNext: controller.isObjetivoSelected()
                    ? controller.nextStep
                    : null,
              ),
            ),

            Obx(
              () => Steep(
                title: '¿Cual es tu pesos deseado?',
                options: [],
                body: CintaMedirWidget(
                  pesoInicial: 10,
                  onPesoSeleccionado: (pesoDeseado) =>
                      controller.pesoDeseado.value = pesoDeseado,
                  pesoDeseado: controller.pesoDeseado.value,
                ),
                onOptionSelected: (probado) =>
                    controller.probado.value = probado,
                selectedOption: controller.probado.value,
                onNext:
                    controller.isProbadoSelected() ? controller.nextStep : null,
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
                              text: controller.peso.value >
                                      controller.pesoDeseado.value
                                  ? 'Perdiendo '
                                  : 'Ganando ',
                              style: TextStyle(
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

            // Aquí puedes añadir más widgets para otros pasos.
          ],
        ),
      ),
    );
  }
}

class Steep extends StatelessWidget {
  final String title;
  final String? description;
  final List<ListTileModel> options;
  final Widget? body;
  final ValueChanged<String> onOptionSelected;
  final String selectedOption;
  final VoidCallback? onNext;

  const Steep({
    super.key,
    required this.title,
    this.description,
    required this.options,
    required this.onOptionSelected,
    required this.selectedOption,
    required this.onNext,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
        Column(
          children: [
            body != null ? body! : Container(),
            ...options.map(
              (option) => Column(
                children: [
                  CustomElevatedSelected(
                    message: option.title ?? '',
                    icon: option.icon,
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
            CustomElevatedButton(
              message: 'Siguiente',
              function: onNext,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
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

class CintaMedirWidget extends StatefulWidget {
  final int pesoInicial; // Valor inicial del peso
  final int pesoDeseado; // Peso deseado
  final ValueChanged<int>
      onPesoSeleccionado; // Callback para el peso seleccionado

  const CintaMedirWidget({
    super.key,
    required this.pesoInicial,
    required this.pesoDeseado,
    required this.onPesoSeleccionado,
  });

  @override
  State<CintaMedirWidget> createState() => _CintaMedirWidgetState();
}

class _CintaMedirWidgetState extends State<CintaMedirWidget> {
  late int pesoActual; // Guardar el peso actual mientras se hace el scroll
  final double itemWidth = 10.0; // Ancho de las divisiones

  @override
  void initState() {
    super.initState();
    pesoActual =
        widget.pesoInicial; // Inicializamos el peso con el valor pasado
  }

  void _actualizarPesoConDesplazamiento(double desplazamiento) {
    final int nuevoPeso =
        (pesoActual + desplazamiento ~/ itemWidth).clamp(0, 1000);
    if (nuevoPeso != pesoActual) {
      setState(() {
        pesoActual = nuevoPeso;
      });
      widget
          .onPesoSeleccionado(nuevoPeso); // Llama al callback con el nuevo peso
    }
  }

  @override
  Widget build(BuildContext context) {
    final int minPeso = 0;
    final int maxPeso = 1000;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Perder peso',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '${widget.pesoDeseado} kg', // Mostrar el peso deseado fijo
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 70, // Ajustamos el tamaño para hacer las líneas más compactas
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  _actualizarPesoConDesplazamiento(details.primaryDelta ?? 0);
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      maxPeso - minPeso + 1,
                      (index) {
                        final int peso = minPeso + index;
                        return Container(
                          width: itemWidth,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 45,
                                child: CustomPaint(
                                  painter: RulerPainter(
                                    isMultipleOfTen: peso % 10 == 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: 2,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: widget.pesoDeseado == pesoActual
                            ? Colors
                                .green // Color verde cuando es el peso deseado
                            : Colors.black,
                        width: 1),
                    // borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
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
