class RachaDiasModel {
  bool? lun;
  bool? mar;
  bool? mie;
  bool? jue;
  bool? vie;
  bool? sab;
  bool? dom;

  RachaDiasModel(
      {this.lun, this.mar, this.mie, this.jue, this.vie, this.sab, this.dom});

  RachaDiasModel.fromJson(Map<String, dynamic> json) {
    lun = json['Lun'];
    mar = json['Mar'];
    mie = json['Mie'];
    jue = json['Jue'];
    vie = json['Vie'];
    sab = json['Sab'];
    dom = json['Dom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Lun'] = this.lun;
    data['Mar'] = this.mar;
    data['Mie'] = this.mie;
    data['Jue'] = this.jue;
    data['Vie'] = this.vie;
    data['Sab'] = this.sab;
    data['Dom'] = this.dom;
    return data;
  }
}
