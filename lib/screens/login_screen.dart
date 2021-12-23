import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/helpers/constants.dart';
import 'package:psenergy_app/models/area.dart';
import 'package:psenergy_app/models/bateria.dart';
import 'package:psenergy_app/models/pozo.dart';
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

  @override
  void initState() {
    super.initState();
    _getUsuarios();
    _getAreas();
    _getYacimientos();
    _getBaterias();
    _getPozos();
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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color(0xFF9a6a2e);
                }),
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

    setState(() {
      _showLoader = false;
    });

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
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        _showLoader = true;
      });

      Response response = await ApiHelper.getUsuarios();

      setState(() {
        _showLoader = false;
      });

      if (response.isSuccess) {
        _usuariosApi = response.result;
        _usuariosApi.sort((a, b) {
          return a.apellidonombre
              .toString()
              .toLowerCase()
              .compareTo(b.apellidonombre.toString().toLowerCase());
        });
        _hayInternet = true;
        await showAlertDialog(
            context: context,
            title: 'Listo!',
            message: "Se actualizó la base de datos de usuarios.",
            actions: <AlertDialogAction>[
              AlertDialogAction(key: null, label: 'OK'),
            ]);
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
      _usuariosApi.forEach((element) {
        insertUsuario(element);
      });
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
  }

  Future<Null> _getAreas() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        _showLoader = true;
      });

      Response response = await ApiHelper.getAreas();

      setState(() {
        _showLoader = false;
      });

      if (response.isSuccess) {
        _areasApi = response.result;
        _areasApi.sort((a, b) {
          return a.nombrearea
              .toString()
              .toLowerCase()
              .compareTo(b.nombrearea.toString().toLowerCase());
        });
        _hayInternet = true;
        // await showAlertDialog(
        //     context: context,
        //     title: 'Listo!',
        //     message: "Se actualizó la base de datos de áreas.",
        //     actions: <AlertDialogAction>[
        //       AlertDialogAction(key: null, label: 'OK'),
        //     ]);
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
      _areasApi.forEach((element) {
        insertArea(element);
      });
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
  }

  Future<Null> _getYacimientos() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        _showLoader = true;
      });

      Response response = await ApiHelper.getYacimientos();

      setState(() {
        _showLoader = false;
      });

      if (response.isSuccess) {
        _yacimientosApi = response.result;
        _yacimientosApi.sort((a, b) {
          return a.nombreyacimiento
              .toString()
              .toLowerCase()
              .compareTo(b.nombreyacimiento.toString().toLowerCase());
        });
        _hayInternet = true;
        // await showAlertDialog(
        //     context: context,
        //     title: 'Listo!',
        //     message: "Se actualizó la base de datos de yacimientos.",
        //     actions: <AlertDialogAction>[
        //       AlertDialogAction(key: null, label: 'OK'),
        //     ]);
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
      _yacimientosApi.forEach((element) {
        insertYacimiento(element);
      });
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
  }

  Future<Null> _getBaterias() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        _showLoader = true;
      });

      Response response = await ApiHelper.getBaterias();

      setState(() {
        _showLoader = false;
      });

      if (response.isSuccess) {
        _bateriasApi = response.result;
        _bateriasApi.sort((a, b) {
          return a.descripcion
              .toString()
              .toLowerCase()
              .compareTo(b.descripcion.toString().toLowerCase());
        });
        _hayInternet = true;
        // await showAlertDialog(
        //     context: context,
        //     title: 'Listo!',
        //     message: "Se actualizó la base de datos de baterías.",
        //     actions: <AlertDialogAction>[
        //       AlertDialogAction(key: null, label: 'OK'),
        //     ]);
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
      _bateriasApi.forEach((element) {
        insertBateria(element);
      });
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
  }

  Future<Null> _getPozos() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        _showLoader = true;
      });

      Response response = await ApiHelper.getPozos();

      setState(() {
        _showLoader = false;
      });

      if (response.isSuccess) {
        _pozosApi = response.result;
        _pozosApi.sort((a, b) {
          return a.codigopozo
              .toString()
              .toLowerCase()
              .compareTo(b.codigopozo.toString().toLowerCase());
        });
        _hayInternet = true;
        // await showAlertDialog(
        //     context: context,
        //     title: 'Listo!',
        //     message: "Se actualizó la base de datos de pozos.",
        //     actions: <AlertDialogAction>[
        //       AlertDialogAction(key: null, label: 'OK'),
        //     ]);
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
      _pozosApi.forEach((element) {
        insertPozo(element);
      });
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
  }
}
