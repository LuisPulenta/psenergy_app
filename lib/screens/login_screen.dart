import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:http/http.dart' as http;
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
import 'package:psenergy_app/helpers/dbwebsesions_helper.dart';

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
  List<Yacimiento> _yacimientosApi = [];
  List<Bateria> _bateriasApi = [];
  List<Pozo> _pozosApi = [];
  List<PozosFormula> _pozosformulasApi = [];
  List<PozosControle> _pozoscontrolesApi = [];
  List<Alarma> _alarmasApi = [];
  final List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];
  List<WebSesion> _webSesionsdb = [];

  String _imeiNo = "";

  bool _notifications = false;

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

  //String _email = '';
  //String _password = '';

  //String _email = 'TEST';
  //String _password = 'TEST';

  String _email = 'CMAEDA';
  String _password = 'CMA134';

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
                        _showNotifications(),
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
                ? const LoaderComponent(text: 'Por favor espere...')
                : Container(),
          )
        ],
      ),
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

//-----------------------------------------------------------------
//--------------------- METODO SHOWNOTIFICATIONS ------------------
//-----------------------------------------------------------------

  _showNotifications() {
    return CheckboxListTile(
      title: const Text('Notificaciones:'),
      value: _notifications,
      onChanged: (value) {
        setState(() {
          _notifications = value!;
        });
      },
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
    FocusScope.of(context).unfocus(); //Oculta el teclado

//***** Login NORMAL *****
    if (!_notifications) {
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
      await prefs.setString('validohasta',
          DateTime.now().add(const Duration(hours: 12)).toString());

      // Agregar registro a bd local websesion

      Random r = Random();
      int resultado = r.nextInt((99999999 - 10000000) + 1) + 10000000;
      double hora = (DateTime.now().hour * 3600 +
              DateTime.now().minute * 60 +
              DateTime.now().second +
              DateTime.now().millisecond * 0.001) *
          100;

      WebSesion webSesion = WebSesion(
          nroConexion: resultado,
          usuario: _usuarioLogueado.idUser.toString(),
          iP: _imeiNo,
          loginDate: DateTime.now().toString(),
          loginTime: hora.round(),
          modulo: 'App-${_usuarioLogueado.codigo}',
          logoutDate: "",
          logoutTime: 0,
          conectAverage: 0,
          id_ws: 0,
          version: Constants.version);

      DBWebSesions.insertWebSesion(webSesion);

      // Agregar nroConexion a SharedPreferences

      // Si hay internet
      //    - Subir al servidor todos los registros de la bd local websesion
      //    - borrar la bd local websesion

      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult != ConnectivityResult.none) {
        _webSesionsdb = await DBWebSesions.webSesions();

        for (var _webSesion in _webSesionsdb) {
          await _postWebSesion(_webSesion);
        }
        await DBWebSesions.delete();
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MenuScreen(
                    user: _usuarioLogueado,
                  )));
    } else

    //***** Login a Notifications *****
    {
      setState(() {
        _passwordShow = false;
      });

      if (!validateFields()) {
        return;
      }

      setState(() {
        _showLoader = true;
      });

      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _showLoader = false;
        });
        await showAlertDialog(
            context: context,
            title: 'Error',
            message: 'Verifica que estes conectado a internet.',
            actions: <AlertDialogAction>[
              const AlertDialogAction(key: null, label: 'Aceptar'),
            ]);
        return;
      }

      Map<String, dynamic> request = {
        'Email': _email,
        'password': _password,
      };

      var url = Uri.parse('${Constants.apiUrl}/Api/Account/GetUserByEmail');
      var response = await http.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode(request),
      );

      if (response.statusCode >= 400) {
        setState(() {
          _passwordShowError = true;
          _passwordError = 'Email o contraseña incorrectos';
          _showLoader = false;
        });
        return;
      }

      var body = response.body;
      var decodedJson = jsonDecode(body);
      var user = User.fromJson(decodedJson);

      if (user.contrasena.toLowerCase() != _password.toLowerCase()) {
        setState(() {
          _showLoader = false;
          _passwordShowError = true;
          _passwordError = 'Email o contraseña incorrectos';
        });
        return;
      }

      if (user.permOS != 1) {
        setState(() {
          _showLoader = false;
          _passwordShowError = true;
          _passwordError = 'Usuario no habilitado';
        });
        return;
      }

      _usuarioLogueado = Usuario(
          idUser: user.idUsuario,
          codigo: "",
          apellidonombre: user.nombre + " " + user.apellido,
          usrlogin: user.login,
          usrcontrasena: user.contrasena,
          perfil: 0,
          habilitadoWeb: 0,
          causanteC: "",
          habilitaPaqueteria: 0);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('conectadodesde', DateTime.now().toString());
      await prefs.setString('validohasta',
          DateTime.now().add(const Duration(hours: 12)).toString());

      // Agregar registro a bd local websesion

      Random r = Random();
      int resultado = r.nextInt((99999999 - 10000000) + 1) + 10000000;
      double hora = (DateTime.now().hour * 3600 +
              DateTime.now().minute * 60 +
              DateTime.now().second +
              DateTime.now().millisecond * 0.001) *
          100;

      WebSesion webSesion = WebSesion(
          nroConexion: resultado,
          usuario: _usuarioLogueado.idUser.toString(),
          iP: _imeiNo,
          loginDate: DateTime.now().toString(),
          loginTime: hora.round(),
          modulo: 'App-${_usuarioLogueado.codigo}',
          logoutDate: "",
          logoutTime: 0,
          conectAverage: 0,
          id_ws: 0,
          version: Constants.version);

      DBWebSesions.insertWebSesion(webSesion);

      // Agregar nroConexion a SharedPreferences

      // Si hay internet
      //    - Subir al servidor todos los registros de la bd local websesion
      //    - borrar la bd local websesion

      if (connectivityResult != ConnectivityResult.none) {
        _webSesionsdb = await DBWebSesions.webSesions();

        for (var _webSesion in _webSesionsdb) {
          await _postWebSesion(_webSesion);
        }
        await DBWebSesions.delete();
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Menu2Screen(
                    user: _usuarioLogueado,
                  )));
    }
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

//----------------------------------------------------------------------
//---------------------------- _getUsuarios ----------------------------
//----------------------------------------------------------------------

  Future<void> _getUsuarios() async {
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
        for (var element in _usuariosApi) {
          DBUsuarios.insertUsuario(element);
        }
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

  Future<void> _getAreas() async {
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
        for (var element in _areasApi) {
          DBAreas.insertArea(element);
        }
      }
    }

    if (_hayInternet) {
      _insertAreas();
    }

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

  Future<void> _getYacimientos() async {
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
        for (var element in _yacimientosApi) {
          DBYacimientos.insertYacimiento(element);
        }
      }
    }

    if (_hayInternet) {
      _insertYacimientos();
    }

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

  Future<void> _getBaterias() async {
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
        for (var element in _bateriasApi) {
          DBBaterias.insertBateria(element);
        }
      }
    }

    if (_hayInternet) {
      _insertBaterias();
    }

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

  Future<void> _getPozos() async {
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
        for (var element in _pozosApi) {
          DBPozos.insertPozo(element);
        }
      }
    }

    if (_hayInternet) {
      _insertPozos();
    }

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

  Future<void> _getPozosFormulas() async {
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
        for (var element in _pozosformulasApi) {
          DBPozosFormulas.insertPozoFormula(element);
        }
      }
    }

    if (_hayInternet) {
      _insertPozosFormulas();
    }

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

  Future<void> _getPozosControles() async {
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
        for (var element in _pozoscontrolesApi) {
          DBPozosControles.insertPozoControl(element);
        }
      }
    }

    if (_hayInternet) {
      _insertPozosControles();
    }

    _getAlarmas();
  }

//----------------------------------------------------------------------
//---------------------------- _getAlarmas ----------------------
//----------------------------------------------------------------------

  Future<void> _getAlarmas() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      Response response = await ApiHelper.getAlarmas();

      if (response.isSuccess) {
        _alarmasApi = response.result;
        _alarmasApi.sort((a, b) {
          return a.bateria
              .toString()
              .toLowerCase()
              .compareTo(b.bateria.toString().toLowerCase());
        });
        _hayInternet = true;
      }
    }
    _getTablaAlarmas();
    return;
  }

  void _getTablaAlarmas() async {
    void _insertAlarmas() async {
      if (_alarmasApi.isNotEmpty) {
        DBAlarmas.deleteall();
        for (var element in _alarmasApi) {
          DBAlarmas.insertAlarma(element);
        }
      }
    }

    if (_hayInternet) {
      _insertAlarmas();
    }

    _getMedicionesCab();
  }

//----------------------------------------------------------------------
//---------------------------- _getMedicionesCab -----------------------
//----------------------------------------------------------------------

  Future<void> _getMedicionesCab() async {
    _getTablaMedicionesCab();
    return;
  }

  void _getTablaMedicionesCab() async {
    _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
    for (var medicion in _medicionesCabCompleta) {
      if (medicion.userIdInput == _usuarioLogueado.idUser) {
        _medicionesCab.add(medicion);
      }
    }
    _medicionesCab.sort((b, a) {
      return a.idControlPozo
          .toString()
          .toLowerCase()
          .compareTo(b.idControlPozo.toString().toLowerCase());
    });

    setState(() {
      // _colorControlDePozoEMBLLE = Colors.green;
      _showLoader = false;
      _showSnackbar("Debe ingresar su Usuario y Contraseña");
      // showAlertDialog(
      //     context: context,
      //     title: 'Mensaje',
      //     message:
      //         'Debe ingresar su Usuario y Contraseña. Luego apretar Aceptar. Debe estar conectado a Internet al menos la primera vez para que la Aplicación baje desde el Sevidor los datos necesarios para trabajar (Area, Yacimientos, Baterías, Pozos, Usuarios, etc.)',
      //     actions: <AlertDialogAction>[
      //       const AlertDialogAction(key: null, label: 'Aceptar'),
      //     ]);
    });
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
    } on PlatformException {}

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

//*****************************************************************************
//************************** METODO SHOWSNACKBAR ******************************
//*****************************************************************************

  void _showSnackbar(String text) {
    SnackBar snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.lightGreen,
      //duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
