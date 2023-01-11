class Notificacion {
  int idnotficacion = 0;
  String? tipo = '';
  String? fechacarga = '';
  String? fechaemrec = '';
  String? emisor = '';
  String? enteempresa = '';
  String? juridiccion = '';
  String? area = '';
  String? notareferencia = '';
  int? plazo = 0;
  String? dirigidoa = '';
  String? clase = '';
  String? nroExpediente = '';
  String? estado = '';
  String? prioridad = '';
  String? fechaFin = '';

  Notificacion(
      {required this.idnotficacion,
      required this.tipo,
      required this.fechacarga,
      required this.fechaemrec,
      required this.emisor,
      required this.enteempresa,
      required this.juridiccion,
      required this.area,
      required this.notareferencia,
      required this.plazo,
      required this.dirigidoa,
      required this.clase,
      required this.nroExpediente,
      required this.estado,
      required this.prioridad,
      required this.fechaFin});

  Notificacion.fromJson(Map<String, dynamic> json) {
    idnotficacion = json['idnotficacion'];
    tipo = json['tipo'];
    fechacarga = json['fechacarga'];
    fechaemrec = json['fechaemrec'];
    emisor = json['emisor'];
    enteempresa = json['enteempresa'];
    juridiccion = json['juridiccion'];
    area = json['area'];
    notareferencia = json['notareferencia'];
    plazo = json['plazo'];
    dirigidoa = json['dirigidoa'];
    clase = json['clase'];
    nroExpediente = json['nroExpediente'];
    estado = json['estado'];
    prioridad = json['prioridad'];
    fechaFin = json['fechaFin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idnotficacion'] = idnotficacion;
    data['tipo'] = tipo;
    data['fechacarga'] = fechacarga;
    data['fechaemrec'] = fechaemrec;
    data['emisor'] = emisor;
    data['enteempresa'] = enteempresa;
    data['juridiccion'] = juridiccion;
    data['area'] = area;
    data['notareferencia'] = notareferencia;
    data['plazo'] = plazo;
    data['dirigidoa'] = dirigidoa;
    data['clase'] = clase;
    data['nroExpediente'] = nroExpediente;
    data['estado'] = estado;
    data['prioridad'] = prioridad;
    data['fechaFin'] = fechaFin;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idnotficacion': idnotficacion,
      'tipo': tipo,
      'fechacarga': fechacarga,
      'fechaemrec': fechaemrec,
      'emisor': emisor,
      'enteempresa': enteempresa,
      'juridiccion': juridiccion,
      'area': area,
      'notareferencia': notareferencia,
      'plazo': plazo,
      'dirigidoa': dirigidoa,
      'clase': clase,
      'nroExpediente': nroExpediente,
      'estado': estado,
      'prioridad': prioridad,
      'fechaFin': fechaFin,
    };
  }
}
