import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/screen/pago_vencido/controller.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';

class PagoVencido extends StatelessWidget {
  const PagoVencido({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PagoVencidoController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () => Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  controller.sucripcion.value == 'Anual'
                      ? 'Vuelve a pagar el plan anual para usar Macro Life'
                      : 'Utiliza Macro Life para alcanzar tus metas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: paso3(controller),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.sucripcion.value = 'Mensual';
                              controller.totalAPagar.value = controller
                                      .configuraciones
                                      .configuraciones
                                      .value
                                      .suscripcion
                                      ?.mensual ??
                                  0.0;
                            },
                            child: tipoPago(
                              precio:
                                  '\$${(controller.configuraciones.configuraciones.value.suscripcion?.mensual ?? 0).toDouble().toStringAsFixed(2)} /mes',
                              tipo: 'Mensual',
                              valor: controller.sucripcion.value,
                            ),
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.sucripcion.value = 'Anual';

                              double anualPrice = controller
                                      .configuraciones
                                      .configuraciones
                                      .value
                                      .suscripcion
                                      ?.anual ??
                                  0.0;

                              controller.totalAPagar.value = anualPrice;
                            },
                            child: tipoPago(
                                precio:
                                    '\$${NumberFormat.decimalPattern().format((controller.configuraciones.configuraciones.value.suscripcion?.anual ?? 0 * (controller.configuraciones.configuraciones.value.suscripcion?.descuentoAnual ?? 0)).toDouble())} /año',
                                tipo: 'Anual',
                                valor: controller.sucripcion.value,
                                descuento:
                                    '${controller.configuraciones.configuraciones.value.suscripcion?.descuentoAnual?.toStringAsFixed(0)}'),
                          ),
                        )
                      ],
                    ),
                  ),
                  buttonTest('Suscribirse', () {
                    controller.pagar();
                  }, true),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 2),
                    child: Text(
                      'Solo \$${controller.anualPrice.toStringAsFixed(2)} por año (\$${((controller.anualPrice) / 12).toStringAsFixed(2)}/mes)',
                      style: TextStyle(
                        color: Color.fromARGB(255, 180, 180, 180),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paso3(PagoVencidoController controller) {
    return Column(
      children: [
        Obx(
          () => controller.sucripcion.value == 'Anual'
              ? Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: buildTimelineItem(
                          icon: Icons.punch_clock,
                          iconColor: Colors.orange,
                          title: 'Hoy',
                          description:
                              'Desbloquea todos los beneficios de la aplicación como escanear comida y más'),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: buildTimelineItem(
                          icon: Icons.notifications,
                          iconColor: Colors.orange,
                          title: 'Beneficios por otro año',
                          description:
                              'Gozaras de todos los beneficios de Macro Life por otro año más.'),
                    ),
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: buildTimelineItem(
                          icon: Icons.check,
                          iconColor: Colors.black,
                          title: 'Tu progreso se mantendrá',
                          description:
                              'Todos tus datos, progresos y más, estarán seguro en nuestros servidores'),
                    ),
                  ],
                )
              : SizedBox(
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fácil escaneo de comida',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Obtén tus calorías con una imagen',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Consigue el cuerpo de tus sueños',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Lo hacemos fácil para que tu obtengas tus resultados',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sigue tu progreso',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Mantente informado con mensajes personalizados y recordatorios inteligentes',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget buildTimelineItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(
                      50,
                    )),
                child: Icon(icon, color: whiteTheme_),
              ),
              Container(
                width: 10,
                height: 60,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
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
          // margin: const EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: valor == tipo ? Colors.black : Colors.black12,
              width: 2,
            ),
          ),
          width: Get.width / 2 - 30,
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
