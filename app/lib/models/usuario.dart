import 'package:get/get.dart';

class Usuario {
  Rx<Macronutrientes>? macronutrientes;
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
  String? lograr;
  double? metaAlcanzar;
  String? impideAlcanzar;
  String? codigo;
  String? fechaNacimientoFormato;
  int? edad;
  String? fechaMeta;
  String? fechaMetaObjetivo;

  Usuario({
    this.macronutrientes,
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
    this.lograr,
    this.metaAlcanzar,
    this.impideAlcanzar,
    this.codigo,
    this.fechaNacimientoFormato,
    this.edad,
    this.fechaMeta,
    this.fechaMetaObjetivo,
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    macronutrientes = json['macronutrientes'] != null
        ? Rx<Macronutrientes>(Macronutrientes.fromJson(json['macronutrientes']))
        : null;
    macronutrientesDiario = json['macronutrientesDiario'] != null
        ? Rx<Macronutrientes>(
            Macronutrientes.fromJson(json['macronutrientesDiario']))
        : null;
    sId = json['_id'];
    referenciaUsuario = json['referenciaUsuario'];
    fechaVencimiento = json['fechaVencimiento'];
    balance = json['balance'];
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
    lograr = json['lograr'];
    metaAlcanzar = json['metaAlcanzar'];
    impideAlcanzar = json['impideAlcanzar'];
    codigo = json['codigo'];
    fechaNacimientoFormato = json['fechaNacimientoFormato'];
    edad = json['edad'];
    fechaMeta = json['fechaMeta'];
    fechaMetaObjetivo = json['fechaMetaObjetivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.macronutrientes != null) {
      data['macronutrientes'] = this.macronutrientes!.value.toJson();
    }
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
    data['lograr'] = this.lograr;
    data['metaAlcanzar'] = this.metaAlcanzar;
    data['impideAlcanzar'] = this.impideAlcanzar;
    data['codigo'] = this.codigo;
    data['fechaNacimientoFormato'] = this.fechaNacimientoFormato;
    data['edad'] = this.edad;
    data['fechaMeta'] = this.fechaMeta;
    data['fechaMetaObjetivo'] = this.fechaMetaObjetivo;
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
