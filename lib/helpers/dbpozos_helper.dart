import 'package:psenergy_app/models/pozo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBPozos {
  static Future<Database> _openDBPozos() async {
    return openDatabase(join(await getDatabasesPath(), 'pozos.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE pozos(codigopozo TEXT,codigobateria TEXT, descripcion TEXT,fechaalta TEXT,activo INTEGER,ultimalectura TEXT,latitud TEXT, longitud TEXT,qrcode TEXT,observaciones TEXT,tipopozo TEXT,sistemaExtraccion TEXT,cuenca TEXT, idProvincia INTEGER,cota DOUBLE, profundidad DOUBLE, vidaUtil DOUBLE)",
      );
    }, version: 1);
  }

  static Future<int> insertPozo(Pozo pozo) async {
    Database database = await _openDBPozos();
    return database.insert("pozos", pozo.toMap());
  }

  static Future<int> delete() async {
    Database database = await _openDBPozos();
    return database.delete("pozos");
  }

  static Future<List<Pozo>> pozos() async {
    Database database = await _openDBPozos();
    final List<Map<String, dynamic>> pozosMap = await database.query("pozos");
    return List.generate(
        pozosMap.length,
        (i) => Pozo(
              codigopozo: pozosMap[i]['codigopozo'],
              codigobateria: pozosMap[i]['codigobateria'],
              descripcion: pozosMap[i]['descripcion'],
              fechaalta: pozosMap[i]['fechaalta'],
              activo: pozosMap[i]['activo'],
              ultimalectura: pozosMap[i]['ultimalectura'],
              latitud: pozosMap[i]['latitud'],
              longitud: pozosMap[i]['longitud'],
              qrcode: pozosMap[i]['qrcode'],
              observaciones: pozosMap[i]['observaciones'],
              tipopozo: pozosMap[i]['tipopozo'],
              sistemaExtraccion: pozosMap[i]['sistemaExtraccion'],
              cuenca: pozosMap[i]['cuenca'],
              idProvincia: pozosMap[i]['idProvincia'],
              cota: pozosMap[i]['cota'],
              profundidad: pozosMap[i]['profundidad'],
              vidaUtil: pozosMap[i]['vidaUtil'],
            ));
  }
}
