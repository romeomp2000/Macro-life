import 'package:get/get.dart';

class Usuario {
  // Rx<MacronutrientesCalculo>? macronutrientes;
  Rx<Macronutrientes>? macronutrientesDiario;
  String? sId;
  String? referenciaUsuario;
  String? fechaVencimiento;
  int? balance;
  int? rachaDias;
  String? fechaNacimiento;
  int? altura;
  int? pesoActual;
  String? genero;
  int? puntuacionSalud;
  String? entrenamientoSemanal;
  String? objetivo;
  int? pesoObjetivo;
  String? dieta;
  List<String>? logros;
  double? metaAlcanzar;
  String? impideAlcanzar;
  String? codigo;
  String? fechaNacimientoFormato;
  int? edad;
  String? fechaMeta;
  String? fechaMetaObjetivo;
  bool? vencidoSup;
  String? nombre;
  String? telefono;
  String? correo;

  Usuario(
      {
      // this.macronutrientes,
      this.macronutrientesDiario,
      this.sId,
      this.referenciaUsuario,
      this.fechaVencimiento,
      this.balance,
      this.rachaDias,
      this.fechaNacimiento,
      this.altura,
      this.pesoActual,
      this.genero,
      this.puntuacionSalud,
      this.entrenamientoSemanal,
      this.objetivo,
      this.pesoObjetivo,
      this.dieta,
      this.logros,
      this.metaAlcanzar,
      this.impideAlcanzar,
      this.codigo,
      this.fechaNacimientoFormato,
      this.edad,
      this.fechaMeta,
      this.fechaMetaObjetivo,
      this.vencidoSup,
      this.nombre,
      this.telefono,
      this.correo});

  Usuario.fromJson(Map<String, dynamic> json) {
    // macronutrientes = json['macronutrientes'] != null
    //     ? Rx<MacronutrientesCalculo>(
    //         MacronutrientesCalculo.fromJson(json['macronutrientes']))
    //     : null;
    macronutrientesDiario = json['macronutrientesDiario'] != null
        ? Rx<Macronutrientes>(
            Macronutrientes.fromJson(json['macronutrientesDiario']))
        : null;
    sId = json['_id'];
    referenciaUsuario = json['referenciaUsuario'];
    fechaVencimiento = json['fechaVencimiento'];
    balance = json['balance'];
    vencidoSup = json['vencido'] ?? false;
    rachaDias = json['rachaDias'];
    fechaNacimiento = json['fechaNacimiento'];
    altura = json['altura'];
    pesoActual = json['pesoActual'];
    genero = json['genero'];
    puntuacionSalud = json['puntuacionSalud'];
    entrenamientoSemanal = json['entrenamientoSemanal'];
    objetivo = json['objetivo'];
    pesoObjetivo = json['pesoObjetivo'];
    dieta = json['dieta'];
    logros = json['logros'] != null ? List<String>.from(json['logros']) : null;
    metaAlcanzar = json['metaAlcanzar'];
    impideAlcanzar = json['impideAlcanzar'];
    codigo = json['codigo'];
    fechaNacimientoFormato = json['fechaNacimientoFormato'];
    edad = json['edad'];
    fechaMeta = json['fechaMeta'];
    fechaMetaObjetivo = json['fechaMetaObjetivo'];
    nombre = json['nombre'];
    correo = json['correo'];
    telefono = json['telefono'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.macronutrientes != null) {
    //   data['macronutrientes'] = this.macronutrientes!.value.toJson();
    // }
    if (this.macronutrientesDiario != null) {
      data['macronutrientesDiario'] =
          this.macronutrientesDiario!.value.toJson();
    }
    data['_id'] = this.sId;
    data['referenciaUsuario'] = this.referenciaUsuario;
    data['fechaVencimiento'] = this.fechaVencimiento;
    data['balance'] = this.balance;
    data['rachaDias'] = this.rachaDias;
    data['fechaNacimiento'] = this.fechaNacimiento;
    data['altura'] = this.altura;
    data['pesoActual'] = this.pesoActual;
    data['genero'] = this.genero;
    data['puntuacionSalud'] = this.puntuacionSalud;
    data['entrenamientoSemanal'] = this.entrenamientoSemanal;
    data['objetivo'] = this.objetivo;
    data['pesoObjetivo'] = this.pesoObjetivo;
    data['dieta'] = this.dieta;
    data['logros'] = this.logros;
    data['metaAlcanzar'] = this.metaAlcanzar;
    data['impideAlcanzar'] = this.impideAlcanzar;
    data['codigo'] = this.codigo;
    data['fechaNacimientoFormato'] = this.fechaNacimientoFormato;
    data['edad'] = this.edad;
    data['fechaMeta'] = this.fechaMeta;
    data['fechaMetaObjetivo'] = this.fechaMetaObjetivo;
    data['vencido'] = this.vencidoSup ?? false;
    data['nombre'] = this.nombre;
    data['correo'] = this.correo;
    data['telefono'] = this.telefono;

    return data;
  }
}

class Macronutrientes {
  int? calorias;
  int? proteina;
  int? carbohidratos;
  int? grasas;

  Macronutrientes(
      {this.calorias, this.proteina, this.carbohidratos, this.grasas});

  Macronutrientes.fromJson(Map<String, dynamic> json) {
    calorias = json['calorias'];
    proteina = json['proteina'];
    carbohidratos = json['carbohidratos'];
    grasas = json['grasas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calorias'] = this.calorias;
    data['proteina'] = this.proteina;
    data['carbohidratos'] = this.carbohidratos;
    data['grasas'] = this.grasas;
    return data;
  }
}

class MacronutrientesCalculo {
  int? calorias;
  int? caloriasRestantes;
  int? caloriasQuemadas;

  double? caloriasPorcentaje;

  int? proteina;
  int? proteinaRestantes;
  double? proteinaPorcentaje;

  int? carbohidratos;
  int? carbohidratosRestante;
  double? carbohidratosPorcentaje;

  int? grasas;
  int? grasasRestantes;
  double? grasasPorcentaje;

  MacronutrientesCalculo({
    this.calorias,
    this.proteina,
    this.carbohidratos,
    this.grasas,
    this.caloriasRestantes,
    this.caloriasPorcentaje,
    this.proteinaRestantes,
    this.proteinaPorcentaje,
    this.carbohidratosRestante,
    this.carbohidratosPorcentaje,
    this.grasasRestantes,
    this.grasasPorcentaje,
    this.caloriasQuemadas,
  });

  MacronutrientesCalculo.fromJson(Map<String, dynamic> json) {
    calorias = json['calorias'];
    caloriasRestantes = json['caloriasRestantes'];
    caloriasPorcentaje = json['caloriasPorcentaje'];

    proteina = json['proteina'];
    proteinaRestantes = json['proteinaRestantes'];
    proteinaPorcentaje = json['proteinaPorcentaje'];

    carbohidratos = json['carbohidratos'];
    carbohidratosRestante = json['carbohidratosRestante'];
    carbohidratosPorcentaje = json['carbohidratosPorcentaje'];

    grasas = json['grasas'];
    grasasRestantes = json['grasasRestantes'];
    grasasPorcentaje = json['grasasPorcentaje'];
    caloriasQuemadas = json['caloriasQuemadas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calorias'] = calorias;
    data['caloriasRestantes'] = caloriasRestantes;
    data['caloriasPorcentaje'] = caloriasPorcentaje;

    data['proteina'] = proteina;
    data['proteinaRestantes'] = proteinaRestantes;
    data['proteinaPorcentaje'] = proteinaPorcentaje;

    data['carbohidratos'] = carbohidratos;
    data['carbohidratosRestante'] = carbohidratosRestante;
    data['carbohidratosPorcentaje'] = carbohidratosPorcentaje;

    data['grasas'] = grasas;
    data['grasas'] = grasasRestantes;
    data['grasasPorcentaje'] = grasasPorcentaje;
    data['caloriasQuemadas'] = caloriasQuemadas;

    return data;
  }
}
