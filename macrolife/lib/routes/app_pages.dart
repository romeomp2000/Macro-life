import 'package:macrolife/screen/analitica/info.dart';
import 'package:macrolife/screen/correr/binding.dart';
import 'package:macrolife/screen/correr/screen.dart';
import 'package:macrolife/screen/ejercicio/binding.dart';
import 'package:macrolife/screen/ejercicio/screen.dart';
import 'package:macrolife/screen/ejercicio_describir/binding.dart';
import 'package:macrolife/screen/ejercicio_describir/screen.dart';
import 'package:macrolife/screen/favoritos/binding.dart';
import 'package:macrolife/screen/favoritos/screen.dart';
import 'package:macrolife/screen/food_database/binding.dart';
import 'package:macrolife/screen/food_database/screen.dart';
import 'package:macrolife/screen/loader/binding.dart';
import 'package:macrolife/screen/loader/screen.dart';
import 'package:macrolife/screen/objetivos/binding.dart';
import 'package:macrolife/screen/objetivos/screen.dart';
import 'package:macrolife/screen/pesas/binding.dart';
import 'package:macrolife/screen/pesas/screen.dart';
import 'package:macrolife/screen/registro/registro_binding.dart';
import 'package:macrolife/screen/registro/registro_screen.dart';
import 'package:macrolife/screen/registro_pasos/binding.dart';
import 'package:macrolife/screen/registro_pasos/screen.dart';
import 'package:macrolife/screen/suscripcion/binding.dart';
import 'package:macrolife/screen/suscripcion/screen.dart';
import 'package:macrolife/screen/widgets/widgets_view.dart';
import 'package:macrolife/widgets/layout.dart';
import 'package:get/get.dart';
import 'package:macrolife/screen/principal/principal_binding.dart';
import 'package:macrolife/screen/principal/principal_screen.dart';
import 'package:macrolife/screen/recover_password/recovery_password_binding.dart';
import 'package:macrolife/screen/recover_password/recovery_password_screen.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const PrincipalScreen(),
      binding: PrincipalBinding(),
    ),
    GetPage(
      name: Routes.registro_pasos,
      page: () => const RegistroPasosScreen(),
      binding: RegistroPasosBinding(),
    ),
    GetPage(
      name: Routes.suscripcion,
      page: () => const SuscripcionScreen(),
      binding: SuscripcionBinding(),
    ),
    GetPage(
      name: Routes.food_database,
      page: () => const FoodDatabaseScreen(),
      binding: FoodDatabaseBinding(),
    ),
    GetPage(
      name: Routes.correr,
      page: () => const CorrerScreen(),
      binding: CorrerBinding(),
    ),

    GetPage(
      name: Routes.describir_ejercicio,
      page: () => const EjercicioDescribirScreen(),
      binding: EjercicioDescribirBinding(),
    ),
    GetPage(
      name: Routes.pesas,
      page: () => const PesasScreen(),
      binding: PesasBinding(),
    ),
    GetPage(
      name: Routes.ejercicio,
      page: () => const EjercicioScreen(),
      binding: EjercicioBinding(),
    ),

    GetPage(
      name: Routes.favoritos,
      page: () => const FavoritosScreen(),
      binding: FavoritosBinding(),
    ),
    // GetPage(
    //   name: Routes.nutricion,
    //   page: () => const NutricionScreen(),
    //   binding: NutricionBinding(),
    // ),

    GetPage(
      name: Routes.layout,
      page: () => LayoutScreen(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: Routes.recovery_password,
      page: () => const RecoveryPasswordScreen(),
      binding: RecoveryPasswordBinding(),
    ),
    GetPage(
      name: Routes.registro,
      page: () => const RegistroScreen(),
      binding: RegistroBinding(),
    ),
    GetPage(
      name: Routes.loader,
      page: () => const LoaderScreen(),
      binding: LoaderBinding(),
    ),
    GetPage(
      name: Routes.objetivos,
      page: () => const ObjetivosScreen(),
      binding: ObjetivosBinding(),
    ),
    GetPage(
      name: Routes.info_imc,
      page: () => const InfoIMC(),
    ),
    GetPage(
      name: Routes.prefencias,
      page: () => const WidgetsView(),
    ),
  ];
}
