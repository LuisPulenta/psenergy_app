import 'package:psenergy_app/models/bateria.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBBaterias {
  static Future<Database> _openDBBaterias() async {
    return openDatabase(join(await getDatabasesPath(), 'baterias.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE baterias(codigobateria TEXT,descripcion TEXT, fechaalta TEXT,activa INTEGER,nombreyacimiento TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insertBateria(Bateria bateria) async {
    Database database = await _openDBBaterias();
    return database.insert("baterias", bateria.toMap());
  }

  static Future<int> delete() async {
    Database database = await _openDBBaterias();
    return database.delete("baterias");
  }

  static Future<List<Bateria>> baterias() async {
    Database database = await _openDBBaterias();
    final List<Map<String, dynamic>> bateriasMap =
        await database.query("baterias");
    return List.generate(
        bateriasMap.length,
        (i) => Bateria(
              codigobateria: bateriasMap[i]['codigobateria'],
              descripcion: bateriasMap[i]['descripcion'],
              fechaalta: bateriasMap[i]['fechaalta'],
              activa: bateriasMap[i]['activa'],
              nombreyacimiento: bateriasMap[i]['nombreyacimiento'],
            ));
  }
}
