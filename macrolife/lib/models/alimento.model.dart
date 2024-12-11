import 'package:macrolife/models/Puntuacion.model.dart';
import 'package:macrolife/models/ingrediente.model.dart';

class AlimentoModel {
  String? id;
  String? imageUrl;
  String? name;
  String? time;
  int? calories;
  int? protein;
  int? carbs;
  int? fats;
  bool? favorito;
  double? porcion;
  PuntuacionSalud? puntuacionSalud;
  List<IngredienteModel>? ingredientes;

  // Constructor
  AlimentoModel({
    this.id,
    this.imageUrl,
    this.name,
    this.time,
    this.calories,
    this.protein,
    this.carbs,
    this.fats,
    this.favorito,
    this.porcion,
    this.ingredientes,
    this.puntuacionSalud,
  });

// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': imageUrl,
      'imageUrl': imageUrl,
      'nombre': name,
      'time': time,
      'calorias': calories,
      'proteina': protein,
      'carbohidratos': carbs,
      'grasas': fats,
      'favorito': favorito,
      'porciones': porcion,
      'puntuacionSalud': puntuacionSalud?.toJson(),
      'ingredientes':
          ingredientes?.map((ingrediente) => ingrediente.toJson()).toList(),
    };
  }

// Método para crear el objeto a partir de JSON
  factory AlimentoModel.fromJson(Map<String, dynamic> json) {
    double porcion = (json['porciones'] is int)
        ? (json['porciones'] as int).toDouble()
        : (json['porciones'] as double);

    return AlimentoModel(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      name: json['nombre'],
      time: json['time'],
      calories: json['calorias'],
      protein: json['proteina'],
      carbs: json['carbohidratos'],
      fats: json['grasas'],
      favorito: json['favorito'],
      porcion: porcion,
      puntuacionSalud: PuntuacionSalud.fromJson(
          json['puntuacionSalud']), // Conversión desde JSON

      ingredientes: (json['ingredientes'] as List<dynamic>)
          .map((ingredienteJson) => IngredienteModel.fromJson(ingredienteJson))
          .toList(),
    );
  }

  // Método para convertir una lista de objetos a JSON
  static List<Map<String, dynamic>> listToJson(
      List<AlimentoModel> AlimentoModels) {
    return AlimentoModels.map((AlimentoModel) => AlimentoModel.toJson())
        .toList();
  }

  // Método para crear una lista de objetos a partir de JSON
  static List<AlimentoModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => AlimentoModel.fromJson(json)).toList();
  }
}
