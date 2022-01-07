class MedicionCabecera {
  int idControlPozo = 0;
  String bateria = '';
  String pozo = '';
  String fecha = '';
  double? ql = 0;
  double? qo = 0;
  double? qw = 0;
  double? qg = 0;
  double? wcLibre = 0;
  double? wcEmulc = 0;
  double? wcTotal = 0;
  double? sales = 0;
  double? gor = 0;
  double? t = 0;
  String validacionControl = '';
  double? prTbg = 0;
  double? prLinea = 0;
  double? prCsg = 0;
  double? regimenOperacion = 0;
  double? aibCarrera = 0;
  double? bespip = 0;
  double? pcpTorque = 0;
  String observaciones = '';
  int? validadoSupervisor = 0;
  int? userIdInput = 0;
  int? userIDValida = 0;
  double? caudalInstantaneo = 0.0;
  double? caudalMedio = 0.0;
  double? lecturaAcumulada = 0;
  double? presionBDP = 0;
  double? presionAntFiltro = 0;
  double? presionEC = 0;
  String ingresoDatos = '';
  int? reenvio = 0;
  String muestra = '';
  String fechaCarga = '';
  int? idUserValidaMuestra = 0;
  int? idUserImputSoft = 0;
  double? volt = 0;
  double? amper = 0;
  double? temp = 0;
  String fechaCargaAPP = '';
  int? enviado = 0;

  MedicionCabecera(
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
      required this.fechaCargaAPP,
      required this.enviado});

  MedicionCabecera.fromJson(Map<String, dynamic> json) {
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
    enviado = json['enviado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idControlPozo'] = this.idControlPozo;
    data['bateria'] = this.bateria;
    data['pozo'] = this.pozo;
    data['fecha'] = this.fecha;
    data['ql'] = this.ql;
    data['qo'] = this.qo;
    data['qw'] = this.qw;
    data['qg'] = this.qg;
    data['wcLibre'] = this.wcLibre;
    data['wcEmulc'] = this.wcEmulc;
    data['wcTotal'] = this.wcTotal;
    data['sales'] = this.sales;
    data['gor'] = this.gor;
    data['t'] = this.t;
    data['validacionControl'] = this.validacionControl;
    data['prTbg'] = this.prTbg;
    data['prLinea'] = this.prLinea;
    data['prCsg'] = this.prCsg;
    data['regimenOperacion'] = this.regimenOperacion;
    data['aibCarrera'] = this.aibCarrera;
    data['bespip'] = this.bespip;
    data['pcpTorque'] = this.pcpTorque;
    data['observaciones'] = this.observaciones;
    data['validadoSupervisor'] = this.validadoSupervisor;
    data['userIdInput'] = this.userIdInput;
    data['userIDValida'] = this.userIDValida;
    data['caudalInstantaneo'] = this.caudalInstantaneo;
    data['caudalMedio'] = this.caudalMedio;
    data['lecturaAcumulada'] = this.lecturaAcumulada;
    data['presionBDP'] = this.presionBDP;
    data['presionAntFiltro'] = this.presionAntFiltro;
    data['presionEC'] = this.presionEC;
    data['ingresoDatos'] = this.ingresoDatos;
    data['reenvio'] = this.reenvio;
    data['muestra'] = this.muestra;
    data['fechaCarga'] = this.fechaCarga;
    data['idUserValidaMuestra'] = this.idUserValidaMuestra;
    data['idUserImputSoft'] = this.idUserImputSoft;
    data['volt'] = this.volt;
    data['amper'] = this.amper;
    data['temp'] = this.temp;
    data['fechaCargaAPP'] = this.fechaCargaAPP;
    data['enviado'] = this.enviado;
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
      'enviado': enviado,
    };
  }
}
