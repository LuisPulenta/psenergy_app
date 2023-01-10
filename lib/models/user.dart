class User {
  int idUsuario = 0;
  String nombre = '';
  String apellido = '';
  String login = '';
  String contrasena = '';
  int permOS = 0;

  User(
      {required this.idUsuario,
      required this.nombre,
      required this.apellido,
      required this.login,
      required this.contrasena,
      required this.permOS});

  User.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    login = json['login'];
    contrasena = json['contrasena'];
    permOS = json['permOS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUsuario'] = idUsuario;
    data['nombre'] = nombre;
    data['apellido'] = apellido;
    data['login'] = login;
    data['contrasena'] = contrasena;
    data['permOS'] = permOS;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nombre': nombre,
      'apellido': apellido,
      'login': login,
      'contrasena': contrasena,
      'permOS': permOS,
    };
  }
}
