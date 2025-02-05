import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/analitica/screen.dart';

class InfoIMC extends StatelessWidget {
  const InfoIMC({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController usuarioController = Get.put(UsuarioController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/iconografia_navegacion_120x120_regresar.png',
          ),
          onPressed: () => Get.back(),
        ),
        title: Text('IMC'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Obx(() {
                var resultadoIMC = calcularIMCConClasificacion(
                  usuarioController.usuario.value.pesoActual ?? 0,
                  (usuarioController.usuario.value.altura ?? 0) / 100,
                );

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: whiteTheme_,
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
                                  const Text(
                                    'Tu peso es',
                                    style: TextStyle(color: blackTheme_),
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        'Aviso legal',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: blackTheme_,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        '''Como ocurre con la mayoría de las medidas de salud, el IMC no es una prueba perfecta. Por ejemplo, los resultados pueden verse afectados por el embarazo o una alta masa muscular, y puede que no sea una buena medida de salud para niños o ancianos.''',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: blackThemeText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        'Entonces, ¿Por qué importa el IMC?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: blackTheme_,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        '''En general, cuanto mayor es tu IMC, mayor es el riesgo de desarrollar una serie de condiciones asociadas con el exceso de peso, incluyendo:
        • diabetes
        • artritis
        • enfermedad del hígado
        • varios tipos de cáncer (como los del seno, colon y próstata)
        • presión arterial alta (hipertensión)
        • colesterol alto
        • apnea del sueño.''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: blackThemeText,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
