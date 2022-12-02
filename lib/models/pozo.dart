class Pozo {
  String codigopozo = '';
  String codigobateria = '';
  String descripcion = '';
  String? fechaalta = '';
  int activo = 0;
  String? ultimalectura = '';
  String latitud = '';
  String longitud = '';
  String qrcode = '';
  String observaciones = '';
  String tipopozo = '';
  String sistemaExtraccion = '';
  String? cuenca = '';
  int? idProvincia = 0;
  double? cota = 0;
  double? profundidad = 0.0;
  double? vidaUtil = 0.0;

  Pozo(
      {required this.codigopozo,
      required this.codigobateria,
      required this.descripcion,
      required this.fechaalta,
      required this.activo,
      required this.ultimalectura,
      required this.latitud,
      required this.longitud,
      required this.qrcode,
      required this.observaciones,
      required this.tipopozo,
      required this.sistemaExtraccion,
      required this.cuenca,
      required this.idProvincia,
      required this.cota,
      required this.profundidad,
      required this.vidaUtil});

  Pozo.fromJson(Map<String, dynamic> json) {
    codigopozo = json['codigopozo'];
    codigobateria = json['codigobateria'];
    descripcion = json['descripcion'];
    fechaalta = json['fechaalta'];
    activo = json['activo'];
    ultimalectura = json['ultimalectura'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    qrcode = json['qrcode'];
    observaciones = json['observaciones'];
    tipopozo = json['tipopozo'];
    sistemaExtraccion = json['sistemaExtraccion'];
    cuenca = json['cuenca'];
    idProvincia = json['idProvincia'];
    cota = json['cota'];
    profundidad = json['profundidad'];
    vidaUtil = json['vidaUtil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigopozo'] = codigopozo;
    data['codigobateria'] = codigobateria;
    data['descripcion'] = descripcion;
    data['fechaalta'] = fechaalta;
    data['activo'] = activo;
    data['ultimalectura'] = ultimalectura;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['qrcode'] = qrcode;
    data['observaciones'] = observaciones;
    data['tipopozo'] = tipopozo;
    data['sistemaExtraccion'] = sistemaExtraccion;
    data['cuenca'] = cuenca;
    data['idProvincia'] = idProvincia;
    data['cota'] = cota;
    data['profundidad'] = profundidad;
    data['vidaUtil'] = vidaUtil;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'codigopozo': codigopozo,
      'codigobateria': codigobateria,
      'descripcion': descripcion,
      'fechaalta': fechaalta,
      'activo': activo,
      'ultimalectura': ultimalectura,
      'latitud': latitud,
      'longitud': longitud,
      'qrcode': qrcode,
      'observaciones': observaciones,
      'tipopozo': tipopozo,
      'sistemaExtraccion': sistemaExtraccion,
      'cuenca': cuenca,
      'idProvincia': idProvincia,
      'cota': cota,
      'profundidad': profundidad,
      'vidaUtil': vidaUtil,
    };
  }
}
