import 'package:psenergy_app/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBAlarmas {
  static Future<Database> _openDBAlarmas() async {
    return openDatabase(join(await getDatabasesPath(), 'alarmas.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE alarmas(idalarma INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,fechacarga TEXT,provieneidcontrol INTEGER,pozo TEXT,bateria TEXT, idusuariocarga INTEGER, idusuarioapp INTEGER, fechaejecutada TEXT, nuevoidcontrol INTEGER, observacion TEXT, tag INTEGER)",
      );
    }, version: 2);
  }

  static Future<int> insertAlarma(Alarma alarma) async {
    Database database = await _openDBAlarmas();
    return database.insert("alarmas", alarma.toMap());
  }

  static Future<int> deleteall() async {
    Database database = await _openDBAlarmas();
    return database.delete("alarmas");
  }

  static Future<int> delete(Alarma alarma) async {
    Database database = await _openDBAlarmas();
    return database
        .delete("alarmas", where: "idalarma = ?", whereArgs: [alarma.idalarma]);
  }

  static Future<int> update(Alarma alarma) async {
    Database database = await _openDBAlarmas();
    return database.update("alarmas", alarma.toMap(),
        where: "idalarma = ?", whereArgs: [alarma.idalarma]);
  }

  static Future<List<Alarma>> alarma() async {
    Database database = await _openDBAlarmas();
    final List<Map<String, dynamic>> alarma = await database.query("alarmas");
    return List.generate(
        alarma.length,
        (i) => Alarma(
              idalarma: alarma[i]['idalarma'],
              fechacarga: alarma[i]['fechacarga'],
              provieneidcontrol: alarma[i]['provieneidcontrol'],
              pozo: alarma[i]['pozo'],
              bateria: alarma[i]['bateria'],
              idusuariocarga: alarma[i]['idusuariocarga'],
              idusuarioapp: alarma[i]['idusuarioapp'],
              fechaejecutada: alarma[i]['fechaejecutada'],
              nuevoidcontrol: alarma[i]['nuevoidcontrol'],
              observacion: alarma[i]['observacion'],
              tag: alarma[i]['tag'],
            ));
  }
}
