class IngredienteModel {
  final String? id;
  final String? nombre;
  final double? calorias;
  final double? proteina;
  final double? carbohidratos;
  final double? grasas;
  final bool? eliminado;

  // Constructor
  IngredienteModel({
    this.nombre,
    this.calorias,
    this.proteina,
    this.carbohidratos,
    this.grasas,
    this.id,
    this.eliminado,
  });

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'calorias': calorias,
      'proteina': proteina,
      'carbohidratos': carbohidratos,
      'grasas': grasas,
      '_id': id,
      'eliminado': eliminado,
    };
  }

  // Método para crear el objeto a partir de JSON
  factory IngredienteModel.fromJson(Map<String, dynamic> json) {
    return IngredienteModel(
      nombre: json['nombre'],
      calorias: _toDouble(json['calorias']),
      proteina: _toDouble(json['proteina']),
      carbohidratos: _toDouble(json['carbohidratos']),
      grasas: _toDouble(json['grasas']),
      id: json['_id'],
      eliminado: json['eliminado'],
    );
  }

  // Método para convertir valores a double, incluso si vienen como int
  static double? _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    }
    return null;
  }

  // Método para convertir una lista de objetos a JSON
  static List<Map<String, dynamic>> listToJson(
      List<IngredienteModel> IngredienteModels) {
    return IngredienteModels.map(
        (IngredienteModel) => IngredienteModel.toJson()).toList();
  }

  // Método para crear una lista de objetos a partir de JSON
  static List<IngredienteModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => IngredienteModel.fromJson(json)).toList();
  }
}
