class Usuario {
  int idUsuario = 0;
  String nombre = '';
  String apellido = '';
  String login = '';
  String contrasena = '';
  String? fechaUltimoAcceso = '';
  String fullName = '';

  Usuario(
      {required this.idUsuario,
      required this.nombre,
      required this.apellido,
      required this.login,
      required this.contrasena,
      required this.fechaUltimoAcceso,
      required this.fullName});

  Usuario.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    login = json['login'];
    contrasena = json['contrasena'];
    fechaUltimoAcceso = json['fechaUltimoAcceso'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuario'] = this.idUsuario;
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['login'] = this.login;
    data['contrasena'] = this.contrasena;
    data['fechaUltimoAcceso'] = this.fechaUltimoAcceso;
    data['fullName'] = this.fullName;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nombre': nombre,
      'apellido': apellido,
      'login': login,
      'contrasena': contrasena,
      'fechaUltimoAcceso': fechaUltimoAcceso,
      'fullName': fullName,
    };
  }
}
