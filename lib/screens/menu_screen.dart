import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';
import 'package:psenergy_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  final Usuario user;

  const MenuScreen({
    required this.user,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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

  List<Alarma> _alarmas = [];

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
    // TODO: implement initState
    super.initState();
    _getDatos();
  }

//*****************************************************************************
//************************** PANTALLA *****************************************
//*****************************************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9dac2),
      appBar: AppBar(
        title: const Text('PSEnergy'),
        backgroundColor: const Color(0xff9a6a2e),
        centerTitle: true,
      ),
      body: _getBody(),
      drawer: _getMenu(),
    );
  }

  Widget _getBody() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                "assets/logo2.png",
                height: 200,
              ),
              Text(
                'Bienvenido/a ${widget.user.apellidonombre}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff9a6a2e),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _getMenu() {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffffffff),
              Color(0xffe9dac2),
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffffffff),
                    Color(0xffffffff),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: AssetImage('assets/logo2.png'),
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Usuario: ",
                        style: (TextStyle(
                            color: Color(0xff0e4888),
                            fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        widget.user.apellidonombre!,
                        style: (const TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.data_exploration,
                color: Color(0xff0e4888),
              ),
              title: const Text('Nuevas Mediciones',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: const Color(0xff0e4888),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              user: widget.user,
                              areas: _areas,
                              yacimientos: _yacimientos,
                              baterias: _baterias,
                              pozos: _pozos,
                              pozosformulas: _pozosformulas,
                              pozoscontroles: _pozoscontroles,
                            )));
              },
            ),
            const Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.warning,
                color: Color(0xff0e4888),
              ),
              title: const Text('Alarmas',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: const Color(0xff0e4888),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlarmasScreen(
                              user: widget.user,
                              alarmas: _alarmas,
                            )));
              },
            ),
            const Divider(
              color: Color(0xff0e4888),
              height: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color(0xff0e4888),
              ),
              tileColor: const Color(0xff8c8c94),
              title: const Text('Cerrar Sesión',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              onTap: () {
                _logOut();
              },
            ),
          ],
        ),
      ),
    );
  }

//*********************************************************************
//************************** _logOut **********************************
//*********************************************************************

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRemembered', false);
    await prefs.setString('userBody', '');
    await prefs.setString('date', '');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

//----------------------------------------------------------------------
//---------------------------- _getDatos ----------------------------
//----------------------------------------------------------------------

  Future<Null> _getDatos() async {
    _areas = await DBAreas.areas();
    _yacimientos = await DBYacimientos.yacimientos();
    _baterias = await DBBaterias.baterias();
    _pozos = await DBPozos.pozos();
    _pozosformulas = await DBPozosFormulas.pozosformulas();
    _pozoscontroles = await DBPozosControles.pozoscontroles();
    _alarmas = await DBAlarmas.alarma();
    await _getMedicionesCab();
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
}
