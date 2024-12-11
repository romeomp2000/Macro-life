class ProductoModel {
  int? idProducto;
  String? clave;
  String? producto;
  String? objetoimp;
  String? estatus;
  String? unidad;

  ProductoModel(
      {this.idProducto,
      this.clave,
      this.producto,
      this.objetoimp,
      this.estatus,
      this.unidad});

  ProductoModel.fromJson(Map<String, dynamic> json) {
    idProducto = json['id_producto'];
    clave = json['clave'];
    producto = json['producto'];
    objetoimp = json['objetoimp'];
    estatus = json['estatus'];
    unidad = json['unidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_producto'] = this.idProducto;
    data['clave'] = this.clave;
    data['producto'] = this.producto;
    data['objetoimp'] = this.objetoimp;
    data['estatus'] = this.estatus;
    data['unidad'] = this.unidad;
    return data;
  }
}
