import 'package:fl_chart/fl_chart.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/analitica/controller.dart';
import 'package:macrolife/screen/peso/screen.dart';
import 'package:macrolife/screen/peso_objetivo/screen.dart';
import 'package:macrolife/screen/analitica/info.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class AnaliticaScreen extends StatelessWidget {
  const AnaliticaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController usuarioController = Get.put(UsuarioController());
    final AnaliticaController controller = Get.put(AnaliticaController());
    controller.fetchNutricion();
    controller.fetchPesoHistorial();

    return Container(
      decoration: BoxDecoration(color: backGround),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Vista general',
                  style: TextStyle(
                    fontSize: 30,
                    color: blackTheme_,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/icono_checkverde_53x53_nuevo.png',
                          width: 27,
                          // color: blackTheme_,
                          colorBlendMode: BlendMode.color,
                        ),
                        const SizedBox(width: 10),
                        Obx(
                          () => Text.rich(
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            TextSpan(
                              text: 'Peso objetivo: ',
                              style: const TextStyle(color: blackTheme_),
                              children: [
                                TextSpan(
                                  text:
                                      '${usuarioController.usuario.value.pesoObjetivo} Kg',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => {Get.to(() => PesoObjetivosScreen())},
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                        decoration: BoxDecoration(
                          color: blackTheme_,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Actualizar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: blackTheme_,
                                      // backgroundBlendMode: BlendMode.clear,
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Image.asset(
                                    'assets/icons/icono_cajon_ejercicio_88x88_registrar.png',
                                    width: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Obx(
                                  () => Text.rich(
                                    TextSpan(
                                      text: 'Peso actual',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: blackTheme_,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              ' ${usuarioController.usuario.value.pesoActual} kg',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Recuerda actualizar esto al menos una vez a la semana para que podamos ajustar tu plan y alcanzar tu objetivo',
                              style: TextStyle(
                                  fontSize: 13, color: blackThemeText),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Acción del botón
                          Get.to(() => PesoActualizarScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                            color: blackTheme_,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Actualiza tu peso',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Tu IMC',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: blackTheme_,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  var resultadoIMC = calcularIMCConClasificacion(
                    usuarioController.usuario.value.pesoActual ?? 0,
                    (usuarioController.usuario.value.altura ?? 0) / 100,
                  );

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título y categoría
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Tu peso es',
                                      style: TextStyle(color: blackThemeText),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: resultadoIMC['clasificacion']
                                            ['color'],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${resultadoIMC['clasificacion']['texto']}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                await Get.to(() => InfoIMC());
                              },
                              icon: const Icon(
                                Icons.help_outline,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Peso
                        Text(
                          '${resultadoIMC['imc'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: blackTheme_,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Indicador de rango
                        IMCBar(imc: resultadoIMC['imc']),

                        const SizedBox(height: 16),

                        // Etiquetas de rango
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LegendItem(color: Colors.blue, text: 'Bajo peso'),
                            LegendItem(color: Colors.green, text: 'Saludable'),
                            LegendItem(color: Colors.yellow, text: 'Sobrepeso'),
                            LegendItem(color: Colors.red, text: 'Obeso'),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Text(
                  'Progreso de objetivos',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: blackTheme_),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.listaProgreso.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.tipoBusquedaProgreso.value =
                                controller.listaProgreso[index];
                            controller.fetchPesoHistorial();
                          },
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              color: controller.tipoBusquedaProgreso.value ==
                                      controller.listaProgreso[index]
                                  ? blackTheme_
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1,
                                color: controller.tipoBusquedaProgreso.value ==
                                        controller.listaProgreso[index]
                                    ? Colors.white
                                    : blackTheme_,
                              ),
                            ),
                            child: Text(
                              controller.listaProgreso[index],
                              style: TextStyle(
                                color: controller.tipoBusquedaProgreso.value ==
                                        controller.listaProgreso[index]
                                    ? Colors.white
                                    : blackThemeText,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 220,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 0.1,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        intervalType: DateTimeIntervalType.months,
                        dateFormat: DateFormat('MMMM', 'es'),
                        maximumLabels: 4,
                      ),
                      primaryYAxis: NumericAxis(
                        minimum: controller.chartAxis.value.minimo,
                        maximum: controller.chartAxis.value.maximo,
                        interval: 10,
                        labelFormat: '{value} kg',
                        majorGridLines: MajorGridLines(width: 0),
                        axisLine: AxisLine(width: 0),
                        plotBands: (controller.chartData.length) == 1
                            ? <PlotBand>[
                                PlotBand(
                                  isVisible: true,
                                  start: controller.chartData.first.y,
                                  end: controller.chartData.first.y,
                                  color: greyTheme_,
                                  borderColor: blackTheme_,
                                  borderWidth: 2,
                                )
                              ]
                            : <PlotBand>[],
                      ),
                      series: <LineSeries<ChartDataP, DateTime>>[
                        LineSeries<ChartDataP, DateTime>(
                          color: blackTheme_,
                          dataSource: controller.chartData,
                          xValueMapper: (ChartDataP data, _) => data.x,
                          yValueMapper: (ChartDataP data, _) => data.y,
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            width: 4,
                            height: 4,
                            color: blackTheme_,
                          ),
                          enableTooltip: true,
                        ),
                      ],
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        header: '',
                        canShowMarker: true,
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          final yValue = point?.y ?? 0;
                          return Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${yValue.toStringAsFixed(0)} kg',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Nutrición',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: blackTheme_),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.listaNutricion.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.tipoBusquedaNutricion.value =
                                controller.listaNutricion[index];
                            controller.fetchNutricion();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              color: controller.tipoBusquedaNutricion.value ==
                                      controller.listaNutricion[index]
                                  ? blackTheme_
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1,
                                color: controller.tipoBusquedaNutricion.value ==
                                        controller.listaNutricion[index]
                                    ? Colors.white
                                    : blackTheme_,
                              ),
                            ),
                            child: Text(
                              controller.listaNutricion[index],
                              style: TextStyle(
                                color: controller.tipoBusquedaNutricion.value ==
                                        controller.listaNutricion[index]
                                    ? Colors.white
                                    : blackThemeText,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Container(
                    height:
                        controller.analiticaNutricion.value.caloriasTotales == 0
                            ? 220
                            : null,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 0.1,
                        ),
                      ],
                    ),
                    child: controller
                                .analiticaNutricion.value.caloriasTotales ==
                            0
                        ? const Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                'No hay datos para mostrar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackThemeText,
                                ),
                              ),
                              Text(
                                  'Esto se actualiza a medida que registras más alimentos'),
                            ],
                          ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Text(
                                        '${controller.analiticaNutricion.value.caloriasTotales ?? '0'}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: blackTheme_,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        '${controller.analiticaNutricion.value.promedioGeneral ?? '0'}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: blackTheme_,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Calorías totales',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: blackThemeText,
                                      ),
                                    ),
                                    Text(
                                      'Promedio diario',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: blackThemeText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 140,
                                child: Obx(
                                  () => BarChart(
                                    BarChartData(
                                      barGroups: controller.charSorce
                                          .asMap()
                                          .entries
                                          .map(
                                            (entry) => BarChartGroupData(
                                              x: entry.key,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: entry.value.value,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                  width: 25,
                                                  color: Colors.transparent,
                                                  rodStackItems: [
                                                    BarChartRodStackItem(
                                                      (entry.value.value *
                                                              0.3) +
                                                          (entry.value.value *
                                                              0.27),
                                                      (entry.value.value *
                                                              0.3) +
                                                          (entry.value.value *
                                                              0.27) +
                                                          (entry.value.value *
                                                              0.43),
                                                      redTheme_,
                                                    ),
                                                    BarChartRodStackItem(
                                                      entry.value.value * 0.3,
                                                      (entry.value.value *
                                                              0.3) +
                                                          (entry.value.value *
                                                              0.27),
                                                      yellowTheme_,
                                                    ),
                                                    BarChartRodStackItem(
                                                      0,
                                                      entry.value.value * 0.3,
                                                      blueTheme_,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        topTitles: AxisTitles(
                                            drawBelowEverything: false),
                                        rightTitles: AxisTitles(
                                            drawBelowEverything: true),
                                        bottomTitles: AxisTitles(
                                          drawBelowEverything: true,
                                          axisNameSize: 10,
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) =>
                                                controller.getTitles(
                                                    value, meta),
                                          ),
                                        ),
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
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IMCBar extends StatelessWidget {
  final double imc;

  const IMCBar({super.key, required this.imc});

  @override
  Widget build(BuildContext context) {
    const double maxIMC = 50; // Valor máximo esperado del IMC
    double barWidth = Get.width; // Ancho del contenedor del gradiente

    // Calcular posición de la línea negra en función del IMC
    double leftPosition = (imc.clamp(0, maxIMC) / maxIMC) * barWidth;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: barWidth,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.red,
              ],
              stops: [0.0, 0.33, 0.66, 0.85, 1.0],
            ),
          ),
        ),
        Positioned(
          left: leftPosition,
          top: -10,
          child: Container(
            width: 1.5,
            height: 25,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

Map<String, dynamic> calcularIMCConClasificacion(int peso, double altura) {
  double imc = peso / (altura * altura);

  if (imc.isNaN) {
    imc = 0;
  }

  // Clasificación del IMC con colores
  String clasificacion;
  Color color;

  if (imc < 18.5) {
    clasificacion = "Peso insuficiente";
    color = Colors.blue;
  } else if (imc >= 18.5 && imc < 24.9) {
    clasificacion = "Peso normal";
    color = Colors.green;
  } else if (imc >= 25 && imc < 29.9) {
    clasificacion = "Sobrepeso";
    color = Colors.orange;
  } else if (imc >= 30 && imc < 34.9) {
    clasificacion = "Obesidad grado I";
    color = Colors.redAccent;
  } else if (imc >= 35 && imc < 39.9) {
    clasificacion = "Obesidad grado II";
    color = Colors.red;
  } else {
    clasificacion = "Obesidad grado III";
    color = Colors.red;
  }
  return {
    "imc": imc,
    "clasificacion": {
      "texto": clasificacion,
      "color": color,
    }
  };
}
