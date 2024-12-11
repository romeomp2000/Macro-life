class ImpuestosModel {
  int? idImpuesto;
  int? idUsuario;
  String? tipoImpuesto;
  String? descripcion;
  String? clave;
  String? impuesto;
  String? tipofactor;
  double? tasaocuota;
  String? estatus;

  ImpuestosModel({
    this.idImpuesto,
    this.idUsuario,
    this.tipoImpuesto,
    this.descripcion,
    this.clave,
    this.impuesto,
    this.tipofactor,
    this.tasaocuota,
    this.estatus,
  });

  ImpuestosModel.fromJson(Map<String, dynamic> json) {
    idImpuesto = json['id_impuesto'];
    idUsuario = json['id_usuario'];
    tipoImpuesto = json['tipo_impuesto'];
    descripcion = json['descripcion'];
    clave = json['clave'];
    impuesto = json['impuesto'];
    tipofactor = json['tipofactor'];
    tasaocuota =
        json['tasaocuota']?.toDouble(); // Asegúrate de convertir a double
    estatus = json['estatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_impuesto'] = this.idImpuesto;
    data['id_usuario'] = this.idUsuario;
    data['tipo_impuesto'] = this.tipoImpuesto;
    data['descripcion'] = this.descripcion;
    data['clave'] = this.clave;
    data['impuesto'] = this.impuesto;
    data['tipofactor'] = this.tipofactor;
    data['tasaocuota'] = this.tasaocuota;
    data['estatus'] = this.estatus;
    return data;
  }
}
