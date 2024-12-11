class SerieModel {
  int? idSerie;
  int? idUsuario;
  String? descripcion;
  String? serie;
  int? folio;
  int? folioInicial;
  String? tipo;
  String? estatus;
  String? nombreSucursal;
  String? calle;
  String? numeroExterior;
  String? numeroInterior;
  String? colonia;
  String? municipio;
  int? idEstado;
  String? codigoPostal;

  SerieModel(
      {this.idSerie,
      this.idUsuario,
      this.descripcion,
      this.serie,
      this.folio,
      this.folioInicial,
      this.tipo,
      this.estatus,
      this.nombreSucursal,
      this.calle,
      this.numeroExterior,
      this.numeroInterior,
      this.colonia,
      this.municipio,
      this.idEstado,
      this.codigoPostal});

  SerieModel.fromJson(Map<String, dynamic> json) {
    idSerie = json['id_serie'];
    idUsuario = json['id_usuario'];
    descripcion = json['descripcion'];
    serie = json['serie'];
    folio = json['folio'];
    folioInicial = json['folio_inicial'];
    tipo = json['tipo'];
    estatus = json['estatus'];
    nombreSucursal = json['nombre_sucursal'];
    calle = json['calle'];
    numeroExterior = json['numero_exterior'];
    numeroInterior = json['numero_interior'];
    colonia = json['colonia'];
    municipio = json['municipio'];
    idEstado = json['id_estado'];
    codigoPostal = json['codigo_postal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_serie'] = this.idSerie;
    data['id_usuario'] = this.idUsuario;
    data['descripcion'] = this.descripcion;
    data['serie'] = this.serie;
    data['folio'] = this.folio;
    data['folio_inicial'] = this.folioInicial;
    data['tipo'] = this.tipo;
    data['estatus'] = this.estatus;
    data['nombre_sucursal'] = this.nombreSucursal;
    data['calle'] = this.calle;
    data['numero_exterior'] = this.numeroExterior;
    data['numero_interior'] = this.numeroInterior;
    data['colonia'] = this.colonia;
    data['municipio'] = this.municipio;
    data['id_estado'] = this.idEstado;
    data['codigo_postal'] = this.codigoPostal;
    return data;
  }
}
