class AnaliticaNutricionModel {
  int? promedioGeneral;
  int? caloriasTotales; // Nueva propiedad para las calorías totales
  List<Dias>? dias;

  AnaliticaNutricionModel(
      {this.promedioGeneral, this.caloriasTotales, this.dias});

  AnaliticaNutricionModel.fromJson(Map<String, dynamic> json) {
    promedioGeneral = json['promedioGeneral'];
    caloriasTotales = json['caloriasTotales']; // Asignar las calorías totales
    if (json['dias'] != null) {
      dias = <Dias>[];
      json['dias'].forEach((v) {
        dias!.add(Dias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promedioGeneral'] = this.promedioGeneral;
    data['caloriasTotales'] = this.caloriasTotales; // Incluir calorías totales
    if (this.dias != null) {
      data['dias'] = this.dias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dias {
  String? dia;
  int? promedio;

  Dias({this.dia, this.promedio});

  Dias.fromJson(Map<String, dynamic> json) {
    dia = json['dia'];
    promedio = json['promedio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dia'] = this.dia;
    data['promedio'] = this.promedio;
    return data;
  }
}
