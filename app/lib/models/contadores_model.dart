import 'package:fep/config/theme.dart';
import 'package:flutter/material.dart';

class ContadoresModel {
  int? timbresdisponibles;
  String? avisovencimiento;
  String? fechaexpiracion;
  String? fechaexpiran;
  String? mensajesellos;
  String? fechaactivacion;
  String? fechaperiodo;
  String? fechaPeriodo;
  String? fechaActivacionTxt;
  int? numeroTimbres;
  String? avisovencimientoColor;
  String? fechaexpiracionColor;
  String? timbresDisponiblesColor;
  String? mensajeSellosColor;
  Color? avisoVencimientoColor_;
  Color? fechaExpiracionColor_;
  Color? timbresDisponiblesColor_;
  Color? mensajeSellosColor_;

  ContadoresModel({
    this.timbresdisponibles,
    this.avisovencimiento,
    this.fechaexpiracion,
    this.fechaexpiran,
    this.mensajesellos,
    this.fechaactivacion,
    this.fechaperiodo,
    this.numeroTimbres,
    this.avisovencimientoColor,
    this.fechaexpiracionColor,
    this.timbresDisponiblesColor,
    this.avisoVencimientoColor_,
    this.fechaExpiracionColor_,
    this.timbresDisponiblesColor_,
    this.mensajeSellosColor,
    this.mensajeSellosColor_,
    this.fechaPeriodo,
    this.fechaActivacionTxt,
  });

  ContadoresModel.fromJson(Map<String, dynamic> json) {
    timbresdisponibles = json['timbres_disponibles'];
    avisovencimiento = json['aviso_vencimiento'];
    fechaexpiracion = json['fecha_expiracion'];
    fechaexpiran = json['fecha_expiran'];
    mensajesellos = json['mensaje_sellos'];
    fechaactivacion = json['fecha_activacion'];
    fechaperiodo = json['fecha_periodo'];
    numeroTimbres = json['numero_timbres'];
    avisovencimientoColor = json['aviso_vencimiento_color'];
    fechaexpiracionColor = json['fecha_expiracion_color'];
    timbresDisponiblesColor = json['timbres_disponibles_color'];
    mensajeSellosColor = json['mensaje_sellos_color'];
    fechaPeriodo = json['fecha_periodo'];
    fechaActivacionTxt = json['fecha_activacion'];

    if (avisovencimientoColor == 'warning') {
      avisoVencimientoColor_ = Colors.orange;
    } else if (avisovencimientoColor == 'danger') {
      avisoVencimientoColor_ = Colors.redAccent;
    } else {
      avisoVencimientoColor_ = greenTheme1_;
    }

    if (fechaexpiracionColor == 'warning') {
      fechaExpiracionColor_ = Colors.orange;
    } else if (fechaexpiracionColor == 'danger') {
      fechaExpiracionColor_ = Colors.redAccent;
    } else {
      fechaExpiracionColor_ = greenTheme1_;
    }

    if (mensajeSellosColor == 'warning') {
      mensajeSellosColor_ = Colors.orange;
    } else if (mensajeSellosColor == 'danger') {
      mensajeSellosColor_ = Colors.redAccent;
    } else {
      mensajeSellosColor_ = greenTheme1_;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timbres_disponibles'] = timbresdisponibles;
    data['aviso_vencimiento'] = avisovencimiento;
    data['fecha_expiracion'] = fechaexpiracion;
    data['fecha_expiran'] = fechaexpiran;
    data['mensaje_sellos'] = mensajesellos;
    data['fecha_activacion'] = fechaactivacion;
    data['fecha_periodo'] = fechaperiodo;
    data['numero_timbres'] = numeroTimbres;
    data['aviso_vencimiento_color'] = avisovencimientoColor;
    data['fecha_expiracion_color'] = fechaexpiracionColor;
    data['timbres_disponibles_color'] = timbresDisponiblesColor;
    data['mensaje_sellos_color'] = mensajeSellosColor;
    data['mensaje_sellos_color_'] = mensajeSellosColor_;
    data['aviso_vencimiento_color_'] = avisoVencimientoColor_;
    data['fecha_expiracion_color_'] = fechaExpiracionColor_;
    data['timbres_disponibles_color_'] = timbresDisponiblesColor_;
    data['fecha_periodo'] = fechaPeriodo;
    data['fecha_activacion'] = fechaActivacionTxt;

    return data;
  }
}
