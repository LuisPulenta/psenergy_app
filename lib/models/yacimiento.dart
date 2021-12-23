class Yacimiento {
  String nombreyacimiento = '';
  String? fechaalta = '';
  String area = '';
  int activo = 0;

  Yacimiento(
      {required this.nombreyacimiento,
      required this.fechaalta,
      required this.area,
      required this.activo});

  Yacimiento.fromJson(Map<String, dynamic> json) {
    nombreyacimiento = json['nombreyacimiento'];
    fechaalta = json['fechaalta'];
    area = json['area'];
    activo = json['activo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombreyacimiento'] = this.nombreyacimiento;
    data['fechaalta'] = this.fechaalta;
    data['area'] = this.area;
    data['activo'] = this.activo;
    return data;
  }
}
