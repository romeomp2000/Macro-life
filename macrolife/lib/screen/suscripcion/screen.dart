import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:macrolife/config/theme.dart';
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
          SizedBox(
            width: Get.width,
            // height: 600,
            child: CarouselSlider(
                items: controller.images.map((e) {
                  return Image.asset(
                    e,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: Get.width,
                    // height: 600,
                  );
                }).toList(),
                options: CarouselOptions(
                  disableCenter: false,
                  height: 600,
                  aspectRatio: 4 / 3,
                  viewportFraction: 1,
                  initialPage: 3,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.linear,
                  enlargeCenterPage: true,
                  enlargeFactor: 0,
                  scrollDirection: Axis.horizontal,
                )),
          ),
          // Image.asset(
          //   controller.imagenUrl.value,
          //   fit: BoxFit.cover,
          //   alignment: Alignment.bottomCenter,
          //   width: Get.width,
          //   height: 600,
          // ),
          DraggableScrollableSheet(
            snap: false,
            minChildSize: 0.45,
            maxChildSize: 0.45,
            initialChildSize: 0.45,
            builder: (context, scrollController) {
              return Container(
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
                      const SizedBox(height: 5),
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
                                controller.totalAPagar.value = controller
                                        .configuraiones
                                        .configuraciones
                                        .value
                                        .suscripcion
                                        ?.mensual ??
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
                                GetStorage box = GetStorage();
                                bool? isPromoActive = box.read('promo');

                                double anualPrice = controller
                                        .configuraiones
                                        .configuraciones
                                        .value
                                        .suscripcion
                                        ?.anual ??
                                    0.0;

                                if (isPromoActive != null && isPromoActive) {
                                  controller.totalAPagar.value =
                                      anualPrice * 0.5;
                                } else {
                                  controller.totalAPagar.value = anualPrice;
                                }
                              },
                              child: tipoPago(
                                  precio:
                                      '\$${NumberFormat.decimalPattern().format((controller.configuraiones.configuraciones.value.suscripcion?.anual ?? 0 * (controller.configuraiones.configuraciones.value.suscripcion?.descuentoAnual ?? 0)).toDouble())} /año',
                                  tipo: 'Anual',
                                  valor: controller.sucripcion.value,
                                  descuento:
                                      '${controller.configuraiones.configuraciones.value.suscripcion?.descuentoAnual?.toStringAsFixed(0)}'),
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
                onPressed: () {
                  // controller.promocion();
                  Get.bottomSheet(promoText());
                },
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

  Widget promoText() {
    final controller = Get.put(SuscripcionController());
    return Container(
      width: Get.width,
      height: Get.height * 0.7,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteTheme_,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Solo por hoy 50% de descuento en la suscripción ANUAL',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(
              width: Get.width,
              child: buildTimelineItem(
                  icon: Icons.check_circle,
                  iconColor: blackTheme2_,
                  title: 'Acceso a macrolife IA',
                  description:
                      'La mejor IA para cumplir tus metas para tu salud'),
            ),
            SizedBox(
              width: Get.width,
              child: buildTimelineItem(
                  icon: Icons.check_circle,
                  iconColor: blackTheme2_,
                  title: 'Precio mensual más bajo',
                  description:
                      'Solo por este dia el precio mensual será más barato que el actual. Precio nuevo: \$${((double.parse(controller.configuraiones.configuraciones.value.suscripcion!.anual?.toString() ?? '0') / 12) / 2).toStringAsFixed(2)}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: whiteTheme_,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: blackTheme2_)),
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: Text(' Cerrar ')),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: blackTheme2_,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      controller.promocion();
                      Get.back();
                    },
                    child: Text(
                      'Aceptar oferta',
                      style: TextStyle(
                          color: whiteTheme_,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                'Precio nuevo: \$${(double.parse(controller.configuraiones.configuraciones.value.suscripcion!.anual.toString()) / 2).toStringAsFixed(2)} / anual',
                style: TextStyle(
                  color: blackTheme2_,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimelineItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(icon, color: iconColor),
              Container(
                width: 2,
                height: 40,
                color: greenTheme1_,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
