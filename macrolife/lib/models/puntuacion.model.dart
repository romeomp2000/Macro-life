class PuntuacionSalud {
  final String nombre;
  final String descripcion;
  final int score;
  final List<String> caracteristicas; // Se añade la lista de caracteristicas

  // Constructor
  PuntuacionSalud({
    required this.nombre,
    required this.descripcion,
    required this.score,
    required this.caracteristicas, // Asegúrate de incluirlo aquí
  });

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'score': score,
      'caracteristicas': caracteristicas, // Añadir caracteristicas aquí
    };
  }

  // Método para crear el objeto a partir de JSON
  factory PuntuacionSalud.fromJson(Map<String, dynamic> json) {
    return PuntuacionSalud(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      score: json['score'],
      caracteristicas: List<String>.from(
          json['caracteristicas'] ?? []), // Añadir caracteristicas aquí
    );
  }

  // Método para convertir una lista de objetos a JSON
  static List<Map<String, dynamic>> listToJson(
      List<PuntuacionSalud> puntuacionSaluds) {
    return puntuacionSaluds
        .map((puntuacionSalud) => puntuacionSalud.toJson())
        .toList();
  }

  // Método para crear una lista de objetos a partir de JSON
  static List<PuntuacionSalud> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => PuntuacionSalud.fromJson(json)).toList();
  }
}
