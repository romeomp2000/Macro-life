import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:macrolife/config/theme.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:macrolife/screen/pago/controller.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

class PagoVista extends StatelessWidget {
  const PagoVista({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PagoController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: whiteTheme_,
        leading: Obx(
          () => controller.paso.value > 1
              ? Container(
                  margin: EdgeInsets.only(top: 1, bottom: 1, left: 10),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => {controller.disminuir()},
                  ),
                )
              : SizedBox(),
        ),
      ),
      extendBody: true,
      backgroundColor: whiteTheme_,
      body: Container(
        height: Get.height,
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: controller.paso.value == 2
                        ? MainAxisAlignment.center
                        : controller.paso.value == 3
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              bottom: controller.paso.value == 2 ||
                                      controller.paso.value == 3
                                  ? 35
                                  : 0),
                          child: Text(
                            controller.paso.value == 1
                                ? 'Prueba  Macro Life gratis'
                                : controller.paso.value == 2
                                    ? 'Nosotros te recordaremos antes de que tu prueba finalice'
                                    : controller.sucripcion.value == 'Anual'
                                        ? 'Comienza tus 3 días de prueba gratis'
                                        : 'Utiliza Macro Life para alcanzar tus metas',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          if (controller.paso.value == 1) {
                            return Container(
                              color: whiteTheme_,
                              height: 520,
                              // height: Get.height,
                              child: VideoPlayer(controller.controllerVideo),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      Obx(() {
                        if (controller.paso.value == 2) {
                          return Container(
                              margin: EdgeInsets.only(top: Get.width * 0.3),
                              child: paso2(controller));
                        }
                        return SizedBox();
                      }),
                      Obx(() {
                        if (controller.paso.value == 3) {
                          return Center(child: paso3(controller));
                        }
                        return SizedBox();
                      })
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => controller.paso.value == 3
                      ? Container(
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
                                    // GetStorage box = GetStorage();
                                    // bool? isPromoActive = box.read('promo');

                                    double anualPrice = controller
                                            .configuraciones
                                            .configuraciones
                                            .value
                                            .suscripcion
                                            ?.anual ??
                                        0.0;

                                    // if (isPromoActive != null && isPromoActive) {
                                    //   controller.totalAPagar.value = anualPrice * 0.5;
                                    // } else {
                                    controller.totalAPagar.value = anualPrice;
                                    // }
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
                        )
                      : SizedBox()),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(Icons.done),
                        ),
                        Text(
                          'No hay pagos pendientes',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => buttonTest(
                        controller.paso.value != 3
                            ? 'Prueba gratis'
                            : 'Suscribirse', () {
                      controller.paso.value != 3
                          ? controller.incrementar()
                          : controller.pagar();
                    }, true),
                  ),
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

  Widget paso1(PagoController controller) {
    return VideoPlayer(controller.controllerVideo);
  }

  Widget paso2(PagoController controller) {
    return Image.asset(
      'assets/icons/imagen_campana_380x422_original.png',
      width: 150,
    );
  }

  Widget paso3(PagoController controller) {
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
                          title: 'En 2 días te recordaremos',
                          description:
                              'Te enviaremos una notificación para recordarte que tu prueba esta proxima a finalizar'),
                    ),
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: buildTimelineItem(
                          icon: Icons.check,
                          iconColor: Colors.black,
                          title: 'En 3 días comienzas a pagar',
                          description:
                              'En 3 días tu comenzaras a pagar para usar la aplicación puedes cancelar en cualquier momento'),
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
