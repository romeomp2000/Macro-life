class ConfiguracionesModel {
  Suscripcion? suscripcion;
  PayPal? payPal;
  Stripe? stripe;
  String? sId;

  ConfiguracionesModel({this.suscripcion, this.payPal, this.stripe, this.sId});

  ConfiguracionesModel.fromJson(Map<String, dynamic> json) {
    suscripcion = json['suscripcion'] != null
        ? new Suscripcion.fromJson(json['suscripcion'])
        : null;
    payPal =
        json['payPal'] != null ? new PayPal.fromJson(json['payPal']) : null;
    stripe =
        json['stripe'] != null ? new Stripe.fromJson(json['stripe']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suscripcion != null) {
      data['suscripcion'] = this.suscripcion!.toJson();
    }
    if (this.payPal != null) {
      data['payPal'] = this.payPal!.toJson();
    }
    if (this.stripe != null) {
      data['stripe'] = this.stripe!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Suscripcion {
  double? mensual;
  double? descuentoAnual;
  double? anual;

  Suscripcion({this.mensual, this.descuentoAnual, this.anual});

  Suscripcion.fromJson(Map<String, dynamic> json) {
    mensual = _toDouble(json['mensual']);
    descuentoAnual = _toDouble(json['descuentoAnual']);
    anual = _toDouble(json['anual']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mensual'] = this.mensual;
    data['descuentoAnual'] = this.descuentoAnual;
    data['anual'] = this.anual;
    return data;
  }

  // Función auxiliar para convertir a double
  double? _toDouble(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      // Manejar casos donde el valor no es ni int ni double (por ejemplo, String)
      throw ArgumentError('Valor no válido: $value');
    }
  }
}

class PayPal {
  String? clientID;
  String? secretKey;

  PayPal({this.clientID, this.secretKey});

  PayPal.fromJson(Map<String, dynamic> json) {
    clientID = json['clientID'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientID'] = this.clientID;
    data['secretKey'] = this.secretKey;
    return data;
  }
}

class Stripe {
  String? publicKey;
  String? secretKey;

  Stripe({this.publicKey, this.secretKey});

  Stripe.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicKey'] = this.publicKey;
    data['secretKey'] = this.secretKey;
    return data;
  }
}
