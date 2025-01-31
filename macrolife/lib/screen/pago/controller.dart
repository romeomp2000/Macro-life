import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
// import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:macrolife/config/api_service.dart';
import 'package:macrolife/helpers/AplePay.dart';
import 'package:macrolife/helpers/StripePaymentHandle.dart';
import 'package:macrolife/helpers/configuraciones.dart';
// import 'package:macrolife/helpers/productos_apple.dart';
import 'package:macrolife/helpers/usuario_controller.dart';
import 'package:macrolife/screen/pago/consumable.dart';
import 'package:macrolife/screen/pago/prueba.dart';
import 'package:macrolife/widgets/custom_elevated_button.dart';
// import 'package:macrolife/widgets/button_paypal.dart';
// import 'package:macrolife/widgets/layout.dart';
import 'package:pay/pay.dart';
import 'package:video_player/video_player.dart';

class PagoController extends GetxController {
  final ConfiguracionesController configuraciones =
      Get.put(ConfiguracionesController());

  RxInt paso = 1.obs;
  final sucripcion = 'Anual'.obs;
  final RxDouble totalAPagar = 0.0.obs;

  VideoPlayerController controllerVideo = VideoPlayerController.asset(
      'assets/videos/Mockup_Video_Final_V7-3_MACROLIFE_29012025.mp4')
    ..initialize().then((_) {
      // controllerVideo.
    })
    ..setLooping(true)
    ..play();

  RxDouble anualPrice = 0.0.obs;
  @override
  void onInit() {
    anualPrice.value =
        configuraciones.configuraciones.value.suscripcion?.anual ?? 0.0;
    totalAPagar.value = anualPrice.value;
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

  void pagar() async {
    if (sucripcion.value == 'Anual') {
      await pruebaGratis();
      // await getProducts();
      return;
    }
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
                // const SizedBox(height: 20),
                // ButtonPayPal(
                //   precio: totalAPagar.value,
                //   producto: 'MACRO LIFE',
                //   onSuccess: (e) {
                //     suscribirseUsuario(
                //       total: totalAPagar.value,
                //       producto: sucripcion.value,
                //       identificador: 'paypal',
                //       metodoPago: 'PayPal',
                //     );
                //   },
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    onPressed: () async {
                      final prueba = StripeController();

                      prueba.makePay(
                        total: totalAPagar.value,
                        producto: sucripcion.value,
                      );
                      // get the pay instince
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width,
                      child: Text(
                        'Pagar con tarjeta',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    // Image.asset(
                    //   'assets/icons/logo_stripe_800x241_original.png',
                    //   height: 20,
                    //   width: Get.width,
                    // ),
                    ),
                const SizedBox(height: 20),
                if (GetPlatform.isIOS)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                          amount: totalAPagar.value.toString(),
                          label: 'MACRO LIFE',
                        )
                      ]);

                      // use the payload to get the stripe token
                      final stripeToken =
                          await Stripe.instance.createApplePayToken(payload);

                      // send the stripe token id to the server side
                      final tokenId = stripeToken.id;

                      suscribirseUsuario(
                        total: totalAPagar.value,
                        producto: sucripcion.value,
                        identificador: tokenId,
                        metodoPago: 'Apple Pay',
                      );
                      // print('object');
                      // final bool available =
                      //     await InAppPurchase.instance.isAvailable();
                      // if (available) {
                      //   await getProducts();
                      // }
                    },
                    child: Image.asset(
                      'assets/icons/logo_apple_pay_800x135_original.png',
                      height: 20,
                      width: Get.width,
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

  InAppPurchase iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  List<String> notFoundIds = [];
  List<ProductDetails> products = [];
  List<PurchaseDetails> purchases = [];
  List<String> consumablesP = [];
  bool purchasePending = false;
  bool loading = true;
  bool isAvailable = true;
  String? queryProductError;
  Set<String> idS = <String>{'MLPA2025'};

  Future<void> getProducts() async {
    try {
      Get.to(() => PruebaView());
      // final bool available = await iap.isAvailable();

      // if (!available) {
      //   return;
      // }

      // final Stream<List<PurchaseDetails>> purchaseUpdated = iap.purchaseStream;
      // subscription = purchaseUpdated.listen((purchaseDetailsList) {
      //   listenToPurchaseUpdated(purchaseDetailsList);
      // }, onDone: () {
      //   subscription.cancel();
      // }, onError: (error) {
      //   subscription.resume();
      // });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  void showPendingUI() {
    purchasePending = true;
  }

  void handleError(IAPError error) {
    purchasePending = false;
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if ((purchaseDetails.productID == 'MLPA2025')) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      List<String> consumables = await ConsumableStore.load();

      purchasePending = false;
      consumables = consumables;
    } else {
      purchases.add(purchaseDetails);
      purchasePending = false;
    }
  }

  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await iap.completePurchase(purchaseDetails);
        }
      }
    });
  }

  // Future<void> initStoreInfo() async {
  //   final bool isAvailables = await iap.isAvailable();
  //   if (!isAvailables) {
  //     isAvailable = isAvailables;
  //     products = [];
  //     purchases = [];
  //     notFoundIds = [];
  //     consumables = [];
  //     purchasePending = false;
  //     loading = false;

  //     return;
  //   }

  //   if (GetPlatform.isIOS) {
  //     var iosPlatformAddition =
  //         iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
  //     await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
  //   }

  //   ProductDetailsResponse productDetailResponse =
  //       await iap.queryProductDetails(idS.toSet());
  //   if (productDetailResponse.error != null) {
  //     queryProductError = productDetailResponse.error!.message;
  //     isAvailable = isAvailable;
  //     products = productDetailResponse.productDetails;
  //     purchases = [];
  //     notFoundIds = productDetailResponse.notFoundIDs;
  //     consumablesP = [];
  //     purchasePending = false;
  //     loading = false;

  //     return;
  //   }

  //   if (productDetailResponse.productDetails.isEmpty) {
  //     queryProductError = null;
  //     isAvailable = isAvailable;
  //     products = productDetailResponse.productDetails;
  //     purchases = [];
  //     notFoundIds = productDetailResponse.notFoundIDs;
  //     consumablesP = [];
  //     purchasePending = false;
  //     loading = false;

  //     return;
  //   }

  //   List<String> consumables = await ConsumableStore.load();

  //   isAvailable = isAvailable;
  //   products = productDetailResponse.productDetails;
  //   notFoundIds = productDetailResponse.notFoundIDs;
  //   consumablesP = consumables;
  //   purchasePending = false;
  //   loading = false;
  // }

  final UsuarioController usuarioController = Get.find();
  // final EscanearAlimentosController escanearAlimentoController =
  //     Get.put(EscanearAlimentosController());

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
