class ClienteModel {
  int? idCliente;
  int? idUsuario;
  String? empresa;
  String? razonSocial;
  String? personalidad;
  String? rfc;
  String? regimenFiscal;
  String? direccion;
  String? codigoPostal;
  int? idEstado;
  String? telefono;
  String? email;
  String? emailsCopia;
  String? comentarios;
  String? numeroCliente;
  String? fechaRegistro;
  String? estatus;
  String? metodopago;
  String? formapago;
  String? usocfdi;
  String? numregidtrib;
  String? residenciafiscal;

  ClienteModel(
      {this.idCliente,
      this.idUsuario,
      this.empresa,
      this.razonSocial,
      this.personalidad,
      this.rfc,
      this.regimenFiscal,
      this.direccion,
      this.codigoPostal,
      this.idEstado,
      this.telefono,
      this.email,
      this.emailsCopia,
      this.comentarios,
      this.numeroCliente,
      this.fechaRegistro,
      this.estatus,
      this.metodopago,
      this.formapago,
      this.usocfdi,
      this.numregidtrib,
      this.residenciafiscal});

  ClienteModel.fromJson(Map<String, dynamic> json) {
    idCliente = json['id_cliente'];
    idUsuario = json['id_usuario'];
    empresa = json['empresa'];
    razonSocial = json['razon_social'];
    personalidad = json['personalidad'];
    rfc = json['rfc'];
    regimenFiscal = json['regimen_fiscal'];
    direccion = json['direccion'];
    codigoPostal = json['codigo_postal'];
    idEstado = json['id_estado'];
    telefono = json['telefono'];
    email = json['email'];
    emailsCopia = json['emails_copia'];
    comentarios = json['comentarios'];
    numeroCliente = json['numero_cliente'];
    fechaRegistro = json['fecha_registro'];
    estatus = json['estatus'];
    metodopago = json['metodopago'];
    formapago = json['formapago'];
    usocfdi = json['usocfdi'];
    numregidtrib = json['numregidtrib'];
    residenciafiscal = json['residenciafiscal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cliente'] = this.idCliente;
    data['id_usuario'] = this.idUsuario;
    data['empresa'] = this.empresa;
    data['razon_social'] = this.razonSocial;
    data['personalidad'] = this.personalidad;
    data['rfc'] = this.rfc;
    data['regimen_fiscal'] = this.regimenFiscal;
    data['direccion'] = this.direccion;
    data['codigo_postal'] = this.codigoPostal;
    data['id_estado'] = this.idEstado;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    data['emails_copia'] = this.emailsCopia;
    data['comentarios'] = this.comentarios;
    data['numero_cliente'] = this.numeroCliente;
    data['fecha_registro'] = this.fechaRegistro;
    data['estatus'] = this.estatus;
    data['metodopago'] = this.metodopago;
    data['formapago'] = this.formapago;
    data['usocfdi'] = this.usocfdi;
    data['numregidtrib'] = this.numregidtrib;
    data['residenciafiscal'] = this.residenciafiscal;
    return data;
  }
}
