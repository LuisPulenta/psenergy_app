import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/helpers/constants.dart';
import 'package:psenergy_app/helpers/db_helper.dart';
import 'package:psenergy_app/models/ControlDePozoEMBLLE%20.dart';
import 'package:psenergy_app/models/area.dart';
import 'package:psenergy_app/models/bateria.dart';
import 'package:psenergy_app/models/pozo.dart';
import 'package:psenergy_app/models/pozoscontrole.dart';
import 'package:psenergy_app/models/pozosformula.dart';
import 'package:psenergy_app/models/response.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/models/usuario.dart';
import 'package:psenergy_app/models/yacimiento.dart';
import 'package:psenergy_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Usuario> _usuariosApi = [];
  List<Usuario> _usuarios = [];
  List<Area> _areasApi = [];
  List<Area> _areas = [];
  List<Yacimiento> _yacimientosApi = [];
  List<Yacimiento> _yacimientos = [];
  List<Bateria> _bateriasApi = [];
  List<Bateria> _baterias = [];
  List<Pozo> _pozosApi = [];
  List<Pozo> _pozos = [];
  List<PozosFormula> _pozosformulasApi = [];
  List<PozosFormula> _pozosformulas = [];
  List<PozosControle> _pozoscontrolesApi = [];
  List<PozosControle> _pozoscontroles = [];
  List<ControlDePozoEMBLLE> _pozosemblles = [];

  Usuario _usuarioLogueado = Usuario(
      idUser: 0,
      codigo: '',
      apellidonombre: '',
      usrlogin: '',
      usrcontrasena: '',
      perfil: 0,
      habilitadoWeb: 0,
      causanteC: '',
      habilitaPaqueteria: 0);

  String _email = 'arivas';
  String _emailError = '';
  bool _emailShowError = false;
  bool _hayInternet = false;

  String _password = 'ari193';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;

  bool _passwordShow = false;

  bool _showLoader = false;

  Color colorUsuarios = Color(0xff9e9e9e);
  Color colorAreas = Color(0xff9e9e9e);
  Color colorYacimientos = Color(0xff9e9e9e);
  Color colorBaterias = Color(0xff9e9e9e);
  Color colorPozos = Color(0xff9e9e9e);
  Color colorPozosFormulas = Color(0xff9e9e9e);
  Color colorPozosControles = Color(0xff9e9e9e);
  Color colorControlDePozoEMBLLE = Color(0xff9e9e9e);

  @override
  void initState() {
    super.initState();
    _getUsuarios();
    _getAreas();
    _getYacimientos();
    _getBaterias();
    _getPozos();
    _getPozosFormulas();
    _getPozosControles();
    //_getControlDePozoEMBLLE();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd3a735),
      body: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 60),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(
                      (0xffe9dac2),
                    ),
                    Color(
                      (0xffd3a735),
                    ),
                  ],
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PS",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        Text(
                          "Energy",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "v.1.2.1",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Container(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Usuarios:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorUsuarios,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Areas:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorAreas,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Yacimientos:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorYacimientos,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Baterías:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorBaterias,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Pozos:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorPozos,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Pozos Fórmulas:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorPozosFormulas,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Pozos Controles:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorPozosControles,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "ControlDePozoEMBLLE:",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.radio_button_checked,
                      size: 12,
                      color: colorControlDePozoEMBLLE,
                    ),
                  ],
                ),
              ],
            ),
          )),
          Transform.translate(
            offset: Offset(0, -60),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 15,
                  margin: EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _showEmail(),
                        _showPassword(),
                        SizedBox(
                          height: 10,
                        ),
                        //_showRememberme(),
                        _showButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: _showLoader
                ? LoaderComponent(text: 'Por favor espere...')
                : Container(),
          )
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      width: 300,
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Usuario...',
            labelText: 'Usuario',
            errorText: _emailShowError ? _emailError : null,
            prefixIcon: Icon(Icons.person),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _showPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Contraseña...',
            labelText: 'Contraseña',
            errorText: _passwordShowError ? _passwordError : null,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: _passwordShow
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _passwordShow = !_passwordShow;
                });
              },
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  // _showRememberme() {
  //   return CheckboxListTile(
  //     title: Text('Recordarme:'),
  //     value: _rememberme,
  //     onChanged: (value) {
  //       setState(() {
  //         _rememberme = value!;
  //       });
  //     },
  //   );
  // }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Iniciar Sesión'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF9a6a2e),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _login(),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      _passwordShow = false;
    });

    if (!validateFields()) {
      return;
    }

    List<Usuario> filteredUsuario = [];
    for (var usuario in _usuarios) {
      if (usuario.usrlogin.toLowerCase() == (_email.toLowerCase()) &&
          usuario.usrcontrasena.toLowerCase() == (_password.toLowerCase())) {
        filteredUsuario.add(usuario);
      }
    }

    if (filteredUsuario.length == 0) {
      setState(() {
        _passwordShowError = true;
        _passwordError = 'Usuario o contraseña incorrectos';
      });
      return;
    }

    _usuarioLogueado = filteredUsuario[0];

    // if (_rememberme) {
    //   _storeUser(_usuarioLogueado);
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('conectadodesde', DateTime.now().toString());
    await prefs.setString(
        'validohasta', DateTime.now().add(new Duration(hours: 12)).toString());
    await prefs.setString('ultimaactualizacion', DateTime.now().toString());

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  user: _usuarioLogueado,
                  areas: _areas,
                  yacimientos: _yacimientos,
                  baterias: _baterias,
                  pozos: _pozos,
                  pozosformulas: _pozosformulas,
                  pozoscontroles: _pozoscontroles,
                )));
  }

  bool validateFields() {
    bool isValid = true;

    if (_email.isEmpty) {
      isValid = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar tu Usuario';
    } else {
      _emailShowError = false;
    }

    if (_password.isEmpty) {
      isValid = false;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar tu Contraseña';
    } else {
      _passwordShowError = false;
    }

    setState(() {});

    return isValid;
  }

  void _storeUser(String body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRemembered', true);
    await prefs.setString('userBody', body);
    await prefs.setString('date', DateTime.now().toString());
  }

  Future<Null> _getUsuarios() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getUsuarios();

      if (response.isSuccess) {
        _usuariosApi = response.result;
        _usuariosApi.sort((a, b) {
          return a.idUser
              .toString()
              .toLowerCase()
              .compareTo(b.idUser.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaUsuarios();
    return;
  }

  void _getTablaUsuarios() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'usuarios.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE usuarios(idUser INTEGER PRIMARY KEY, codigo TEXT, apellidonombre TEXT, usrlogin TEXT, usrcontrasena TEXT,perfil  INTEGER,  habilitadoWeb INTEGER, causanteC TEXT, habilitaPaqueteria INTEGER)",
        );
      },
      version: 1,
    );

    Future<void> insertUsuario(Usuario usuario) async {
      final Database db = await database;
      await db.insert(
        'usuarios',
        usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertUsuarios() async {
      if (_usuariosApi.length > 0) {
        _usuariosApi.forEach((element) {
          insertUsuario(element);
        });
      }
    }

    Future<List<Usuario>> _getUsuariosSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('usuarios');
      return List.generate(
        maps.length,
        (i) {
          return Usuario(
            idUser: maps[i]['idUser'],
            codigo: maps[i]['codigo'],
            apellidonombre: maps[i]['apellidonombre'],
            usrlogin: maps[i]['usrlogin'],
            usrcontrasena: maps[i]['usrcontrasena'],
            perfil: maps[i]['perfil'],
            habilitadoWeb: maps[i]['habilitadoWeb'],
            causanteC: maps[i]['causanteC'],
            habilitaPaqueteria: maps[i]['habilitaPaqueteria'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertUsuarios();
    }

    _usuarios = await _getUsuariosSQLite();
    //_usuarios = await DBUsuarios.usuarios();

    if (_usuarios.length > 0) {
      setState(() {
        colorUsuarios = Colors.green;
      });
    }
  }

  Future<Null> _getAreas() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getAreas();

      if (response.isSuccess) {
        _areasApi = response.result;
        _areasApi.sort((a, b) {
          return a.nombrearea
              .toString()
              .toLowerCase()
              .compareTo(b.nombrearea.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaAreas();
    return;
  }

  void _getTablaAreas() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'areas.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE areas(nombrearea TEXT PRIMARY KEY)",
        );
      },
      version: 1,
    );

    Future<void> insertArea(Area area) async {
      final Database db = await database;
      await db.insert(
        'areas',
        area.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertAreas() async {
      if (_areasApi.length > 0) {
        _areasApi.forEach((element) {
          insertArea(element);
        });
      }
    }

    Future<List<Area>> _getAreasSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('areas');
      return List.generate(
        maps.length,
        (i) {
          return Area(
            nombrearea: maps[i]['nombrearea'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertAreas();
    }

    _areas = await _getAreasSQLite();

    if (_areas.length > 0) {
      setState(() {
        colorAreas = Colors.green;
      });
    }
  }

  Future<Null> _getYacimientos() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getYacimientos();

      if (response.isSuccess) {
        _yacimientosApi = response.result;
        _yacimientosApi.sort((a, b) {
          return a.nombreyacimiento
              .toString()
              .toLowerCase()
              .compareTo(b.nombreyacimiento.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaYacimientos();
    return;
  }

  void _getTablaYacimientos() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'yacimientos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE yacimientos(nombreyacimiento TEXT PRIMARY KEY,fechaalta TEXT,area TEXT,activo INTEGER)",
        );
      },
      version: 1,
    );

    Future<void> insertYacimiento(Yacimiento yacimiento) async {
      final Database db = await database;
      await db.insert(
        'yacimientos',
        yacimiento.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertYacimientos() async {
      if (_yacimientosApi.length > 0) {
        _yacimientosApi.forEach((element) {
          insertYacimiento(element);
        });
      }
    }

    Future<List<Yacimiento>> _getYacimientosSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('yacimientos');
      return List.generate(
        maps.length,
        (i) {
          return Yacimiento(
            nombreyacimiento: maps[i]['nombreyacimiento'],
            fechaalta: maps[i]['fechaalta'],
            area: maps[i]['area'],
            activo: maps[i]['activo'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertYacimientos();
    }

    _yacimientos = await _getYacimientosSQLite();

    if (_yacimientos.length > 0) {
      setState(() {
        colorYacimientos = Colors.green;
      });
    }
  }

  Future<Null> _getBaterias() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getBaterias();

      if (response.isSuccess) {
        _bateriasApi = response.result;
        _bateriasApi.sort((a, b) {
          return a.descripcion
              .toString()
              .toLowerCase()
              .compareTo(b.descripcion.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaBaterias();
    return;
  }

  void _getTablaBaterias() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'baterias.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE baterias(codigobateria TEXT PRIMARY KEY,descripcion TEXT, fechaalta TEXT,activa INTEGER,nombreyacimiento TEXT)",
        );
      },
      version: 1,
    );

    Future<void> insertBateria(Bateria bateria) async {
      final Database db = await database;
      await db.insert(
        'baterias',
        bateria.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertBaterias() async {
      if (_bateriasApi.length > 0) {
        _bateriasApi.forEach((element) {
          insertBateria(element);
        });
      }
    }

    Future<List<Bateria>> _getBateriasSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('baterias');
      return List.generate(
        maps.length,
        (i) {
          return Bateria(
            codigobateria: maps[i]['codigobateria'],
            descripcion: maps[i]['descripcion'],
            fechaalta: maps[i]['fechaalta'],
            activa: maps[i]['activa'],
            nombreyacimiento: maps[i]['nombreyacimiento'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertBaterias();
    }

    _baterias = await _getBateriasSQLite();

    if (_baterias.length > 0) {
      setState(() {
        colorBaterias = Colors.green;
      });
    }
  }

  Future<Null> _getPozos() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getPozos();

      if (response.isSuccess) {
        _pozosApi = response.result;
        _pozosApi.sort((a, b) {
          return a.codigopozo
              .toString()
              .toLowerCase()
              .compareTo(b.codigopozo.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaPozos();

    return;
  }

  void _getTablaPozos() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'pozos.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pozos(codigopozo TEXT PRIMARY KEY,codigobateria TEXT, descripcion TEXT,fechaalta TEXT,activo INTEGER,ultimalectura TEXT,latitud TEXT, longitud TEXT,qrcode TEXT,observaciones TEXT,tipopozo TEXT,sistemaExtraccion TEXT,cuenca TEXT, idProvincia INTEGER,cota DOUBLE, profundidad DOUBLE, vidaUtil DOUBLE)",
        );
      },
      version: 1,
    );

    Future<void> insertPozo(Pozo pozo) async {
      final Database db = await database;
      await db.insert(
        'pozos',
        pozo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertPozos() async {
      if (_pozosApi.length > 0) {
        _pozosApi.forEach((element) {
          insertPozo(element);
        });
      }
    }

    Future<List<Pozo>> _getPozosSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('pozos');
      return List.generate(
        maps.length,
        (i) {
          return Pozo(
            codigopozo: maps[i]['codigopozo'],
            codigobateria: maps[i]['codigobateria'],
            descripcion: maps[i]['descripcion'],
            fechaalta: maps[i]['fechaalta'],
            activo: maps[i]['activo'],
            ultimalectura: maps[i]['ultimalectura'],
            latitud: maps[i]['latitud'],
            longitud: maps[i]['longitud'],
            qrcode: maps[i]['qrcode'],
            observaciones: maps[i]['observaciones'],
            tipopozo: maps[i]['tipopozo'],
            sistemaExtraccion: maps[i]['sistemaExtraccion'],
            cuenca: maps[i]['cuenca'],
            idProvincia: maps[i]['idProvincia'],
            cota: maps[i]['cota'],
            profundidad: maps[i]['profundidad'],
            vidaUtil: maps[i]['vidaUtil'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertPozos();
    }

    _pozos = await _getPozosSQLite();

    if (_pozos.length > 0) {
      setState(() {
        colorPozos = Colors.green;
      });
    }
  }

  Future<Null> _getPozosFormulas() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getPozosFormulas();

      if (response.isSuccess) {
        _pozosformulasApi = response.result;
        _pozosformulasApi.sort((a, b) {
          return a.idformula
              .toString()
              .toLowerCase()
              .compareTo(b.idformula.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaPozosFormulas();

    return;
  }

  void _getTablaPozosFormulas() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'pozosformulas.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pozosformulas(idformula INTEGER PRIMARY KEY,tiposistema TEXT, tipodatos TEXT,rangodesde INTEGER,rangohasta INTEGER)",
        );
      },
      version: 1,
    );

    Future<void> insertPozoFormula(PozosFormula pozosformula) async {
      final Database db = await database;
      await db.insert(
        'pozosformulas',
        pozosformula.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertPozosFormulas() async {
      if (_pozosformulasApi.length > 0) {
        _pozosformulasApi.forEach((element) {
          insertPozoFormula(element);
        });
      }
    }

    Future<List<PozosFormula>> _getPozosFormulasSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('pozosformulas');
      return List.generate(
        maps.length,
        (i) {
          return PozosFormula(
            idformula: maps[i]['idformula'],
            tiposistema: maps[i]['tiposistema'],
            tipodatos: maps[i]['tipodatos'],
            rangodesde: maps[i]['rangodesde'],
            rangohasta: maps[i]['rangohasta'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertPozosFormulas();
    }

    _pozosformulas = await _getPozosFormulasSQLite();

    if (_pozosformulas.length > 0) {
      setState(() {
        colorPozosFormulas = Colors.green;
      });
    }
  }

  Future<Null> _getPozosControles() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getPozosControles();

      if (response.isSuccess) {
        _pozoscontrolesApi = response.result;
        _pozoscontrolesApi.sort((a, b) {
          return a.idcontrol
              .toString()
              .toLowerCase()
              .compareTo(b.idcontrol.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaPozosControles();

    return;
  }

  void _getTablaPozosControles() async {
    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'pozoscontroles.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pozoscontroles(idcontrol INTEGER PRIMARY KEY,codigopozo TEXT, idformula INTEGER,alarma TEXT,obligatorio TEXT)",
        );
      },
      version: 1,
    );

    Future<void> insertPozoControle(PozosControle pozocontrole) async {
      final Database db = await database;
      await db.insert(
        'pozoscontroles',
        pozocontrole.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    void _insertPozosControles() async {
      if (_pozoscontrolesApi.length > 0) {
        _pozoscontrolesApi.forEach((element) {
          insertPozoControle(element);
        });
      }
    }

    Future<List<PozosControle>> _getPozosControlesSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('pozoscontroles');
      return List.generate(
        maps.length,
        (i) {
          return PozosControle(
            idcontrol: maps[i]['idcontrol'],
            codigopozo: maps[i]['codigopozo'],
            idformula: maps[i]['idformula'],
            alarma: maps[i]['alarma'],
            obligatorio: maps[i]['obligatorio'],
          );
        },
      );
    }

    if (_hayInternet) {
      _insertPozosControles();
    }

    _pozoscontroles = await _getPozosControlesSQLite();

    if (_pozoscontroles.length > 0) {
      setState(() {
        colorPozosControles = Colors.green;
      });

      setState(() {
        _showLoader = false;
      });
    }
  }

  Future<Null> _getControlDePozoEMBLLE() async {
    _getTablaControlDePozoEMBLLES();
    return;
  }

  void _getTablaControlDePozoEMBLLES() async {
    final database = openDatabase(
      p.join(await getDatabasesPath(), 'pozoemb.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pozoemb(idControlPozo INTEGER PRIMARY KEY,bateria TEXT,pozo TEXT,fecha TEXT,ql INTEGER,qo INTEGER,qw INTEGER,qg INTEGER,wcLibre INTEGER,wcEmulc INTEGER,wcTotal INTEGER,sales INTEGER,gor INTEGER,t INTEGER,validacionControl TEXT,prTbg INTEGER,prLinea INTEGER,prCsg INTEGER,regimenOperacion INTEGER,aibCarrera INTEGER,bespip INTEGER,pcpTorque INTEGER,observaciones TEXT,validadoSupervisor INTEGER,userIdInput INTEGERuserIDValida INTEGER,caudalInstantaneo DOUBLE,caudalMedio DOUBLE,lecturaAcumulada INTEGER,presionBDP INTEGER,presionAntFiltro INTEGER,presionEC INTEGER,ingresoDatos TEXT,reenvio INTEGER,muestra TEXT,fechaCarga TEXT,idUserValidaMuestra INTEGER,idUserImputSoft INTEGER,volt INTEGER,amper INTEGER,temp INTEGER,fechaCargaAPP TEXT)",
        );
      },
      version: 1,
    );

    Future<List<ControlDePozoEMBLLE>> _getPozosEmbllesSQLite() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('pozoemb');
      return List.generate(
        maps.length,
        (i) {
          return ControlDePozoEMBLLE(
              idControlPozo: maps[i]['idControlPozo'],
              bateria: maps[i]['bateria'],
              pozo: maps[i]['pozo'],
              fecha: maps[i]['fecha'],
              ql: maps[i]['ql'],
              qo: maps[i]['qo'],
              qw: maps[i]['qw'],
              qg: maps[i]['qg'],
              wcLibre: maps[i]['wcLibre'],
              wcEmulc: maps[i]['wcEmulc'],
              wcTotal: maps[i]['wcTotal'],
              sales: maps[i]['sales'],
              gor: maps[i]['gor'],
              t: maps[i]['t'],
              validacionControl: maps[i]['validacionControl'],
              prTbg: maps[i]['prTbg'],
              prLinea: maps[i]['prLinea'],
              prCsg: maps[i]['prCsg'],
              regimenOperacion: maps[i]['regimenOperacion'],
              aibCarrera: maps[i]['aibCarrera'],
              bespip: maps[i]['bespip'],
              pcpTorque: maps[i]['pcpTorque'],
              observaciones: maps[i]['observaciones'],
              validadoSupervisor: maps[i]['validadoSupervisor'],
              userIdInput: maps[i]['userIdInput'],
              userIDValida: maps[i]['userIDValida'],
              caudalInstantaneo: maps[i]['caudalInstantaneo'],
              caudalMedio: maps[i]['caudalMedio'],
              lecturaAcumulada: maps[i]['lecturaAcumulada'],
              presionBDP: maps[i]['presionBDP'],
              presionAntFiltro: maps[i]['presionAntFiltro'],
              presionEC: maps[i]['presionEC'],
              ingresoDatos: maps[i]['ingresoDatos'],
              reenvio: maps[i]['reenvio'],
              muestra: maps[i]['muestra'],
              fechaCarga: maps[i]['fechaCarga'],
              idUserValidaMuestra: maps[i]['idUserValidaMuestra'],
              idUserImputSoft: maps[i]['idUserImputSoft'],
              volt: maps[i]['volt'],
              amper: maps[i]['amper'],
              temp: maps[i]['temp'],
              fechaCargaAPP: maps[i]['fechaCargaAPP']);
        },
      );
    }

    _pozosemblles = await _getPozosEmbllesSQLite();

    if (_pozosemblles.length > 0) {
      setState(() {
        colorControlDePozoEMBLLE = Colors.green;
      });

      setState(() {
        _showLoader = false;
      });
    }
  }
}
