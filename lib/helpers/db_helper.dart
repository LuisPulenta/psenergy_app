import 'package:psenergy_app/models/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUsuarios {
  static Future<Database> _openDBUsuarios() async {
    return openDatabase(join(await getDatabasesPath(), 'usuarios.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE usuarios(idUser INTEGER PRIMARY KEY, codigo TEXT, apellidonombre TEXT, usrlogin TEXT, usrcontrasena TEXT,perfil  INTEGER,  habilitadoWeb INTEGER, causanteC TEXT, habilitaPaqueteria INTEGER)",
      );
    }, version: 1);
  }

  static Future<int> insertUsuario(Usuario usuario) async {
    Database database = await _openDBUsuarios();
    return database.insert("usuarios", usuario.toMap());
  }

  static Future<List<Usuario>> usuarios() async {
    Database database = await _openDBUsuarios();
    final List<Map<String, dynamic>> usuariosMap =
        await database.query("usuarios");
    return List.generate(
        usuariosMap.length,
        (i) => Usuario(
              idUser: usuariosMap[i]['idUser'],
              codigo: usuariosMap[i]['codigo'],
              apellidonombre: usuariosMap[i]['apellidonombre'],
              usrlogin: usuariosMap[i]['usrlogin'],
              usrcontrasena: usuariosMap[i]['usrcontrasena'],
              perfil: usuariosMap[i]['perfil'],
              habilitadoWeb: usuariosMap[i]['habilitadoWeb'],
              causanteC: usuariosMap[i]['causanteC'],
              habilitaPaqueteria: usuariosMap[i]['habilitaPaqueteria'],
            ));
  }
}
