// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:macrolife/config/theme.dart';
import 'package:macrolife/helpers/configuraciones.dart';
import 'package:macrolife/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:macrolife/services/notification_service.dart';
import 'package:macrolife/widgets_home_screen/controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  // NotificationService().initNotification();

  HomeWidget.setAppGroupId('group.mx.posibilidades.macrolife');

  final configuracionesController = Get.put(ConfiguracionesController());
  Get.put(WidgetController());

  // WorkMan
  // await configuracionesController.buscaConfiguraciones();
  Stripe.merchantIdentifier = 'merchant.mx.posibilidades.macrolife';

  Stripe.publishableKey =
      configuracionesController.configuraciones.value.stripe?.publicKey ?? '';

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initial,
        theme: themeData,
        getPages: AppPages.pages,
        locale: const Locale('es', 'MX'),
        supportedLocales: const [Locale('es', 'MX')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
      ),
    );
  });
}
