class UnidadesMedidaModel {
  int? idUnidad;
  int? idUsuario;
  String? unidad;
  String? descripcion;
  String? unidadSat;
  String? estatus;

  UnidadesMedidaModel(
      {this.idUnidad,
      this.idUsuario,
      this.unidad,
      this.descripcion,
      this.unidadSat,
      this.estatus});

  UnidadesMedidaModel.fromJson(Map<String, dynamic> json) {
    idUnidad = json['id_unidad'];
    idUsuario = json['id_usuario'];
    unidad = json['unidad'];
    descripcion = json['descripcion'];
    unidadSat = json['unidad_sat'];
    estatus = json['estatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_unidad'] = this.idUnidad;
    data['id_usuario'] = this.idUsuario;
    data['unidad'] = this.unidad;
    data['descripcion'] = this.descripcion;
    data['unidad_sat'] = this.unidadSat;
    data['estatus'] = this.estatus;
    return data;
  }
}
