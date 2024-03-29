class MedicionDet {
  int idcontrolformula = 0;
  int idcontrolcab = 0;
  String idpozo = '';
  int idformula = 0;
  int valor = 0;
  String fechaAPP = '';

  MedicionDet(
      {required this.idcontrolformula,
      required this.idcontrolcab,
      required this.idpozo,
      required this.idformula,
      required this.valor,
      required this.fechaAPP});

  MedicionDet.fromJson(Map<String, dynamic> json) {
    idcontrolformula = json['idcontrolformula'];
    idcontrolcab = json['idcontrolcab'];
    idpozo = json['idpozo'];
    idformula = json['idformula'];
    valor = json['valor'];
    fechaAPP = json['fechaAPP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcontrolformula'] = idcontrolformula;
    data['idcontrolcab'] = idcontrolcab;
    data['idpozo'] = idpozo;
    data['idformula'] = idformula;
    data['valor'] = valor;
    data['fechaAPP'] = fechaAPP;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idcontrolformula': idcontrolformula,
      'idcontrolcab': idcontrolcab,
      'idpozo': idpozo,
      'idformula': idformula,
      'valor': valor,
      'fechaAPP': fechaAPP,
    };
  }
}
