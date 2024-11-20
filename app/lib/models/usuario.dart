class Usuario {
  int? idUsuario;
  int? idDistribuidor;
  int? idUsuarioPadre;
  String? tipoUsuario;
  String? clave;
  int? cuota;
  int? idComision;
  String? nombreCompleto;
  String? usuario;
  String? password;
  String? direccion;
  String? telefono;
  String? email;
  Null? fechaNacimiento;
  String? foto;
  Null? thumbnail;
  String? fechaRegistro;
  String? altasSecciones;
  String? bajasSecciones;
  String? consultasSecciones;
  String? actualizaSecciones;
  String? cargasSecciones;
  String? reportesSecciones;
  Null? resetPasswordToken;
  int? idUsuarioAnterior;
  String? estatus;
  String? timestamp;

  Usuario(
      {this.idUsuario,
      this.idDistribuidor,
      this.idUsuarioPadre,
      this.tipoUsuario,
      this.clave,
      this.cuota,
      this.idComision,
      this.nombreCompleto,
      this.usuario,
      this.password,
      this.direccion,
      this.telefono,
      this.email,
      this.fechaNacimiento,
      this.foto,
      this.thumbnail,
      this.fechaRegistro,
      this.altasSecciones,
      this.bajasSecciones,
      this.consultasSecciones,
      this.actualizaSecciones,
      this.cargasSecciones,
      this.reportesSecciones,
      this.resetPasswordToken,
      this.idUsuarioAnterior,
      this.estatus,
      this.timestamp});

  Usuario.fromJson(Map<String, dynamic> json) {
    idUsuario = json['id_usuario'];
    idDistribuidor = json['id_distribuidor'];
    idUsuarioPadre = json['id_usuario_padre'];
    tipoUsuario = json['tipo_usuario'];
    clave = json['clave'];
    cuota = json['cuota'];
    idComision = json['id_comision'];
    nombreCompleto = json['nombre_completo'];
    usuario = json['usuario'];
    password = json['password'];
    direccion = json['direccion'];
    telefono = json['telefono'];
    email = json['email'];
    fechaNacimiento = json['fecha_nacimiento'];
    foto = json['foto'];
    thumbnail = json['thumbnail'];
    fechaRegistro = json['fecha_registro'];
    altasSecciones = json['altas_secciones'];
    bajasSecciones = json['bajas_secciones'];
    consultasSecciones = json['consultas_secciones'];
    actualizaSecciones = json['actualiza_secciones'];
    cargasSecciones = json['cargas_secciones'];
    reportesSecciones = json['reportes_secciones'];
    resetPasswordToken = json['reset_password_token'];
    idUsuarioAnterior = json['id_usuario_anterior'];
    estatus = json['estatus'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_usuario'] = this.idUsuario;
    data['id_distribuidor'] = this.idDistribuidor;
    data['id_usuario_padre'] = this.idUsuarioPadre;
    data['tipo_usuario'] = this.tipoUsuario;
    data['clave'] = this.clave;
    data['cuota'] = this.cuota;
    data['id_comision'] = this.idComision;
    data['nombre_completo'] = this.nombreCompleto;
    data['usuario'] = this.usuario;
    data['password'] = this.password;
    data['direccion'] = this.direccion;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    data['fecha_nacimiento'] = this.fechaNacimiento;
    data['foto'] = this.foto;
    data['thumbnail'] = this.thumbnail;
    data['fecha_registro'] = this.fechaRegistro;
    data['altas_secciones'] = this.altasSecciones;
    data['bajas_secciones'] = this.bajasSecciones;
    data['consultas_secciones'] = this.consultasSecciones;
    data['actualiza_secciones'] = this.actualizaSecciones;
    data['cargas_secciones'] = this.cargasSecciones;
    data['reportes_secciones'] = this.reportesSecciones;
    data['reset_password_token'] = this.resetPasswordToken;
    data['id_usuario_anterior'] = this.idUsuarioAnterior;
    data['estatus'] = this.estatus;
    data['timestamp'] = this.timestamp;
    return data;
  }

  static List<Usuario> fromJsonList(List list) {
    if (list.isEmpty) return List<Usuario>.empty();
    return list.map((item) => Usuario.fromJson(item)).toList();
  }
}
