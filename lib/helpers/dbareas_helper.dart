import 'package:psenergy_app/models/area.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBAreas {
  static Future<Database> _openDBAreas() async {
    return openDatabase(join(await getDatabasesPath(), 'areas.db'),
        onCreate: (db, version) {
      return db.execute(
         "CREATE TABLE areas(nombrearea TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insertArea(Area area) async {
    Database database = await _openDBAreas();
    return database.insert("areas", area.toMap());
  }

  static Future<int> delete() async {
    Database database = await _openDBAreas();
    return database.delete("areas");
  }

  static Future<List<Area>> areas() async {
    Database database = await _openDBAreas();
    final List<Map<String, dynamic>> areasMap =
        await database.query("areas");
    return List.generate(
        areasMap.length,
        (i) => Area(
              nombrearea: areasMap[i]['nombrearea'],
            ));
  }
}
