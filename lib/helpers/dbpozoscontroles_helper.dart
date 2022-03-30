import 'package:psenergy_app/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBPozosControles {
  static Future<Database> _openDBPozosControles() async {
    return openDatabase(join(await getDatabasesPath(), 'pozoscontroles.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE pozoscontroles(idcontrol INTEGER,codigopozo TEXT, idformula INTEGER,alarma TEXT,obligatorio TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insertPozoControl(PozosControle pozocontrol) async {
    Database database = await _openDBPozosControles();
    return database.insert("pozoscontroles", pozocontrol.toMap());
  }

  static Future<int> delete() async {
    Database database = await _openDBPozosControles();
    return database.delete("pozoscontroles");
  }

  static Future<List<PozosControle>> pozoscontroles() async {
    Database database = await _openDBPozosControles();
    final List<Map<String, dynamic>> pozoscontrolesMap =
        await database.query("pozoscontroles");
    return List.generate(
        pozoscontrolesMap.length,
        (i) => PozosControle(
              idcontrol: pozoscontrolesMap[i]['idcontrol'],
              codigopozo: pozoscontrolesMap[i]['codigopozo'],
              idformula: pozoscontrolesMap[i]['idformula'],
              alarma: pozoscontrolesMap[i]['alarma'],
              obligatorio: pozoscontrolesMap[i]['obligatorio'],
            ));
  }
}
