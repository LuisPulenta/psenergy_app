class PozosFormula {
  int idformula = 0;
  String tiposistema = '';
  String tipodatos = '';
  int rangodesde = 0;
  int rangohasta = 0;

  PozosFormula(
      {required this.idformula,
      required this.tiposistema,
      required this.tipodatos,
      required this.rangodesde,
      required this.rangohasta});

  PozosFormula.fromJson(Map<String, dynamic> json) {
    idformula = json['idformula'];
    tiposistema = json['tiposistema'];
    tipodatos = json['tipodatos'];
    rangodesde = json['rangodesde'];
    rangohasta = json['rangohasta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idformula'] = this.idformula;
    data['tiposistema'] = this.tiposistema;
    data['tipodatos'] = this.tipodatos;
    data['rangodesde'] = this.rangodesde;
    data['rangohasta'] = this.rangohasta;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idformula': idformula,
      'tiposistema': tiposistema,
      'tipodatos': tipodatos,
      'rangodesde': rangodesde,
      'rangohasta': rangohasta,
    };
  }
}
