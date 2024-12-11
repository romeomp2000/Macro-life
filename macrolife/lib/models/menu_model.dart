class MenuModel {
  int? id;
  String? enlace;
  String? imagen;
  String? nombre;
  List<MenuModel>? modulos;

  MenuModel({
    this.id,
    this.enlace,
    this.imagen,
    this.nombre,
    this.modulos,
  });

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enlace = json['enlace'];
    imagen = json['imagen'];
    nombre = json['nombre'];
    modulos = MenuModel.fromJsonList(json['modulos']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enlace'] = enlace;
    data['imagen'] = imagen;
    data['nombre'] = nombre;
    data['modulos'] = modulos?.map((e) => e.toJson()).toList();
    return data;
  }

  static List<MenuModel> fromJsonList(List list) {
    return list.map((e) => MenuModel.fromJson(e)).toList();
  }
}

