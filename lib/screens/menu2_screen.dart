import 'package:flutter/material.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';
import 'package:psenergy_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu2Screen extends StatefulWidget {
  final User user;

  const Menu2Screen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _Menu2ScreenState createState() => _Menu2ScreenState();
}

class _Menu2ScreenState extends State<Menu2Screen> {
  //*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************

  final List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];

  final Usuario _usuarioLogueado = Usuario(
      idUser: 0,
      codigo: '',
      apellidonombre: '',
      usrlogin: '',
      usrcontrasena: '',
      perfil: 0,
      habilitadoWeb: 0,
      causanteC: '',
      habilitaPaqueteria: 0);

//*****************************************************************************
//************************** INIT STATE ***************************************
//*****************************************************************************

  @override
  void initState() {
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
                'Bienvenido/a ${widget.user.nombre + " " + widget.user.apellido}',
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
                        widget.user.nombre + " " + widget.user.apellido,
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
                Icons.notifications,
                color: Color(0xff0e4888),
              ),
              title: const Text('Notificaciones',
                  style: TextStyle(fontSize: 15, color: Color(0xff0e4888))),
              tileColor: const Color(0xff0e4888),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen(
                              user: widget.user,
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

  Future<void> _getDatos() async {
    await _getMedicionesCab();
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
    });
  }
}
