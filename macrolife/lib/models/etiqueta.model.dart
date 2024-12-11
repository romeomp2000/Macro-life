class EtiquetasModel {
  int? idEtiqueta;
  int? idUsuario;
  String? etiqueta;

  EtiquetasModel({this.idEtiqueta, this.idUsuario, this.etiqueta});

  EtiquetasModel.fromJson(Map<String, dynamic> json) {
    idEtiqueta = json['id_etiqueta'];
    idUsuario = json['id_usuario'];
    etiqueta = json['etiqueta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_etiqueta'] = this.idEtiqueta;
    data['id_usuario'] = this.idUsuario;
    data['etiqueta'] = this.etiqueta;
    return data;
  }
}
