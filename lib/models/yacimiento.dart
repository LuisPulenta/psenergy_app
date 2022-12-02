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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombreyacimiento'] = nombreyacimiento;
    data['fechaalta'] = fechaalta;
    data['area'] = area;
    data['activo'] = activo;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'nombreyacimiento': nombreyacimiento,
      'fechaalta': fechaalta,
      'area': area,
      'activo': activo,
    };
  }
}
