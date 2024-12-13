import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:macrolife/helpers/AplePay.dart';
import 'package:macrolife/helpers/StripePaymentHandle.dart';
import 'package:macrolife/screen/suscripcion/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:macrolife/widgets/button_paypal.dart';
import 'package:pay/pay.dart';

class SuscripcionScreen extends StatelessWidget {
  const SuscripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuscripcionController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: controller.imagenUrl.value,
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
                      CachedNetworkImage(
                        imageUrl:
                            'https://macrolife.app/images/app/logo/logo_macro_life.png',
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
                              onPressed: pagar,
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

  void pagar() {
    Get.bottomSheet(
      isDismissible: true, // Permite cerrar al presionar fuera
      enableDrag: true, // Permite deslizar para cerrar
      persistent: true,
      isScrollControlled: true,
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child: Text(
                    'Pagar con:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonPayPal(
                  precio: 199,
                  producto: 'MACRO LIFE',
                  onSuccess: (e) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 104, 116, 244), // Color de fondo de Stripe
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    final prueba = StripeController();

                    prueba.makePay();
                    // get the pay instince
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://cdn.iconscout.com/icon/free/png-256/free-stripe-logo-icon-download-in-svg-png-gif-file-formats--flat-social-media-branding-pack-logos-icons-498440.png?f=webp',
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Stripe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1D1D1F), // Fondo negro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    final pay = Pay({
                      PayProvider.apple_pay:
                          PaymentConfiguration.fromJsonString(defaultApplePay)
                    });

                    // show it to the user, and get the payload
                    final payload =
                        await pay.showPaymentSelector(PayProvider.apple_pay, [
                      PaymentItem(
                          type: PaymentItemType.total,
                          status: PaymentItemStatus.final_price,
                          amount: '199',
                          label: 'MACRO LIFE')
                    ]);

                    // use the payload to get the stripe token
                    final stripeToken =
                        await Stripe.instance.createApplePayToken(payload);

                    // send the stripe token id to the server side
                    final tokenId = stripeToken.id;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apple, // Icono de pago
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Apple Pay',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
