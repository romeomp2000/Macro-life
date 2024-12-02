import 'package:fep/helpers/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnaliticaScreen extends StatelessWidget {
  const AnaliticaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UsuarioController usuarioController = Get.put(UsuarioController());
    var resultadoIMC = calcularIMCConClasificacion(
      usuarioController.usuario.value.pesoActual ?? 0,
      (usuarioController.usuario.value.altura ?? 0) / 100, // Convertir a metros
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://macrolife.app/images/app/home/background_1125x2436_uno.jpg', // URL de tu imagen
          ),
          fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vista general',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://macrolife.app/images/app/home/icono_check_53x53_naranja.png',
                        width: 27,
                      ),
                      const SizedBox(width: 10),
                      Text.rich(
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        TextSpan(
                          text: 'Peso objetivo: ',
                          style: const TextStyle(color: Colors.black),
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
                    ],
                  ),
                  GestureDetector(
                    onTap: () => {},
                    // st: ElevatedButton.styleFrom(
                    //   foregroundColor: Colors.white,
                    //   backgroundColor: Colors.black, // Letras blancas
                    //   padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    // ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
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
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  backgroundBlendMode: BlendMode.clear,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://macrolife.app/images/app/home/icono_cajon_ejercicio_88x88_registrar.png',
                                  width: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text.rich(
                                TextSpan(
                                  text: 'Peso actual',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
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
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Recuerda actualizar esto al menos una vez a la semana para que podamos ajustar tu plan y alcanzar tu objetivo',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Acción del botón
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          color: Colors.black,
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
                ),
              ),
              const SizedBox(height: 10),
              Container(
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
                                const Text(
                                  'Tu peso es',
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
                        const Icon(
                          Icons.help_outline,
                          color: Colors.black54,
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
                        color: Colors.black,
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
              )
            ],
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
  if (altura <= 0) {
    throw ArgumentError("La altura debe ser mayor a 0.");
  }

  double imc = peso / (altura * altura);

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
