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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['codigo'] = codigo;
    data['apellidonombre'] = apellidonombre;
    data['usrlogin'] = usrlogin;
    data['usrcontrasena'] = usrcontrasena;
    data['perfil'] = perfil;
    data['habilitadoWeb'] = habilitadoWeb;
    data['causanteC'] = causanteC;
    data['habilitaPaqueteria'] = habilitaPaqueteria;
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
