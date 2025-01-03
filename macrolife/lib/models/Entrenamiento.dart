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
  String? descripcion;
  // int? caloriasQuemadas;
  // int? levantamientoPesass;
  // int? pasos;
  // int? otro;

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
    this.descripcion,
    // this.caloriasQuemadas,
    // this.levantamientoPesass,
    // this.pasos,
    // this.otro,
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
    descripcion = json['descripcion'];
    ejercicio = json['ejercicio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // caloriasQuemadas = json['caloriasQuemadas'];
    // levantamientoPesass = json['levantamientoPesass'];
    // pasos = json['pasos'];
    // otro = json['otro'];
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
    data['descripcion'] = descripcion;

    // data['caloriasQuemadas'] = caloriasQuemadas;
    // data['levantamientoPesass'] = levantamientoPesass;
    // data['pasos'] = pasos;
    // data['otro'] = otro;

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
