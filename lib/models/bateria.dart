class Bateria {
  String codigobateria = '';
  String descripcion = '';
  String? fechaalta = '';
  int activa = 0;
  String nombreyacimiento = '';

  Bateria(
      {required this.codigobateria,
      required this.descripcion,
      required this.fechaalta,
      required this.activa,
      required this.nombreyacimiento});

  Bateria.fromJson(Map<String, dynamic> json) {
    codigobateria = json['codigobateria'];
    descripcion = json['descripcion'];
    fechaalta = json['fechaalta'];
    activa = json['activa'];
    nombreyacimiento = json['nombreyacimiento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigobateria'] = codigobateria;
    data['descripcion'] = descripcion;
    data['fechaalta'] = fechaalta;
    data['activa'] = activa;
    data['nombreyacimiento'] = nombreyacimiento;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'codigobateria': codigobateria,
      'descripcion': descripcion,
      'fechaalta': fechaalta,
      'activa': activa,
      'nombreyacimiento': nombreyacimiento,
    };
  }
}
