class Alarma {
  int? idalarma = 0;
  String? fechacarga = '';
  int? provieneidcontrol = 0;
  String? pozo = '';
  String? bateria = '';
  int? idusuariocarga = 0;
  int? idusuarioapp = 0;
  String? fechaejecutada = '';
  int? nuevoidcontrol = 0;
  String? observacion = '';
  int? tag = 0;

  Alarma(
      {required this.idalarma,
      required this.fechacarga,
      required this.provieneidcontrol,
      required this.pozo,
      required this.bateria,
      required this.idusuariocarga,
      required this.idusuarioapp,
      required this.fechaejecutada,
      required this.nuevoidcontrol,
      required this.observacion,
      required this.tag});

  Alarma.fromJson(Map<String, dynamic> json) {
    idalarma = json['idalarma'];
    fechacarga = json['fechacarga'];
    provieneidcontrol = json['provieneidcontrol'];
    pozo = json['pozo'];
    bateria = json['bateria'];
    idusuariocarga = json['idusuariocarga'];
    idusuarioapp = json['idusuarioapp'];
    fechaejecutada = json['fechaejecutada'];
    nuevoidcontrol = json['nuevoidcontrol'];
    observacion = json['observacion'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idalarma'] = idalarma;
    data['fechacarga'] = fechacarga;
    data['provieneidcontrol'] = provieneidcontrol;
    data['pozo'] = pozo;
    data['bateria'] = bateria;
    data['idusuariocarga'] = idusuariocarga;
    data['idusuarioapp'] = idusuarioapp;
    data['fechaejecutada'] = fechaejecutada;
    data['nuevoidcontrol'] = nuevoidcontrol;
    data['observacion'] = observacion;
    data['tag'] = tag;
    return data;
  }
}
