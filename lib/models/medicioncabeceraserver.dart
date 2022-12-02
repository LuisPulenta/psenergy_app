class MedicionCabeceraServer {
  int idControlPozo = 0;
  String bateria = '';
  String pozo = '';
  String fecha = '';
  int? ql = 0;
  int? qo = 0;
  int? qw = 0;
  int? qg = 0;
  int? wcLibre = 0;
  int? wcEmulc = 0;
  int? wcTotal = 0;
  int? sales = 0;
  int? gor = 0;
  int? t = 0;
  String validacionControl = '';
  int? prTbg = 0;
  int? prLinea = 0;
  int? prCsg = 0;
  int? regimenOperacion = 0;
  int? aibCarrera = 0;
  int? bespip = 0;
  int? pcpTorque = 0;
  String observaciones = '';
  int? validadoSupervisor = 0;
  int? userIdInput = 0;
  int? userIDValida = 0;
  double? caudalInstantaneo = 0.0;
  double? caudalMedio = 0.0;
  int? lecturaAcumulada = 0;
  int? presionBDP = 0;
  int? presionAntFiltro = 0;
  int? presionEC = 0;
  String ingresoDatos = '';
  int? reenvio = 0;
  String muestra = '';
  String fechaCarga = '';
  int? idUserValidaMuestra = 0;
  int? idUserImputSoft = 0;
  int? volt = 0;
  int? amper = 0;
  int? temp = 0;
  String fechaCargaAPP = '';

  MedicionCabeceraServer(
      {required this.idControlPozo,
      required this.bateria,
      required this.pozo,
      required this.fecha,
      required this.ql,
      required this.qo,
      required this.qw,
      required this.qg,
      required this.wcLibre,
      required this.wcEmulc,
      required this.wcTotal,
      required this.sales,
      required this.gor,
      required this.t,
      required this.validacionControl,
      required this.prTbg,
      required this.prLinea,
      required this.prCsg,
      required this.regimenOperacion,
      required this.aibCarrera,
      required this.bespip,
      required this.pcpTorque,
      required this.observaciones,
      required this.validadoSupervisor,
      required this.userIdInput,
      required this.userIDValida,
      required this.caudalInstantaneo,
      required this.caudalMedio,
      required this.lecturaAcumulada,
      required this.presionBDP,
      required this.presionAntFiltro,
      required this.presionEC,
      required this.ingresoDatos,
      required this.reenvio,
      required this.muestra,
      required this.fechaCarga,
      required this.idUserValidaMuestra,
      required this.idUserImputSoft,
      required this.volt,
      required this.amper,
      required this.temp,
      required this.fechaCargaAPP});

  MedicionCabeceraServer.fromJson(Map<String, dynamic> json) {
    idControlPozo = json['idControlPozo'];
    bateria = json['bateria'];
    pozo = json['pozo'];
    fecha = json['fecha'];
    ql = json['ql'];
    qo = json['qo'];
    qw = json['qw'];
    qg = json['qg'];
    wcLibre = json['wcLibre'];
    wcEmulc = json['wcEmulc'];
    wcTotal = json['wcTotal'];
    sales = json['sales'];
    gor = json['gor'];
    t = json['t'];
    validacionControl = json['validacionControl'];
    prTbg = json['prTbg'];
    prLinea = json['prLinea'];
    prCsg = json['prCsg'];
    regimenOperacion = json['regimenOperacion'];
    aibCarrera = json['aibCarrera'];
    bespip = json['bespip'];
    pcpTorque = json['pcpTorque'];
    observaciones = json['observaciones'];
    validadoSupervisor = json['validadoSupervisor'];
    userIdInput = json['userIdInput'];
    userIDValida = json['userIDValida'];
    caudalInstantaneo = json['caudalInstantaneo'];
    caudalMedio = json['caudalMedio'];
    lecturaAcumulada = json['lecturaAcumulada'];
    presionBDP = json['presionBDP'];
    presionAntFiltro = json['presionAntFiltro'];
    presionEC = json['presionEC'];
    ingresoDatos = json['ingresoDatos'];
    reenvio = json['reenvio'];
    muestra = json['muestra'];
    fechaCarga = json['fechaCarga'];
    idUserValidaMuestra = json['idUserValidaMuestra'];
    idUserImputSoft = json['idUserImputSoft'];
    volt = json['volt'];
    amper = json['amper'];
    temp = json['temp'];
    fechaCargaAPP = json['fechaCargaAPP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idControlPozo'] = idControlPozo;
    data['bateria'] = bateria;
    data['pozo'] = pozo;
    data['fecha'] = fecha;
    data['ql'] = ql;
    data['qo'] = qo;
    data['qw'] = qw;
    data['qg'] = qg;
    data['wcLibre'] = wcLibre;
    data['wcEmulc'] = wcEmulc;
    data['wcTotal'] = wcTotal;
    data['sales'] = sales;
    data['gor'] = gor;
    data['t'] = t;
    data['validacionControl'] = validacionControl;
    data['prTbg'] = prTbg;
    data['prLinea'] = prLinea;
    data['prCsg'] = prCsg;
    data['regimenOperacion'] = regimenOperacion;
    data['aibCarrera'] = aibCarrera;
    data['bespip'] = bespip;
    data['pcpTorque'] = pcpTorque;
    data['observaciones'] = observaciones;
    data['validadoSupervisor'] = validadoSupervisor;
    data['userIdInput'] = userIdInput;
    data['userIDValida'] = userIDValida;
    data['caudalInstantaneo'] = caudalInstantaneo;
    data['caudalMedio'] = caudalMedio;
    data['lecturaAcumulada'] = lecturaAcumulada;
    data['presionBDP'] = presionBDP;
    data['presionAntFiltro'] = presionAntFiltro;
    data['presionEC'] = presionEC;
    data['ingresoDatos'] = ingresoDatos;
    data['reenvio'] = reenvio;
    data['muestra'] = muestra;
    data['fechaCarga'] = fechaCarga;
    data['idUserValidaMuestra'] = idUserValidaMuestra;
    data['idUserImputSoft'] = idUserImputSoft;
    data['volt'] = volt;
    data['amper'] = amper;
    data['temp'] = temp;
    data['fechaCargaAPP'] = fechaCargaAPP;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idControlPozo': idControlPozo,
      'bateria': bateria,
      'pozo': pozo,
      'fecha': fecha,
      'ql': ql,
      'qo': qo,
      'qw': qw,
      'qg': qg,
      'wcLibre': wcLibre,
      'wcEmulc': wcEmulc,
      'wcTotal': wcTotal,
      'sales': sales,
      'gor': gor,
      't': t,
      'validacionControl': validacionControl,
      'prTbg': prTbg,
      'prLinea': prLinea,
      'prCsg': prCsg,
      'regimenOperacion': regimenOperacion,
      'aibCarrera': aibCarrera,
      'bespip': bespip,
      'pcpTorque': pcpTorque,
      'observaciones': observaciones,
      'validadoSupervisor': validadoSupervisor,
      'userIdInput': userIdInput,
      'userIDValida': userIDValida,
      'caudalInstantaneo': caudalInstantaneo,
      'caudalMedio': caudalMedio,
      'lecturaAcumulada': lecturaAcumulada,
      'presionBDP': presionBDP,
      'presionAntFiltro': presionAntFiltro,
      'presionEC': presionEC,
      'ingresoDatos': ingresoDatos,
      'reenvio': reenvio,
      'muestra': muestra,
      'fechaCarga': fechaCarga,
      'idUserValidaMuestra': idUserValidaMuestra,
      'idUserImputSoft': idUserImputSoft,
      'volt': volt,
      'amper': amper,
      'temp': temp,
      'fechaCargaAPP': fechaCargaAPP,
    };
  }
}
