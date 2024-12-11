class Estado {
  String? sId;
  String? nombre;
  String? clave;
  String? pais;

  Estado({
    this.sId,
    this.nombre,
    this.clave,
    this.pais,
  });

  Estado.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nombre = json['nombre'];
    clave = json['clave'];
    pais = json['pais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nombre'] = nombre;
    data['clave'] = clave;
    data['pais'] = pais;
    return data;
  }

  static List<Estado> fromJsonList(List list) {
    return list.map((e) => Estado.fromJson(e)).toList();
  }
}
