import 'dart:async';
import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_information/device_information.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************

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

  String _imeiNo = "";

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

  // String _email = '';
  // String _password = '';

  String _email = 'TEST';
  String _password = 'TEST';

  String _emailError = '';
  bool _emailShowError = false;
  bool _hayInternet = false;

  String _passwordError = '';
  bool _passwordShowError = false;
  bool _passwordShow = false;

  bool _showLoader = false;

//*****************************************************************************
//************************** INIT STATE ***************************************
//*****************************************************************************

  @override
  void initState() {
    super.initState();
    _getUsuarios();
  }

//*****************************************************************************
//************************** PANTALLA *****************************************
//*****************************************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd3a735),
      body: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: const BoxDecoration(
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
                      children: const [
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
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Transform.translate(
            offset: const Offset(0, -60),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 15,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _showEmail(),
                        _showPassword(),
                        const SizedBox(
                          height: 10,
                        ),
                        //_showRememberme(),
                        _showButtons(),
                        const SizedBox(
                          height: 10,
                        ),
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

//----------------------------------------------------------------------
//---------------------------- _showLogo -------------------------------
//----------------------------------------------------------------------

  Widget _showLogo() {
    return const Image(
      image: const AssetImage('assets/logo.png'),
      width: 300,
    );
  }

//----------------------------------------------------------------------
//---------------------------- _showEmail ------------------------------
//----------------------------------------------------------------------

  Widget _showEmail() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Usuario...',
            labelText: 'Usuario',
            errorText: _emailShowError ? _emailError : null,
            prefixIcon: const Icon(Icons.person),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

//----------------------------------------------------------------------
//---------------------------- _showPassword ---------------------------
//----------------------------------------------------------------------

  Widget _showPassword() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Contraseña...',
            labelText: 'Contraseña',
            errorText: _passwordShowError ? _passwordError : null,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: _passwordShow
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
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

//----------------------------------------------------------------------
//---------------------------- _showButtons ----------------------------
//----------------------------------------------------------------------

  Widget _showButtons() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.login),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Iniciar Sesión'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF9a6a2e),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () => _login(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

//----------------------------------------------------------------------
//---------------------------- _login ----------------------------------
//----------------------------------------------------------------------

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

    if (filteredUsuario.isEmpty) {
      setState(() {
        _passwordShowError = true;
        _passwordError = 'Usuario o contraseña incorrectos';
      });
      return;
    }

    _usuarioLogueado = filteredUsuario[0];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('conectadodesde', DateTime.now().toString());
    await prefs.setString(
        'validohasta', DateTime.now().add(new Duration(hours: 12)).toString());

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MenuScreen(
                  user: _usuarioLogueado,
                  areas: _areas,
                  yacimientos: _yacimientos,
                  baterias: _baterias,
                  pozos: _pozos,
                  pozosformulas: _pozosformulas,
                  pozoscontroles: _pozoscontroles,
                )));
  }

//----------------------------------------------------------------------
//---------------------------- validateFields --------------------------
//----------------------------------------------------------------------

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

//----------------------------------------------------------------------
//---------------------------- _getUsuarios ----------------------------
//----------------------------------------------------------------------

  Future<Null> _getUsuarios() async {
    setState(() {
      _showLoader = true;
    });
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        Response response =
            await ApiHelper.getUsuarios().timeout(const Duration(seconds: 20));

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
          await prefs.setString(
              'ultimaactualizacion', DateTime.now().toString());
        }
      } on TimeoutException catch (_) {
        throw ('Tiempo de espera alcanzado');
      } on SocketException {
        throw ('Sin internet  o falla de servidor ');
      } on HttpException {
        throw ("No se encontro esa peticion");
      } on FormatException {
        throw ("Formato erroneo ");
      }
    }
    _getTablaUsuarios();
  }

  void _getTablaUsuarios() async {
    void _insertUsuarios() async {
      if (_usuariosApi.isNotEmpty) {
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

    if (_usuarios.isEmpty) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message:
              "La tabla Usuarios local está vacía. Por favor arranque la App desde un lugar con acceso a Internet para poder conectarse al Servidor.",
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      SystemNavigator.pop();
      return;
    }

    // if (_usuarios.length > 0) {
    //   setState(() {
    //     _colorUsuarios = Colors.green;
    //   });
    // }

    _getAreas();
  }

//----------------------------------------------------------------------
//---------------------------- _getAreas -------------------------------
//----------------------------------------------------------------------

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
      if (_areasApi.isNotEmpty) {
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

    // if (_areas.length > 0) {
    //   setState(() {
    //     _colorAreas = Colors.green;
    //   });
    // }

    _getYacimientos();
  }

//----------------------------------------------------------------------
//---------------------------- _getYacimientos -------------------------
//----------------------------------------------------------------------

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
      if (_yacimientosApi.isNotEmpty) {
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

    // if (_yacimientos.length > 0) {
    //   setState(() {
    //     _colorYacimientos = Colors.green;
    //   });
    // }
    _getBaterias();
  }

//----------------------------------------------------------------------
//---------------------------- _getBaterias ----------------------------
//----------------------------------------------------------------------

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
      if (_bateriasApi.isNotEmpty) {
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

    // if (_baterias.length > 0) {
    //   setState(() {
    //     _colorBaterias = Colors.green;
    //   });
    // }

    _getPozos();
  }

//----------------------------------------------------------------------
//---------------------------- _getPozos -------------------------------
//----------------------------------------------------------------------

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
      if (_pozosApi.isNotEmpty) {
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

    // if (_pozos.length > 0) {
    //   setState(() {
    //     _colorPozos = Colors.green;
    //   });
    // }
    _getPozosFormulas();
  }

//----------------------------------------------------------------------
//---------------------------- _getPozosFormulas -----------------------
//----------------------------------------------------------------------

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
      if (_pozosformulasApi.isNotEmpty) {
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

    // if (_pozosformulas.length > 0) {
    //   setState(() {
    //     _colorPozosFormulas = Colors.green;
    //   });
    // }

    _getPozosControles();
  }

//----------------------------------------------------------------------
//---------------------------- _getPozosControles ----------------------
//----------------------------------------------------------------------

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
      if (_pozoscontrolesApi.isNotEmpty) {
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

//----------------------------------------------------------------------
//---------------------------- _getMedicionesCab -----------------------
//----------------------------------------------------------------------

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
      // _colorControlDePozoEMBLLE = Colors.green;
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
          const AlertDialogAction(key: 'si', label: 'SI'),
          const AlertDialogAction(key: 'no', label: 'NO'),
        ]);
    if (response == 'no') {
      return;
    }
    _medicionesCab.forEach((element) {
      DBMedicionesCabecera.delete(element);
    });
    return;
  }

//----------------------------------------------------------------------
//---------------------------- initPlatformState -----------------------
//----------------------------------------------------------------------

  Future<void> initPlatformState() async {
    late String imeiNo = '';

    // Platform messages may fail,
    // so we use a try/catch PlatformException.

    var status = await Permission.phone.status;

    if (status.isDenied) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Aviso'),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                        'La App necesita que habilite el Permiso de acceso al teléfono para registrar el IMEI del celular con que se loguea.'),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Ok')),
              ],
            );
          });
      openAppSettings();
      //exit(0);
    }

    try {
      imeiNo = await DeviceInformation.deviceIMEINumber;
    } on PlatformException catch (e) {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imeiNo = imeiNo;
    });
  }

//----------------------------------------------------------------------
//---------------------------- _postWebSesion -----------------------
//----------------------------------------------------------------------

  Future<void> _postWebSesion(WebSesion webSesion) async {
    Map<String, dynamic> requestWebSesion = {
      'nroConexion': webSesion.nroConexion,
      'usuario': webSesion.usuario,
      'iP': webSesion.iP,
      'loginDate': webSesion.loginDate,
      'loginTime': webSesion.loginTime,
      'modulo': webSesion.modulo,
      'logoutDate': webSesion.logoutDate,
      'logoutTime': webSesion.logoutTime,
      'conectAverage': webSesion.conectAverage,
      'id_ws': webSesion.id_ws,
      'version': webSesion.version,
    };

    await ApiHelper.post('/api/WebSesions/', requestWebSesion);
  }
}
