class Destino {
  int idnotificacion = 0;
  int iduser = 0;
  String? observaciones = '';

  Destino(
      {required this.idnotificacion,
      required this.iduser,
      required this.observaciones});

  Destino.fromJson(Map<String, dynamic> json) {
    idnotificacion = json['idnotificacion'];
    iduser = json['iduser'];
    observaciones = json['observaciones'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idnotificacion'] = idnotificacion;
    data['iduser'] = iduser;
    data['observaciones'] = observaciones;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idnotificacion': idnotificacion,
      'iduser': iduser,
      'observaciones': observaciones,
    };
  }
}
