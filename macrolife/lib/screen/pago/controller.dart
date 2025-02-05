import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/configuraciones.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/pago/billingService.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
import 'package:video_player/video_player.dart';

class PagoController extends GetxController {
  final ConfiguracionesController configuraciones =
      Get.put(ConfiguracionesController());

  final InAppPurchaseUtils inAppPurchaseUtils =
      InAppPurchaseUtils.inAppPurchaseUtilsInstance;

  RxInt paso = 1.obs;
  final sucripcion = 'Plan anual'.obs;
  final RxDouble totalAPagar = 0.0.obs;

  VideoPlayerController controllerVideo = VideoPlayerController.asset(
      'assets/videos/Mockup_Video_Final_V7-3_MACROLIFE_01022025.mp4')
    ..initialize().then((_) {
      // controllerVideo.
    })
    ..setLooping(true)
    ..play();

  RxDouble anualPrice = 0.0.obs;
  RxList<SubscriptionData> products = <SubscriptionData>[].obs;
  InAppPurchase iap = InAppPurchase.instance;
  ProductDetails? productDetails;

  @override
  void onInit() async {
    //Obtener Planes desde las tiendas oficiales
    Get.put<InAppPurchaseUtils>(inAppPurchaseUtils);
    Set<String> idS = <String>{};
    if (GetPlatform.isIOS) {
      idS = {'MLPA2025_2', 'MLPM2025'};
    }
    if (GetPlatform.isAndroid) {
      idS = {'MLPA2025_2', 'MLPM2025'};
    }
    products.value = await inAppPurchaseUtils.getProducts(idS);
    cargarInformation();

    super.onInit();
  }

  void disminuir() {
    if (paso.value == 1) {
      return;
    }
    paso.value--;
  }

  void incrementar() {
    if (paso.value == 3) {
      return;
    }
    paso.value++;
  }

  Future pruebaGratis() async {
    try {
      final controllerButton = Get.put(LoadingController());
      controllerButton.startLoading();
      Map<String, dynamic> body = {
        "idUsuario": usuarioController.usuario.value.sId,
        "producto": "Anual",
        "total": 0.0
      };

      final ApiService apiService = ApiService();
      await apiService.fetchData(
        'suscripcion/prueba-gratis',
        method: Method.POST,
        body: body,
      );
      controllerButton.stopLoading();
      Get.offNamed('/pago-exitoso');

      usuarioController.usuario.value.vencidoSup = true;
      usuarioController.usuario.refresh();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  RxBool isLoading = false.obs;
  Future pagar() async {
    final loadingController = Get.put(LoadingController());
    loadingController.startLoading();
    // isLoading.value = true;
    if (productDetails != null) {
      await inAppPurchaseUtils.buyNonConsumableProduct(productDetails!);
    }

    loadingController.stopLoading();
    isLoading.value = false;
  }

  void cargarInformation() {
    if (products.isNotEmpty) {
      SubscriptionData producto = products.firstWhere(
        (e) => e.nombre == 'Plan anual',
      );
      anualPrice.value = producto.data.rawPrice;
      productDetails = producto.data;
    }
  }

  final UsuarioController usuarioController = Get.find();

  void suscribirseUsuario({
    required double total,
    required String producto,
    required String identificador,
    required String metodoPago,
  }) async {
    try {
      final apiService = ApiService();
      await apiService.fetchData(
        'suscripcion/usuario',
        method: Method.POST,
        body: {
          "idUsuario": usuarioController.usuario.value.sId,
          "producto": producto,
          'total': total,
          'identificador': identificador,
          'metodoPago': metodoPago,
        },
      );

      // print('object');
      Get.offNamed('/layout');
      Get.back();
      Get.back();
      // // escanearAlimentoController.

      // escanearAlimentoController.ayudaEscanear();
      usuarioController.usuario.value.vencidoSup = true;
      usuarioController.usuario.refresh();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

class SubscriptionData {
  final String nombre;
  final ProductDetails data;

  SubscriptionData({required this.nombre, required this.data});
}



//                   prueba.makePay(
    //                     total: totalAPagar.value,
    //                     producto: sucripcion.value,
    //                   );
    //                   // get the pay instince
    //                 },
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   width: Get.width,
    //                   child: Text(
    //                     'Pagar con tarjeta',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 )
    //                 // Image.asset(
    //                 //   'assets/icons/logo_stripe_800x241_original.png',
    //                 //   height: 20,
    //                 //   width: Get.width,
    //                 // ),
    //                 ),
    //             const SizedBox(height: 20),
    //             if (GetPlatform.isIOS)
    //               ElevatedButton(
    //                 style: ElevatedButton.styleFrom(
    //                   backgroundColor: Colors.black,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   padding:
    //                       EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    //                   elevation: 5,
    //                 ),
    //                 onPressed: () async {
    //                   final pay = Pay({
    //                     PayProvider.apple_pay:
    //                         PaymentConfiguration.fromJsonString(defaultApplePay)
    //                   });

    //                   // show it to the user, and get the payload
    //                   final payload =
    //                       await pay.showPaymentSelector(PayProvider.apple_pay, [
    //                     PaymentItem(
    //                       type: PaymentItemType.total,
    //                       status: PaymentItemStatus.final_price,
    //                       amount: totalAPagar.value.toString(),
    //                       label: 'MACRO LIFE',
    //                     )
    //                   ]);

    //                   // use the payload to get the stripe token
    //                   final stripeToken =
    //                       await Stripe.instance.createApplePayToken(payload);

    //                   // send the stripe token id to the server side
    //                   final tokenId = stripeToken.id;

    //                   suscribirseUsuario(
    //                     total: totalAPagar.value,
    //                     producto: sucripcion.value,
    //                     identificador: tokenId,
    //                     metodoPago: 'Apple Pay',
    //                   );
    //                   // print('object');
    //                   // final bool available =
    //                   //     await InAppPurchase.instance.isAvailable();
    //                   // if (available) {
    //                   //   await getProducts();
    //                   // }
    //                 },
    //                 child: Image.asset(
    //                   'assets/icons/logo_apple_pay_800x135_original.png',
    //                   height: 20,
    //                   width: Get.width,
    //                 ),
    //               ),
    //             const SizedBox(height: 10),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );