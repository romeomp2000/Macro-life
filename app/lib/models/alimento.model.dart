import 'package:fep/models/Puntuacion.model.dart';
import 'package:fep/models/ingrediente.model.dart';

class AlimentoModel {
  final String id;
  final String imageUrl;
  final String name;
  final String time;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final bool favorito;
  final double porcion;
  final PuntuacionSalud puntuacionSalud;
  final List<IngredienteModel> ingredientes;

  // Constructor
  AlimentoModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.favorito,
    required this.porcion,
    required this.ingredientes,
    required this.puntuacionSalud,
  });

// Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': imageUrl,
      'imageUrl': imageUrl,
      'name': name,
      'time': time,
      'calorias': calories,
      'proteina': protein,
      'carbohidratos': carbs,
      'grasas': fats,
      'favorito': favorito,
      'porcion': porcion,
      'puntuacionSalud': puntuacionSalud.toJson(),
      'ingredientes':
          ingredientes.map((ingrediente) => ingrediente.toJson()).toList(),
    };
  }

// Método para crear el objeto a partir de JSON
  factory AlimentoModel.fromJson(Map<String, dynamic> json) {
    double porcion = (json['porcion'] is int)
        ? (json['porcion'] as int).toDouble()
        : (json['porcion'] as double);

    return AlimentoModel(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
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
