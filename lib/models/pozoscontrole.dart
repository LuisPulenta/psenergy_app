class PozosControle {
  int idcontrol = 0;
  String codigopozo = '';
  int idformula = 0;
  String alarma = '';
  String? obligatorio = '';

  PozosControle(
      {required this.idcontrol,
      required this.codigopozo,
      required this.idformula,
      required this.alarma,
      required this.obligatorio});

  PozosControle.fromJson(Map<String, dynamic> json) {
    idcontrol = json['idcontrol'];
    codigopozo = json['codigopozo'];
    idformula = json['idformula'];
    alarma = json['alarma'];
    obligatorio = json['obligatorio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcontrol'] = this.idcontrol;
    data['codigopozo'] = this.codigopozo;
    data['idformula'] = this.idformula;
    data['alarma'] = this.alarma;
    data['obligatorio'] = this.obligatorio;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idcontrol': idcontrol,
      'codigopozo': codigopozo,
      'idformula': idformula,
      'alarma': alarma,
      'obligatorio': obligatorio,
    };
  }
}
