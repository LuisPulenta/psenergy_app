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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idcontrolformula'] = this.idcontrolformula;
    data['idcontrolcab'] = this.idcontrolcab;
    data['idpozo'] = this.idpozo;
    data['idformula'] = this.idformula;
    data['valor'] = this.valor;
    data['fechaapp'] = this.fechaapp;
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
