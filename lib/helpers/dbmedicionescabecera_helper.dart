import 'package:psenergy_app/models/medicioncabecera.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBMedicionesCabecera {
  static Future<Database> _openDBMedicionesCab() async {
    return openDatabase(join(await getDatabasesPath(), 'medicionescabecera.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE medicionescabecera(idControlPozo INTEGER PRIMARY KEY,bateria TEXT,pozo TEXT,fecha TEXT,ql INTEGER,qo INTEGER,qw INTEGER,qg INTEGER,wcLibre INTEGER,wcEmulc INTEGER,wcTotal INTEGER,sales INTEGER,gor INTEGER,t INTEGER,validacionControl TEXT,prTbg INTEGER,prLinea INTEGER,prCsg INTEGER,regimenOperacion INTEGER,aibCarrera INTEGER,bespip INTEGER,pcpTorque INTEGER,observaciones TEXT,validadoSupervisor INTEGER,userIdInput INTEGERuserIDValida INTEGER,caudalInstantaneo DOUBLE,caudalMedio DOUBLE,lecturaAcumulada INTEGER,presionBDP INTEGER,presionAntFiltro INTEGER,presionEC INTEGER,ingresoDatos TEXT,reenvio INTEGER,muestra TEXT,fechaCarga TEXT,idUserValidaMuestra INTEGER,idUserImputSoft INTEGER,volt INTEGER,amper INTEGER,temp INTEGER,fechaCargaAPP TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insertMedicionCab(MedicionCabecera medicioncab) async {
    Database database = await _openDBMedicionesCab();
    return database.insert("medicionescabecera", medicioncab.toMap());
  }

  static Future<int> delete(MedicionCabecera medicioncab) async {
    Database database = await _openDBMedicionesCab();
    return database.delete("medicionescabecera",
        where: "idControlPozo = ?", whereArgs: [medicioncab.idControlPozo]);
  }

  static Future<int> update(MedicionCabecera medicioncab) async {
    Database database = await _openDBMedicionesCab();
    return database.update("medicionescabecera", medicioncab.toMap(),
        where: "idControlPozo = ?", whereArgs: [medicioncab.idControlPozo]);
  }

  static Future<List<MedicionCabecera>> medicionescabecera() async {
    Database database = await _openDBMedicionesCab();
    final List<Map<String, dynamic>> medicionescabMap =
        await database.query("medicionescabecera");
    return List.generate(
        medicionescabMap.length,
        (i) => MedicionCabecera(
              idControlPozo: medicionescabMap[i]['idControlPozo'],
              bateria: medicionescabMap[i]['bateria'],
              pozo: medicionescabMap[i]['pozo'],
              fecha: medicionescabMap[i]['fecha'],
              ql: medicionescabMap[i]['ql'],
              qo: medicionescabMap[i]['qo'],
              qw: medicionescabMap[i]['qw'],
              qg: medicionescabMap[i]['qg'],
              wcLibre: medicionescabMap[i]['wcLibre'],
              wcEmulc: medicionescabMap[i]['wcEmulc'],
              wcTotal: medicionescabMap[i]['wcTotal'],
              sales: medicionescabMap[i]['sales'],
              gor: medicionescabMap[i]['gor'],
              t: medicionescabMap[i]['t'],
              validacionControl: medicionescabMap[i]['validacionControl'],
              prTbg: medicionescabMap[i]['prTbg'],
              prLinea: medicionescabMap[i]['prLinea'],
              prCsg: medicionescabMap[i]['prCsg'],
              regimenOperacion: medicionescabMap[i]['regimenOperacion'],
              aibCarrera: medicionescabMap[i]['aibCarrera'],
              bespip: medicionescabMap[i]['bespip'],
              pcpTorque: medicionescabMap[i]['pcpTorque'],
              observaciones: medicionescabMap[i]['observaciones'],
              validadoSupervisor: medicionescabMap[i]['validadoSupervisor'],
              userIdInput: medicionescabMap[i]['userIdInput'],
              userIDValida: medicionescabMap[i]['userIDValida'],
              caudalInstantaneo: medicionescabMap[i]['caudalInstantaneo'],
              caudalMedio: medicionescabMap[i]['caudalMedio'],
              lecturaAcumulada: medicionescabMap[i]['lecturaAcumulada'],
              presionBDP: medicionescabMap[i]['presionBDP'],
              presionAntFiltro: medicionescabMap[i]['presionAntFiltro'],
              presionEC: medicionescabMap[i]['presionEC'],
              ingresoDatos: medicionescabMap[i]['ingresoDatos'],
              reenvio: medicionescabMap[i]['reenvio'],
              muestra: medicionescabMap[i]['muestra'],
              fechaCarga: medicionescabMap[i]['fechaCarga'],
              idUserValidaMuestra: medicionescabMap[i]['idUserValidaMuestra'],
              idUserImputSoft: medicionescabMap[i]['idUserImputSoft'],
              volt: medicionescabMap[i]['volt'],
              amper: medicionescabMap[i]['amper'],
              temp: medicionescabMap[i]['temp'],
              fechaCargaAPP: medicionescabMap[i]['fechaCargaAPP'],
            ));
  }
}
