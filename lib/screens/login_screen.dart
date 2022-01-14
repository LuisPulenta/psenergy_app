import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/helpers/constants.dart';
import 'package:psenergy_app/helpers/dbareas_helper.dart';
import 'package:psenergy_app/helpers/dbbaterias_helper.dart';
import 'package:psenergy_app/helpers/dbmedicionescabecera_helper.dart';
import 'package:psenergy_app/helpers/dbpozos_helper.dart';
import 'package:psenergy_app/helpers/dbpozoscontroles_helper.dart';
import 'package:psenergy_app/helpers/dbpozosformulas_helper.dart';
import 'package:psenergy_app/helpers/dbusuarios_helper.dart';
import 'package:psenergy_app/helpers/dbyacimientos_helper.dart';
import 'package:psenergy_app/models/area.dart';
import 'package:psenergy_app/models/bateria.dart';
import 'package:psenergy_app/models/medicioncabecera.dart';
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
  List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];

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

  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;
  bool _hayInternet = false;
  String _password = '';
  String _passwordError = '';
  bool _passwordShowError = false;
  bool _passwordShow = false;

  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _getUsuarios();
    // _getAreas();
    // _getYacimientos();
    // _getBaterias();
    // _getPozos();
    // _getPozosFormulas();
    // _getPozosControles();
    // _getMedicionesCab();
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
                          Constants.version,
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
      child: Column(
        children: [
          Row(
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
          SizedBox(
            height: 15,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     Expanded(
          //       child: ElevatedButton(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(Icons.delete),
          //             SizedBox(
          //               width: 20,
          //             ),
          //             Text(
          //               'Borrar mediciones locales',
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ],
          //         ),
          //         style: ElevatedButton.styleFrom(
          //           primary: Colors.red,
          //           minimumSize: Size(double.infinity, 50),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //         ),
          //         onPressed: () => _deleteMedicionesLocales(),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      _passwordShow = false;
    });

    // if (_areas.length == 0) {
    //   await showAlertDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           "La tabla Areas local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
    //       actions: <AlertDialogAction>[
    //         AlertDialogAction(key: null, label: 'Aceptar'),
    //       ]);
    //   SystemNavigator.pop();
    //   return;
    // }

    // if (_yacimientos.length == 0) {
    //   await showAlertDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           "La tabla Yacimientos local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
    //       actions: <AlertDialogAction>[
    //         AlertDialogAction(key: null, label: 'Aceptar'),
    //       ]);
    //   SystemNavigator.pop();
    //   return;
    // }

    // if (_baterias.length == 0) {
    //   await showAlertDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           "La tabla Baterías local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
    //       actions: <AlertDialogAction>[
    //         AlertDialogAction(key: null, label: 'Aceptar'),
    //       ]);
    //   SystemNavigator.pop();
    //   return;
    // }

    // if (_pozos.length == 0) {
    //   await showAlertDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           "La tabla Pozos local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
    //       actions: <AlertDialogAction>[
    //         AlertDialogAction(key: null, label: 'Aceptar'),
    //       ]);
    //   SystemNavigator.pop();
    //   return;
    // }

    // if (_pozosformulas.length == 0) {
    //   await showAlertDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           "La tabla Pozos Formulas local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
    //       actions: <AlertDialogAction>[
    //         AlertDialogAction(key: null, label: 'Aceptar'),
    //       ]);
    //   SystemNavigator.pop();
    //   return;
    // }

    // if (_pozoscontroles.length == 0) {
    //   await showAlertDialog(
    //       context: context,
    //       title: 'Error',
    //       message:
    //           "La tabla Pozos Controles local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
    //       actions: <AlertDialogAction>[
    //         AlertDialogAction(key: null, label: 'Aceptar'),
    //       ]);
    //   SystemNavigator.pop();
    //   return;
    // }

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

//***************************************************************
//*********************** USUARIOS ******************************
//***************************************************************
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('ultimaactualizacion', DateTime.now().toString());
      }
    }
    _getTablaUsuarios();
    return;
  }

  void _getTablaUsuarios() async {
    void _insertUsuarios() async {
      if (_usuariosApi.length > 0) {
        DBUsuarios.delete();
        _usuariosApi.forEach((element) {
          DBUsuarios.insertUsuario(element);
        });
      }
    }

    if (_hayInternet) {
      _insertUsuarios();
    }

    _usuarios = await DBUsuarios.usuarios();

    if (_usuarios.length == 0) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message:
              "La tabla Usuarios local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      SystemNavigator.pop();
      return;
    }

    _getAreas();
  }

//***************************************************************
//************************* AREAS *******************************
//***************************************************************
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
    void _insertAreas() async {
      if (_areasApi.length > 0) {
        DBAreas.delete();
        _areasApi.forEach((element) {
          DBAreas.insertArea(element);
        });
      }
    }

    if (_hayInternet) {
      _insertAreas();
    }

    _areas = await DBAreas.areas();
    _getYacimientos();
  }

  //***************************************************************
  //********************** YACIMIENTOS ****************************
  //***************************************************************
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
    void _insertYacimientos() async {
      if (_yacimientosApi.length > 0) {
        DBYacimientos.delete();
        _yacimientosApi.forEach((element) {
          DBYacimientos.insertYacimiento(element);
        });
      }
    }

    if (_hayInternet) {
      _insertYacimientos();
    }

    _yacimientos = await DBYacimientos.yacimientos();
    _getBaterias();
  }

//***************************************************************
//************************* BATERIAS ****************************
//***************************************************************
  Future<Null> _getBaterias() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getBaterias();

      if (response.isSuccess) {
        _bateriasApi = response.result;
        _bateriasApi.sort((a, b) {
          return a.codigobateria
              .toString()
              .toLowerCase()
              .compareTo(b.codigobateria.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaBaterias();
    return;
  }

  void _getTablaBaterias() async {
    void _insertBaterias() async {
      if (_bateriasApi.length > 0) {
        DBBaterias.delete();
        _bateriasApi.forEach((element) {
          DBBaterias.insertBateria(element);
        });
      }
    }

    if (_hayInternet) {
      _insertBaterias();
    }
    _baterias = await DBBaterias.baterias();
    _getPozos();
  }

//***************************************************************
//************************* POZOS *******************************
//***************************************************************
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
    void _insertPozos() async {
      if (_pozosApi.length > 0) {
        DBPozos.delete();
        _pozosApi.forEach((element) {
          DBPozos.insertPozo(element);
        });
      }
    }

    if (_hayInternet) {
      _insertPozos();
    }
    _pozos = await DBPozos.pozos();
    _getPozosFormulas();
  }

//***************************************************************
//************************* POZOSFORMULAS ***********************
//***************************************************************
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
    void _insertPozosFormulas() async {
      if (_pozosformulasApi.length > 0) {
        DBPozosFormulas.delete();
        _pozosformulasApi.forEach((element) {
          DBPozosFormulas.insertPozoFormula(element);
        });
      }
    }

    if (_hayInternet) {
      _insertPozosFormulas();
    }
    _pozosformulas = await DBPozosFormulas.pozosformulas();
    _getPozosControles();
  }

//***************************************************************
//************************* POZOSCONTROLES **********************
//***************************************************************
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
    void _insertPozosControles() async {
      if (_pozoscontrolesApi.length > 0) {
        DBPozosControles.delete();
        _pozoscontrolesApi.forEach((element) {
          DBPozosControles.insertPozoControl(element);
        });
      }
    }

    if (_hayInternet) {
      _insertPozosControles();
    }
    _pozoscontroles = await DBPozosControles.pozoscontroles();
    _getMedicionesCab();
  }

//***************************************************************
//******************* ControlDePozoEMBLLE  **********************
//***************************************************************
  Future<Null> _getMedicionesCab() async {
    _getTablaMedicionesCab();
    return;
  }

  void _getTablaMedicionesCab() async {
    _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
    _medicionesCabCompleta.forEach((medicion) {
      if (medicion.userIdInput == _usuarioLogueado.idUser) {
        _medicionesCab.add(medicion);
      }
    });
    _medicionesCab.sort((b, a) {
      return a.idControlPozo
          .toString()
          .toLowerCase()
          .compareTo(b.idControlPozo.toString().toLowerCase());
    });
    setState(() {
      _showLoader = false;
    });
  }

  _deleteMedicionesLocales() async {
    var response = await showAlertDialog(
        context: context,
        title: 'Confirmación',
        message:
            '¿Está seguro de borrar las mediciones locales que hay en este teléfono',
        actions: <AlertDialogAction>[
          AlertDialogAction(key: 'si', label: 'SI'),
          AlertDialogAction(key: 'no', label: 'NO'),
        ]);
    if (response == 'no') {
      return;
    }
    _medicionesCab.forEach((element) {
      DBMedicionesCabecera.delete(element);
    });
    return;
  }
}
