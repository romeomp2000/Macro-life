class Entrenamiento {
  String? sId;
  String? usuario;
  String? nombre;
  String? intensidad;
  int? calorias;
  int? tiempo;
  String? fecha;
  String? time;
  String? createdAt;
  String? updatedAt;
  String? ejercicio;

  Entrenamiento({
    this.sId,
    this.usuario,
    this.nombre,
    this.intensidad,
    this.calorias,
    this.tiempo,
    this.fecha,
    this.ejercicio,
    this.createdAt,
    this.updatedAt,
  });

  Entrenamiento.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    usuario = json['usuario'];
    nombre = json['nombre'];
    intensidad = json['intensidad'];
    calorias = json['calorias'];
    tiempo = json['tiempo'];
    fecha = json['fecha'];
    time = json['time'];
    ejercicio = json['ejercicio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['usuario'] = usuario;
    data['nombre'] = nombre;
    data['intensidad'] = intensidad;
    data['calorias'] = calorias;
    data['tiempo'] = tiempo;
    data['fecha'] = fecha;
    data['time'] = time;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['ejercicio'] = ejercicio;

    return data;
  }

  // Convertir lista de objetos a lista de JSON
  static List<Map<String, dynamic>> toJsonList(List<Entrenamiento> list) {
    return list.map((item) => item.toJson()).toList();
  }

  static List<Entrenamiento> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Entrenamiento.fromJson(json)).toList();
  }
}
