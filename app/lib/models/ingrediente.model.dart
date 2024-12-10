class IngredienteModel {
  final String nombre;
  final int calorias;
  final int proteina;
  final int carbohidratos;
  final int grasas;

  // Constructor
  IngredienteModel({
    required this.nombre,
    required this.calorias,
    required this.proteina,
    required this.carbohidratos,
    required this.grasas,
  });

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'calorias': calorias,
      'proteina': proteina,
      'carbohidratos': carbohidratos,
      'grasas': grasas,
    };
  }

  // Método para crear el objeto a partir de JSON
  factory IngredienteModel.fromJson(Map<String, dynamic> json) {
    return IngredienteModel(
      nombre: json['nombre'],
      calorias: json['calorias'],
      proteina: json['proteina'],
      carbohidratos: json['carbohidratos'],
      grasas: json['grasas'],
    );
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
