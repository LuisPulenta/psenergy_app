import 'package:psenergy_app/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBPozosFormulas {
  static Future<Database> _openDBPozosFormulas() async {
    return openDatabase(join(await getDatabasesPath(), 'pozosformulas.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE pozosformulas(idformula INTEGER,tiposistema TEXT, tipodatos TEXT,rangodesde INTEGER,rangohasta INTEGER)",
      );
    }, version: 1);
  }

  static Future<int> insertPozoFormula(PozosFormula pozoformula) async {
    Database database = await _openDBPozosFormulas();
    return database.insert("pozosformulas", pozoformula.toMap());
  }

  static Future<int> delete() async {
    Database database = await _openDBPozosFormulas();
    return database.delete("pozosformulas");
  }

  static Future<List<PozosFormula>> pozosformulas() async {
    Database database = await _openDBPozosFormulas();
    final List<Map<String, dynamic>> pozosformulasMap =
        await database.query("pozosformulas");
    return List.generate(
        pozosformulasMap.length,
        (i) => PozosFormula(
              idformula: pozosformulasMap[i]['idformula'],
              tiposistema: pozosformulasMap[i]['tiposistema'],
              tipodatos: pozosformulasMap[i]['tipodatos'],
              rangodesde: pozosformulasMap[i]['rangodesde'],
              rangohasta: pozosformulasMap[i]['rangohasta'],
            ));
  }
}
