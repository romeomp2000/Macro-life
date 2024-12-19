class AlimentosPSD {
  String? id;
  String nombre;
  double calorias;
  double proteina;
  double carbohidratos;
  double grasas;
  Map<String, String> propiedades;
  DateTime createdAt;
  DateTime updatedAt;

  AlimentosPSD({
    this.id,
    required this.nombre,
    required this.calorias,
    required this.proteina,
    required this.carbohidratos,
    required this.grasas,
    required this.propiedades,
    required this.createdAt,
    required this.updatedAt,
  });

  // Deserialización desde JSON
  factory AlimentosPSD.fromJson(Map<String, dynamic> json) {
    return AlimentosPSD(
      id: json['_id'],
      nombre: json['nombre'] ?? '',
      calorias: (json['calorias'] as num).toDouble(),
      proteina: (json['proteina'] as num).toDouble(),
      carbohidratos: (json['carbohidratos'] as num).toDouble(),
      grasas: (json['grasas'] as num).toDouble(),
      propiedades: Map<String, String>.from(json['propiedades'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Serialización a JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'calorias': calorias,
      'proteina': proteina,
      'carbohidratos': carbohidratos,
      'grasas': grasas,
      'propiedades': propiedades,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Convertir lista de JSON a lista de objetos
  static List<AlimentosPSD> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AlimentosPSD.fromJson(json)).toList();
  }

  // Convertir lista de objetos a lista de JSON
  static List<Map<String, dynamic>> toJsonList(List<AlimentosPSD> list) {
    return list.map((item) => item.toJson()).toList();
  }

  // Método para crear una lista de objetos a partir de JSON
  static List<AlimentosPSD> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => AlimentosPSD.fromJson(json)).toList();
  }
}
