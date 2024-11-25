import 'package:fep/screen/clientes/clientes_binding.dart';
import 'package:fep/screen/clientes/editar/clientes_editar_screen.dart';
import 'package:fep/screen/clientes/lista/clientes_llsta_screen.dart';
import 'package:fep/screen/clientes/nuevo/clientes_nuevo_screen.dart';
import 'package:fep/screen/configuraciones/configuraciones_binding.dart';
import 'package:fep/screen/configuraciones/configuraciones_screen.dart';
import 'package:fep/screen/etiquetas_personalizadas/editar/etiquetas_personalizadas_editar_screen.dart';
import 'package:fep/screen/etiquetas_personalizadas/etiquetas_personalizadas_binding.dart';
import 'package:fep/screen/etiquetas_personalizadas/lista/etiquetas_personalizadas_llsta_screen.dart';
import 'package:fep/screen/etiquetas_personalizadas/nuevo/etiquetas_personalizadas_nuevo_screen.dart';
import 'package:fep/screen/impuestos/editar/impuestos_editar_screen.dart';
import 'package:fep/screen/impuestos/impuestos_binding.dart';
import 'package:fep/screen/impuestos/nuevo/impuestos_nuevo_screen.dart';
import 'package:fep/screen/impuestos/lista/impuestos_lista_screen.dart';
import 'package:fep/screen/objetivos/binding.dart';
import 'package:fep/screen/objetivos/screen.dart';
import 'package:fep/screen/preferencias/preferencias_binding.dart';
import 'package:fep/screen/preferencias/preferencias_screen.dart';
import 'package:fep/screen/productos/lista/productoss_llsta_screen.dart';
import 'package:fep/screen/productos/nuevo/productos_nuevo_screen.dart';
import 'package:fep/screen/productos/productos_binding.dart';
import 'package:fep/screen/registro/registro_binding.dart';
import 'package:fep/screen/registro/registro_screen.dart';
import 'package:fep/screen/registro_pasos/binding.dart';
import 'package:fep/screen/registro_pasos/screen.dart';
import 'package:fep/screen/series/editar/series_editar_screen.dart';
import 'package:fep/screen/series/lista/series_llsta_screen.dart';
import 'package:fep/screen/series/nuevo/series_nuevo_screen.dart';
import 'package:fep/screen/series/series_binding.dart';
import 'package:fep/screen/unidades_medidas/editar/unidades_medidas_editar_screen.dart';
import 'package:fep/screen/unidades_medidas/lista/unidades_medidas_llsta_screen.dart';
import 'package:fep/screen/unidades_medidas/nuevo/unidades_medidas_nuevo_screen.dart';
import 'package:fep/screen/unidades_medidas/unidades_medidas_binding.dart';
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
    // GetPage(
    //   name: Routes.configuraciones,
    //   page: () => const ConfiguracionesScreen(),
    //   binding: ConfiguracionesBinding(),
    // ),
    GetPage(
      name: Routes.objetivos,
      page: () => const ObjetivosScreen(),
      binding: ObjetivosBinding(),
    ),
    GetPage(
      name: Routes.preferencias,
      page: () => const PreferenciasScreen(),
      binding: PreferenciasBinding(),
    ),
    GetPage(
      name: Routes.impuestos,
      page: () => const ImpuestosListaScreen(),
      binding: ImpuestoListaBinding(),
    ),
    GetPage(
      name: Routes.impuestos_nuevo,
      page: () => const ImpuestosNuevoScreen(),
      binding: ImpuestoNuevoBinding(),
    ),
    GetPage(
      name: Routes.impuestos_editar,
      page: () => const ImpuestosEditarScreen(),
      binding: ImpuestosEditarBinding(),
    ),
    GetPage(
      name: Routes.series,
      page: () => const SeriesListaScreen(),
      binding: SeriesEditarBinding(),
    ),
    GetPage(
      name: Routes.series_nuevo,
      page: () => const SeriesNuevoScreen(),
      binding: SeriesNuevoBinding(),
    ),
    GetPage(
      name: Routes.series_editar,
      page: () => const SeriesEditarScreen(),
      binding: SeriesEditarBinding(),
    ),
    GetPage(
      name: Routes.unidades_medidas,
      page: () => const UnidadesMedidasListaScreen(),
      binding: UnidadesMedidasListaBinding(),
    ),
    GetPage(
      name: Routes.unidades_medidas_nuevo,
      page: () => const UnidadesMedidasNuevoScreen(),
      binding: UnidadesMedidasNuevoBinding(),
    ),
    GetPage(
      name: Routes.unidades_medidas_editar,
      page: () => const UnidadesMedidasEditarScreen(),
      binding: UnidadesMedidasEditarBinding(),
    ),
    GetPage(
      name: Routes.etiquetas_personalizadas,
      page: () => const EtiquetasPersonalizadasListaScreen(),
      binding: EtiquetasPersonalizadasListaBinding(),
    ),
    GetPage(
      name: Routes.etiquetas_personalizadas_nuevo,
      page: () => const EtiquetasPersonalizadasNuevoScreen(),
      binding: EtiquetasPersonalizadasNuevoBinding(),
    ),
    GetPage(
      name: Routes.etiquetas_personalizadas_editar,
      page: () => const EtiquetasPersonalizadasEditarScreen(),
      binding: EtiquetasPersonalizadasEditarBinding(),
    ),
    GetPage(
      name: Routes.clientes,
      page: () => const ClientesListaScreen(),
      binding: ClientesListaBinding(),
    ),
    GetPage(
      name: Routes.clientes_nuevo,
      page: () => const ClientesNuevoScreen(),
      binding: ClientesNuevoBinding(),
    ),
    GetPage(
      name: Routes.clientes_editar,
      page: () => const ClientesEditarScreen(),
      binding: ClientesEditarBinding(),
    ),
    GetPage(
      name: Routes.productos,
      page: () => const ProductosListaScreen(),
      binding: ProductosListaBinding(),
    ),
    GetPage(
      name: Routes.productos_nuevo,
      page: () => const ProductosNuevoScreen(),
      binding: ProductosNuevoBinding(),
    ),
  ];
}
