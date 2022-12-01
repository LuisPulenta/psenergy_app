import 'package:psenergy_app/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBYacimientos {
  static Future<Database> _openDBYacimientos() async {
    return openDatabase(join(await getDatabasesPath(), 'yacimientos.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE yacimientos(nombreyacimiento TEXT,fechaalta TEXT,area TEXT,activo INTEGER)",
      );
    }, version: 2);
  }

  static Future<int> insertYacimiento(Yacimiento yacimiento) async {
    Database database = await _openDBYacimientos();
    return database.insert("yacimientos", yacimiento.toMap());
  }

  static Future<int> delete() async {
    Database database = await _openDBYacimientos();
    return database.delete("yacimientos");
  }

  static Future<List<Yacimiento>> yacimientos() async {
    Database database = await _openDBYacimientos();
    final List<Map<String, dynamic>> yacimientosMap =
        await database.query("yacimientos");
    return List.generate(
        yacimientosMap.length,
        (i) => Yacimiento(
              nombreyacimiento: yacimientosMap[i]['nombreyacimiento'],
              fechaalta: yacimientosMap[i]['fechaalta'],
              area: yacimientosMap[i]['area'],
              activo: yacimientosMap[i]['activo'],
            ));
  }
}
