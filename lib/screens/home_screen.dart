import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/helpers/constants.dart';
import 'package:psenergy_app/models/area.dart';
import 'package:psenergy_app/models/bateria.dart';
import 'package:psenergy_app/models/pozo.dart';
import 'package:psenergy_app/models/response.dart';
import 'package:psenergy_app/models/usuario.dart';
import 'package:psenergy_app/models/yacimiento.dart';
import 'package:psenergy_app/screens/change_password_screen.dart';
import 'package:psenergy_app/screens/contacto_screen.dart';
import 'package:psenergy_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Usuario user;
  final List<Area> areas;
  final List<Yacimiento> yacimientos;
  final List<Bateria> baterias;
  final List<Pozo> pozos;

  HomeScreen(
      {required this.user,
      required this.areas,
      required this.yacimientos,
      required this.baterias,
      required this.pozos});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  TabController? _tabController;
  Usuario _user = Usuario(
      idUser: 0,
      codigo: '',
      apellidonombre: '',
      usrlogin: '',
      usrcontrasena: '',
      perfil: 0,
      habilitadoWeb: 0,
      causanteC: '',
      habilitaPaqueteria: 0);

  bool _showLoader = false;
  String _conectadodesde = '';
  String _validohasta = '';
  String _ultimaactualizacion = '';

  String _areaSelected = 'Seleccione un Área...';
  String _areaError = '';
  bool _areaShowError = false;
  List<Area> _areas = [];

  String _yacimientoSelected = 'Seleccione un Yacimiento...';
  String _yacimientoError = '';
  bool _yacimientoShowError = false;
  List<Yacimiento> _yacimientos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    _tabController = TabController(length: 3, vsync: this);
    _getprefs();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dac2),
      appBar: AppBar(
        title: (Text("PSEnergy App")),
        centerTitle: true,
        backgroundColor: Color(0xff9a6a2e),
      ),
      body: Container(
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
        child: TabBarView(
          controller: _tabController,
          physics: AlwaysScrollableScrollPhysics(),
          dragStartBehavior: DragStartBehavior.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                _showAreas(),
                _showYacimientos(),
              ],
            ),
            Center(
              child: Text("Chau"),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      _user.usrlogin!.toUpperCase(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      _user.apellidonombre!,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Conectado desde:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _conectadodesde == ''
                              ? ''
                              : '${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(_conectadodesde))}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Válido hasta:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _validohasta == ''
                              ? ''
                              : '${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(_validohasta))}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Ultima actualización de Usuarios:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _ultimaactualizacion == ''
                              ? ''
                              : '${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(_ultimaactualizacion))}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Versión:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          Constants.version,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.password),
                        SizedBox(
                          width: 15,
                        ),
                        Text('ACTUALIZAR CONTRASEÑA'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF9a6a2e);
                      }),
                    ),
                    onPressed: () => _actualizarPassword(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CONTACTO KEYPRESS'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF9a6a2e);
                      }),
                    ),
                    onPressed: () => _contacto(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CERRAR SESION'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF9a6a2e);
                      }),
                    ),
                    onPressed: () => _logOut(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
            controller: _tabController,
            // indicator: BoxDecoration(
            //     color: Colors.orange,
            //     border: Border.all(width: 5, color: Colors.yellow)),
            indicatorColor: Color(0xff9a6a2e),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            // isScrollable: false,
            labelColor: Color(0xff9a6a2e),
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.all(10),
            tabs: <Widget>[
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Nueva",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Cargadas",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Usuario",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  void _actualizarPassword() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
  }

  void _logOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _contacto() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactoScreen()));
  }

  void _getprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _conectadodesde = prefs.getString('conectadodesde').toString();
    _validohasta = prefs.getString('validohasta').toString();
    _ultimaactualizacion = prefs.getString('ultimaactualizacion').toString();
    var a = 123;
    setState(() {});
  }

  void _loadData() async {
    await _getAreas();
  }

  Future<Null> _getAreas() async {
    setState(() {
      _areas = widget.areas;
    });
  }

  Widget _showAreas() {
    return Container(
      padding: EdgeInsets.all(10),
      child: _areas.length == 0
          ? Text('Cargando áreas...')
          : DropdownButtonFormField(
              items: _getComboAreas(),
              value: _areaSelected,
              onChanged: (option) {
                //_areaId = option as int;
                _areaSelected = option as String;
                _yacimientos = [];
                _getYacimientos(_areaSelected);
                _yacimientoSelected = 'Seleccione un Yacimiento...';
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Seleccione un área...',
                labelText: 'Área',
                errorText: _areaShowError ? _areaError : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              )),
    );
  }

  List<DropdownMenuItem<String>> _getComboAreas() {
    List<DropdownMenuItem<String>> list = [];
    list.add(DropdownMenuItem(
      child: Text('Seleccione un Área...'),
      value: 'Seleccione un Área...',
      //value: 0,
    ));

    _areas.forEach((area) {
      list.add(DropdownMenuItem(
        child: Text(area.nombrearea),
        value: area.nombrearea,
      ));
    });

    return list;
  }

  Widget _showYacimientos() {
    return Container(
      padding: EdgeInsets.all(10),
      child: _yacimientos.length == 0
          ? Text('')
          : DropdownButtonFormField(
              items: _getComboYacimientos(),
              value: _yacimientoSelected,
              onChanged: (option) {
                setState(() {
                  _yacimientoSelected = option as String;
                });
              },
              decoration: InputDecoration(
                hintText: 'Seleccione un yacimiento...',
                labelText: 'Yacimiento',
                errorText: _yacimientoShowError ? _yacimientoError : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              )),
    );
  }

  List<DropdownMenuItem<String>> _getComboYacimientos() {
    List<DropdownMenuItem<String>> list = [];
    list.add(DropdownMenuItem(
      child: Text('Seleccione un Yacimiento...'),
      value: 'Seleccione un Yacimiento...',
    ));

    _yacimientos.forEach((yacimiento) {
      list.add(DropdownMenuItem(
        child: Text(yacimiento.nombreyacimiento),
        value: yacimiento.nombreyacimiento,
      ));
    });

    return list;
  }

  Future<Null> _getYacimientos(String area) async {
    List<Yacimiento> filteredYacimientos = [];
    for (var yacimiento in widget.yacimientos) {
      if (yacimiento.area == _areaSelected) {
        filteredYacimientos.add(yacimiento);
      }
    }
    setState(() {
      _yacimientos = filteredYacimientos;
    });
  }
}
