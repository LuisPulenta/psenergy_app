class Usuario {
  int idUser = 0;
  String codigo = '';
  String apellidonombre = '';
  String usrlogin = '';
  String usrcontrasena = '';
  int perfil = 0;
  int habilitadoWeb = 0;
  String causanteC = '';
  int habilitaPaqueteria = 0;

  Usuario(
      {required this.idUser,
      required this.codigo,
      required this.apellidonombre,
      required this.usrlogin,
      required this.usrcontrasena,
      required this.perfil,
      required this.habilitadoWeb,
      required this.causanteC,
      required this.habilitaPaqueteria});

  Usuario.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    codigo = json['codigo'];
    apellidonombre = json['apellidonombre'];
    usrlogin = json['usrlogin'];
    usrcontrasena = json['usrcontrasena'];
    perfil = json['perfil'];
    habilitadoWeb = json['habilitadoWeb'];
    causanteC = json['causanteC'];
    habilitaPaqueteria = json['habilitaPaqueteria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['codigo'] = this.codigo;
    data['apellidonombre'] = this.apellidonombre;
    data['usrlogin'] = this.usrlogin;
    data['usrcontrasena'] = this.usrcontrasena;
    data['perfil'] = this.perfil;
    data['habilitadoWeb'] = this.habilitadoWeb;
    data['causanteC'] = this.causanteC;
    data['habilitaPaqueteria'] = this.habilitaPaqueteria;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'codigo': codigo,
      'apellidonombre': apellidonombre,
      'usrlogin': usrlogin,
      'usrcontrasena': usrcontrasena,
      'perfil': perfil,
      'habilitadoWeb': habilitadoWeb,
      'causanteC': causanteC,
      'habilitaPaqueteria': habilitaPaqueteria,
    };
  }
}
