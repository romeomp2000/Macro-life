import 'package:macrolife/screen/suscripcion/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuscripcionScreen extends StatelessWidget {
  const SuscripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuscripcionController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            controller.imagenUrl.value,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            width: Get.width,
            height: 600,
          ),
          DraggableScrollableSheet(
            snap: false,
            minChildSize: 0.36,
            maxChildSize: 0.36,
            initialChildSize: 0.36,
            builder: (context, scrollController) {
              return Container(
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Acceso ilimitado a',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/icons/logo_macro_life_1125x207.png',
                        width: 155,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.sucripcion.value = 'Mensual';
                                controller.configuraiones.configuraciones.value
                                        .suscripcion?.mensual ??
                                    0.0;
                              },
                              child: tipoPago(
                                precio:
                                    '\$${(controller.configuraiones.configuraciones.value.suscripcion?.mensual ?? 0).toDouble().toStringAsFixed(2)} /mes',
                                tipo: 'Mensual',
                                valor: controller.sucripcion.value,
                              ),
                            ),
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.sucripcion.value = 'Anual';
                                controller.configuraiones.configuraciones.value
                                        .suscripcion?.anual ??
                                    0.0;
                              },
                              child: tipoPago(
                                  precio:
                                      '\$${NumberFormat.decimalPattern().format((controller.configuraiones.configuraciones.value.suscripcion!.anual! * controller.configuraiones.configuraciones.value.suscripcion!.descuentoAnual! / 100).toDouble())} /año',
                                  tipo: 'Anual',
                                  valor: controller.sucripcion.value,
                                  descuento:
                                      '${controller.configuraiones.configuraciones.value.suscripcion!.descuentoAnual!.toStringAsFixed(0)}'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.pagar();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(20),
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text('Suscribete',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            right: 25,
            top: 45,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: IconButton(
                iconSize: 23,
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tipoPago({
    required String tipo,
    required String precio,
    required String valor,
    String? descuento,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: valor == tipo ? Colors.black : Colors.black12,
              width: 3,
            ),
          ),
          width: Get.width / 2 - 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    tipo,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    precio,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              if (valor == tipo)
                const Icon(Icons.check_circle, size: 30)
              else
                const Icon(
                  Icons.circle_outlined,
                  size: 30,
                  color: Colors.black12,
                )
            ],
          ),
        ),
        if (descuento != null)
          Positioned(
            top: -10,
            right: 0,
            left: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Oferta $descuento%',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
