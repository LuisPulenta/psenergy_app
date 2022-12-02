class MedicionDetalle {
  int idcontrolformula = 0;
  int? idcontrolcab = 0;
  String? idpozo = '';
  int? idformula = 0;
  double? valor = 0.0;
  String? fechaapp = '';

  MedicionDetalle(
      {required this.idcontrolformula,
      required this.idcontrolcab,
      required this.idpozo,
      required this.idformula,
      required this.valor,
      required this.fechaapp});

  MedicionDetalle.fromJson(Map<String, dynamic> json) {
    idcontrolformula = json['idcontrolformula'];
    idcontrolcab = json['idcontrolcab'];
    idpozo = json['idpozo'];
    idformula = json['idformula'];
    valor = json['valor'];
    fechaapp = json['fechaapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcontrolformula'] = idcontrolformula;
    data['idcontrolcab'] = idcontrolcab;
    data['idpozo'] = idpozo;
    data['idformula'] = idformula;
    data['valor'] = valor;
    data['fechaapp'] = fechaapp;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idcontrolformula': idcontrolformula,
      'idcontrolcab': idcontrolcab,
      'idpozo': idpozo,
      'idformula': idformula,
      'valor': valor,
      'fechaapp': fechaapp,
    };
  }
}
