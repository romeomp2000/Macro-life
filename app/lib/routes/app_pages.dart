import 'package:fep/screen/loader/binding.dart';
import 'package:fep/screen/loader/screen.dart';
import 'package:fep/screen/objetivos/binding.dart';
import 'package:fep/screen/objetivos/screen.dart';
import 'package:fep/screen/registro/registro_binding.dart';
import 'package:fep/screen/registro/registro_screen.dart';
import 'package:fep/screen/registro_pasos/binding.dart';
import 'package:fep/screen/registro_pasos/screen.dart';
import 'package:fep/widgets/layout.dart';
import 'package:get/get.dart';
import 'package:fep/screen/layout_home/layout_home_binding.dart';
import 'package:fep/screen/layout_home/layout_home_screen.dart';
import 'package:fep/screen/login/login_binding.dart';
import 'package:fep/screen/login/login_screen.dart';
import 'package:fep/screen/principal/principal_binding.dart';
import 'package:fep/screen/principal/principal_screen.dart';
import 'package:fep/screen/recover_password/recovery_password_binding.dart';
import 'package:fep/screen/recover_password/recovery_password_screen.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const PrincipalScreen(),
      binding: PrincipalBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.registro_pasos,
      page: () => const RegistroPasosScreen(),
      binding: RegistroPasosBinding(),
    ),
    // GetPage(
    //   name: Routes.nutricion,
    //   page: () => const NutricionScreen(),
    //   binding: NutricionBinding(),
    // ),
    GetPage(
      name: Routes.layout_home,
      page: () => const LayoutHomeScreen(),
      binding: LayoutHomeBinding(),
    ),
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
   
  ];
}
