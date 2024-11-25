// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class Routes {
  static const initial = '/initial';

  static const login = '/login';
  static const layout = '/layout';
  static const objetivos = '/objetivos';


  

  static const recovery_password = '/recovery_password';

  static const layout_home = '/layout_home';

  static const registro = '/registro';
  static const registro_pasos = '/registro/pasos';


  static const configuraciones = '/configuraciones';

  static const preferencias = '/preferencias';

  static const impuestos = '/impuestos';
  static const impuestos_nuevo = '/impuestos/nuevo';
  static const impuestos_editar = '/impuestos/editar';

  static const series = '/series';
  static const series_nuevo = '/series/nuevo';
  static const series_editar = '/series/editar';

  static const unidades_medidas = '/unidades_medida';
  static const unidades_medidas_nuevo = '/unidades_medida/nuevo';
  static const unidades_medidas_editar = '/unidades_medida/editar';

  static const etiquetas_personalizadas = '/etiquetas_personalizadas';
  static const etiquetas_personalizadas_nuevo =
      '/etiquetas_personalizadas/nuevo';
  static const etiquetas_personalizadas_editar =
      '/etiquetas_personalizadas/editar';

  static const clientes = '/clientes';
  static const clientes_nuevo = '/clientes/nuevo';
  static const clientes_editar = '/clientes/editar';

  static const productos = '/productos';
  static const productos_nuevo = '/productos/nuevo';

  // static const productos_editar = '/productos/editar';
}
