import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/helpers/constants.dart';
import 'package:psenergy_app/helpers/dbmedicionescabecera_helper.dart';
import 'package:psenergy_app/models/area.dart';
import 'package:psenergy_app/models/bateria.dart';
import 'package:psenergy_app/models/medicioncabecera.dart';
import 'package:psenergy_app/models/pozo.dart';
import 'package:psenergy_app/models/pozoscontrole.dart';
import 'package:psenergy_app/models/pozosformula.dart';
import 'package:psenergy_app/models/response.dart';
import 'package:psenergy_app/models/usuario.dart';
import 'package:psenergy_app/models/yacimiento.dart';
import 'package:psenergy_app/screens/change_password_screen.dart';
import 'package:psenergy_app/screens/contacto_screen.dart';
import 'package:psenergy_app/screens/login_screen.dart';
import 'package:psenergy_app/screens/medicion_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Usuario user;
  final List<Area> areas;
  final List<Yacimiento> yacimientos;
  final List<Bateria> baterias;
  final List<Pozo> pozos;
  final List<PozosFormula> pozosformulas;
  final List<PozosControle> pozoscontroles;

  HomeScreen(
      {required this.user,
      required this.areas,
      required this.yacimientos,
      required this.baterias,
      required this.pozos,
      required this.pozosformulas,
      required this.pozoscontroles});

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

  Pozo _pozo = Pozo(
      codigopozo: '',
      codigobateria: '',
      descripcion: '',
      fechaalta: '',
      activo: 0,
      ultimalectura: '',
      latitud: '',
      longitud: '',
      qrcode: '',
      observaciones: '',
      tipopozo: '',
      sistemaExtraccion: '',
      cuenca: '',
      idProvincia: 0,
      cota: 0.0,
      profundidad: 0.0,
      vidaUtil: 0.0);

  String _password = '';
  String _result2 = "no";
  String _passwordError = '';
  bool _passwordShowError = false;
  bool _passwordShow = false;
  int _idCab = 0;
  double _valor = 0;

  MedicionCabecera medicionSelected = new MedicionCabecera(
      idControlPozo: 0,
      bateria: '',
      pozo: '',
      fecha: '',
      ql: 0,
      qo: 0,
      qw: 0,
      qg: 0,
      wcLibre: 0,
      wcEmulc: 0,
      wcTotal: 0,
      sales: 0,
      gor: 0,
      t: 0,
      validacionControl: '',
      prTbg: 0,
      prLinea: 0,
      prCsg: 0,
      regimenOperacion: 0,
      aibCarrera: 0,
      bespip: 0,
      pcpTorque: 0,
      observaciones: '',
      validadoSupervisor: 0,
      userIdInput: 0,
      userIDValida: 0,
      caudalInstantaneo: 0,
      caudalMedio: 0,
      lecturaAcumulada: 0,
      presionBDP: 0,
      presionAntFiltro: 0,
      presionEC: 0,
      ingresoDatos: '',
      reenvio: 0,
      muestra: '',
      fechaCarga: '',
      idUserValidaMuestra: 0,
      idUserImputSoft: 0,
      volt: 0,
      amper: 0,
      temp: 0,
      fechaCargaAPP: '',
      enviado: 0);

  bool _showLoader = false;
  String _conectadodesde = '';
  String _validohasta = '';
  String _ultimaactualizacion = '';
  List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];

  String _areaSelected = 'Seleccione un Área...';
  String _areaError = '';
  bool _areaShowError = false;
  List<Area> _areas = [];

  String _yacimientoSelected = 'Seleccione un Yacimiento...';
  String _yacimientoError = '';
  bool _yacimientoShowError = false;
  List<Yacimiento> _yacimientos = [];

  String _bateriaSelected = 'Seleccione una Batería...';
  String _bateriaError = '';
  bool _bateriaShowError = false;
  List<Bateria> _baterias = [];

  Pozo _pozoSelected = new Pozo(
      codigopozo: '',
      codigobateria: '',
      descripcion: '',
      fechaalta: '',
      activo: 0,
      ultimalectura: '',
      latitud: '',
      longitud: '',
      qrcode: '',
      observaciones: '',
      tipopozo: '',
      sistemaExtraccion: '',
      cuenca: '',
      idProvincia: 0,
      cota: 0.0,
      profundidad: 0.0,
      vidaUtil: 0.0);
  List<Pozo> _pozos = [];

  String Titulo = "Nueva medición";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    _tabController = TabController(length: 3, vsync: this);
    _getprefs();
    _loadData();
    _grabaMediciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dac2),
      // appBar: AppBar(
      //   //title: (Text("PSEnergy App")),
      //   title: (Text(Titulo)),
      //   centerTitle: true,
      //   backgroundColor: Color(0xff9a6a2e),
      // ),
      body: Stack(
        children: [
          Container(
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
                    AppBar(
                      title: (Text("Nueva medición")),
                      centerTitle: true,
                      backgroundColor: Color(0xff9a6a2e),
                    ),
                    _showAreas(),
                    _showYacimientos(),
                    _showBaterias(),
                    Expanded(
                      child: _pozos.length == 0 ? _noContent() : _showPozos(),
                    )
                  ],
                ),
                Column(
                  children: [
                    AppBar(
                      title: (Text("Ultimas mediciones")),
                      centerTitle: true,
                      backgroundColor: Color(0xff9a6a2e),
                    ),
                    Center(
                      child: _getContent(),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBar(
                        title: (Text("Información")),
                        centerTitle: true,
                        backgroundColor: Color(0xff9a6a2e),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(children: [
                          Center(
                            child: Text(
                              _user.usrlogin.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              _user.apellidonombre,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9a6a2e),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
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
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('BORRAR MEDICIONES LOCALES'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              _password = 'TEST'; //TODO BORRAR
                              _result2 = "no";
                              await _borrarMedicionesLocales();
                              if (_result2 == 'yes') {
                                await _actualizaMedicionesCab2();
                              }
                              setState(() {});
                            },
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
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9a6a2e),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
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
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9a6a2e),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () => _logOut(),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _showLoader
              ? LoaderComponent(
                  text: 'Por favor espere...',
                )
              : Container(),
        ],
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangePasswordScreen(
                  user: widget.user,
                )));
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
    await _actualizaMedicionesCab();
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
                _baterias = [];
                _pozos = [];
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
                _yacimientoSelected = option as String;
                _baterias = [];
                _pozos = [];
                _getBaterias(_yacimientoSelected);
                _bateriaSelected = 'Seleccione una Batería...';
                setState(() {});
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

  Widget _showBaterias() {
    return Container(
      padding: EdgeInsets.all(10),
      child: _baterias.length == 0
          ? Text('')
          : DropdownButtonFormField(
              items: _getComboBaterias(),
              value: _bateriaSelected,
              onChanged: (option) {
                _bateriaSelected = option as String;
                _pozos = [];
                _getPozos(_bateriaSelected);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Seleccione una Batería...',
                labelText: 'Batería',
                errorText: _bateriaShowError ? _bateriaError : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              )),
    );
  }

  List<DropdownMenuItem<String>> _getComboBaterias() {
    List<DropdownMenuItem<String>> list = [];
    list.add(DropdownMenuItem(
      child: Text('Seleccione una Batería...'),
      value: 'Seleccione una Batería...',
    ));

    _baterias.forEach((bateria) {
      list.add(DropdownMenuItem(
        child: Text(bateria.descripcion),
        value: bateria.codigobateria,
      ));
    });

    return list;
  }

  Future<Null> _getBaterias(String yacimiento) async {
    List<Bateria> filteredBaterias = [];
    for (var bateria in widget.baterias) {
      if (bateria.nombreyacimiento == _yacimientoSelected) {
        filteredBaterias.add(bateria);
      }
    }
    setState(() {
      _baterias = filteredBaterias;
    });
  }

  Future<Null> _getPozos(String bateria) async {
    List<Pozo> filteredPozos = [];
    for (var pozo in widget.pozos) {
      if (pozo.codigobateria == _bateriaSelected) {
        filteredPozos.add(pozo);
      }
    }
    setState(() {
      _pozos = filteredPozos;
    });
  }

  Widget _showPozos() {
    return ListView(
      children: _pozos.map((e) {
        return Card(
          color: Color(0xFFe9dac2),
          shadowColor: Colors.white,
          elevation: 10,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: InkWell(
            onTap: () {
              _pozoSelected = e;
              if (DateTime.parse(_validohasta).isBefore(DateTime.now())) {
                _logOut();
              } else {
                _goQuestionPozo(e);
              }
            },
            child: Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Pozo: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Expanded(
                                      child: Text(e.descripcion.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                    ),
                                    Text("Tipo Pozo: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Expanded(
                                      child: Text(e.tipopozo.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _goQuestionPozo(Pozo pozo) async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MedicionScreen(
                  user: widget.user,
                  pozo: _pozoSelected,
                  pozos: widget.pozos,
                  pozosformulas: widget.pozosformulas,
                  pozoscontroles: widget.pozoscontroles,
                )));
    if (result == 'yes') {
      setState(() {
        _showLoader = true;
      });
      await _actualizaMedicionesCab();
      setState(() {
        _showLoader = false;
      });
    }

    setState(() {});
  }

  Widget _getContent() {
    return _medicionesCab.length == 0 ? _noContent2() : _getListView();
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _grabaMediciones,
      child: Container(
        height: 550,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: _medicionesCab.map((e) {
            return Card(
              color: Color(0xFFe9dac2),
              shadowColor: Colors.white,
              elevation: 10,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: InkWell(
                onTap: () {
                  medicionSelected = e;
                  _goInfoMedicion(e);
                },
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              e.enviado == 1
                                  ? Icon(Icons.done_all, color: Colors.green)
                                  : e.enviado == 0
                                      ? Icon(Icons.done, color: Colors.grey)
                                      : Icon(Icons.done, color: Colors.red),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("N° Med.: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF781f1e),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text("Batería: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF781f1e),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  e.fechaCargaAPP == ""
                                      ? Container()
                                      : Text("Fec. sub.:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(e.idControlPozo.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                  Text(e.bateria,
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                  e.fechaCargaAPP == ""
                                      ? Container()
                                      : Text(
                                          //e.fechaCargaAPP,
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(e.fechaCargaAPP!))}',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Fecha: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF781f1e),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text("Pozo: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF781f1e),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  e.fechaCargaAPP == ""
                                      ? Container()
                                      : Text("",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(e.fecha,
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                  Text(e.pozo,
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                  e.fechaCargaAPP == ""
                                      ? Container()
                                      : Text("",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _getMediciones() async {
    setState(() {
      _showLoader = true;
    });
    await _actualizaMedicionesCab();
    setState(() {
      _showLoader = false;
    });
  }

  void _goInfoMedicion(MedicionCabecera e) {}

  _borrarMedicionesLocales() async {
    // context: context,
    //     title: 'Error',
    //     message: 'Verifica que estés conectado a Internet',
    //     actions: <AlertDialogAction>[
    //       AlertDialogAction(key: null, label: 'Aceptar'),
    //     ]);

    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Atención!!",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Text(
                        "Para borrar las mediciones locales de su Usuario debe escribir su contraseña",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(""),
                      TextField(
                        obscureText: !_passwordShow,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Contraseña...',
                            labelText: 'Contraseña',
                            errorText:
                                _passwordShowError ? _passwordError : null,
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete),
                        SizedBox(
                          width: 15,
                        ),
                        Text('BORRAR'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (_password.toLowerCase() !=
                          widget.user.usrcontrasena.toLowerCase()) {
                        _passwordShowError = true;
                        _passwordError = 'Contraseña incorrecta';
                        setState(() {});
                      } else {
                        _medicionesCab.forEach((element) {
                          if (element.userIdInput == widget.user.idUser) {
                            DBMedicionesCabecera.delete(element);
                          }
                        });
                        _medicionesCab = [];
                        setState(() {});
                        _result2 = "yes";
                        Navigator.pop(context, 'yes');
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CANCELAR'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF9a6a2e),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      _passwordShowError = false;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
                shape: Border.all(
                    color: Colors.red, width: 5, style: BorderStyle.solid),
                backgroundColor: Colors.white,
              );
            },
          );
        });
  }

  Future<void> _actualizaMedicionesCab() async {
    return Future.delayed(Duration(seconds: 1), () async {
      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
      _medicionesCabCompleta.forEach((medicion) {
        if (DateTime.parse(medicion.fecha)
            .isBefore(DateTime.now().add(Duration(days: -30)))) {
          DBMedicionesCabecera.delete(medicion);
        }
      });

      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();

      _medicionesCab = [];
      _medicionesCabCompleta.forEach((medicion) {
        if (medicion.userIdInput == widget.user.idUser) {
          _medicionesCab.add(medicion);
        }
      });
      _medicionesCab.sort((b, a) {
        return a.idControlPozo
            .toString()
            .toLowerCase()
            .compareTo(b.idControlPozo.toString().toLowerCase());
      });
    });
  }

  Future<void> _actualizaMedicionesCab2() async {
    return Future.delayed(Duration(seconds: 0), () async {
      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
      _medicionesCabCompleta.forEach((medicion) {
        if (DateTime.parse(medicion.fecha)
            .isBefore(DateTime.now().add(Duration(days: -30)))) {
          DBMedicionesCabecera.delete(medicion);
        }
      });

      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
      _medicionesCab = [];
      _medicionesCabCompleta.forEach((medicion) {
        if (medicion.userIdInput == widget.user.idUser) {
          _medicionesCab.add(medicion);
        }
      });
      _medicionesCab.sort((b, a) {
        return a.idControlPozo
            .toString()
            .toLowerCase()
            .compareTo(b.idControlPozo.toString().toLowerCase());
      });
    });
  }

  Future<void> _grabaMediciones() async {
    await _actualizaMedicionesCab();
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      _medicionesCab.forEach((medicion) {
        if (medicion.enviado == 0) {
          Map<String, dynamic> request = {
            'idControlPozo': 0,
            'bateria': medicion.bateria,
            'pozo': medicion.pozo,
            'fecha': medicion.fecha,
            'ql': medicion.ql,
            'qo': medicion.qo,
            'qw': medicion.qw,
            'qg': medicion.qg,
            'wcLibre': medicion.wcLibre,
            'wcEmulc': medicion.wcEmulc,
            'wcTotal': medicion.wcTotal,
            'sales': medicion.sales,
            'gor': medicion.gor,
            't': medicion.t,
            'validacionControl': medicion.validacionControl,
            'prTbg': medicion.prTbg,
            'prLinea': medicion.prLinea,
            'prCsg': medicion.prCsg,
            'regimenOperacion': medicion.regimenOperacion,
            'aibCarrera': medicion.aibCarrera,
            'bespip': medicion.bespip,
            'pcpTorque': medicion.pcpTorque,
            'observaciones': medicion.observaciones,
            'validadoSupervisor': medicion.validadoSupervisor,
            'userIdInput': medicion.userIdInput,
            'userIDValida': medicion.userIDValida,
            'caudalInstantaneo': medicion.caudalInstantaneo,
            'caudalMedio': medicion.caudalMedio,
            'lecturaAcumulada': medicion.lecturaAcumulada,
            'presionBDP': medicion.presionBDP,
            'presionAntFiltro': medicion.presionAntFiltro,
            'presionEC': medicion.presionEC,
            'ingresoDatos': medicion.ingresoDatos,
            'reenvio': medicion.reenvio,
            'muestra': medicion.muestra,
            'fechaCarga': DateTime.now().toString(),
            'idUserValidaMuestra': medicion.idUserValidaMuestra,
            'idUserImputSoft': medicion.idUserImputSoft,
            'volt': medicion.volt,
            'amper': medicion.amper,
            'temp': medicion.temp,
            'fechaCargaAPP': DateTime.now().toString(),
          };

          widget.pozos.forEach((pozo) {
            if (pozo.codigopozo == medicion.pozo) {
              _pozo = pozo;
            }
          });
          _addRecordServer(request, medicion);
        }
      });
      _actualizaMedicionesCab();
      setState(() {});
    }
  }

  void _addRecordServer(request, medicion) async {
    _idCab = 0;
    Response response = await ApiHelper.post(
      '/api/ControlDePozoEMBLLES',
      request,
    );

    if (!response.isSuccess) {
      _poneenviado2(medicion);
    } else {
      var body = response.result;
      var decodedJson = jsonDecode(body);
      var medicioncab = MedicionCabecera.fromJson(decodedJson);
      _idCab = medicioncab.idControlPozo;
      _addRecordsDetallesServer(medicion);
      _poneenviado1(medicion);
    }
  }

  void _poneenviado1(MedicionCabecera medicion) {
    MedicionCabecera medicioncab = MedicionCabecera(
        idControlPozo: medicion.idControlPozo,
        bateria: medicion.bateria,
        pozo: medicion.pozo,
        fecha: medicion.fecha,
        ql: medicion.ql,
        qo: medicion.qo,
        qw: medicion.qw,
        qg: medicion.qg,
        wcLibre: medicion.wcLibre,
        wcEmulc: medicion.wcEmulc,
        wcTotal: medicion.wcTotal,
        sales: medicion.sales,
        gor: medicion.gor,
        t: medicion.t,
        validacionControl: medicion.validacionControl,
        prTbg: medicion.prTbg,
        prLinea: medicion.prLinea,
        prCsg: medicion.prCsg,
        regimenOperacion: medicion.regimenOperacion,
        aibCarrera: medicion.aibCarrera,
        bespip: medicion.bespip,
        pcpTorque: medicion.pcpTorque,
        observaciones: medicion.observaciones,
        validadoSupervisor: medicion.validadoSupervisor,
        userIdInput: medicion.userIdInput,
        userIDValida: medicion.userIDValida,
        caudalInstantaneo: medicion.caudalInstantaneo,
        caudalMedio: medicion.caudalMedio,
        lecturaAcumulada: medicion.lecturaAcumulada,
        presionBDP: medicion.presionBDP,
        presionAntFiltro: medicion.presionAntFiltro,
        presionEC: medicion.presionEC,
        ingresoDatos: medicion.ingresoDatos,
        reenvio: medicion.reenvio,
        muestra: medicion.muestra,
        fechaCarga: DateTime.now().toIso8601String(),
        idUserValidaMuestra: medicion.idUserValidaMuestra,
        idUserImputSoft: medicion.idUserImputSoft,
        volt: medicion.volt,
        amper: medicion.amper,
        temp: medicion.temp,
        fechaCargaAPP: DateTime.now().toIso8601String(),
        enviado: 1);

    DBMedicionesCabecera.update(medicioncab);

    Map<String, dynamic> request2 = {
      'codigopozo': _pozo.codigopozo,
      'codigobateria': _pozo.codigobateria,
      'descripcion': _pozo.descripcion,
      'fechaalta': _pozo.fechaalta,
      'activo': _pozo.activo,
      'ultimalectura': _pozo.ultimalectura,
      'latitud': _pozo.latitud,
      'longitud': _pozo.longitud,
      'qrcode': _pozo.qrcode,
      'observaciones': _pozo.observaciones,
      'tipopozo': _pozo.tipopozo,
      'sistemaExtraccion': _pozo.sistemaExtraccion,
      'cuenca': _pozo.cuenca,
      'idProvincia': _pozo.idProvincia,
      'cota': _pozo.cota,
      'profundidad': _pozo.profundidad,
      'vidaUtil': _pozo.vidaUtil,
    };

    _ponefechaultimalectura(request2);
  }

  void _poneenviado2(MedicionCabecera medicion) {
    MedicionCabecera medicioncab = MedicionCabecera(
        idControlPozo: medicion.idControlPozo,
        bateria: medicion.bateria,
        pozo: medicion.pozo,
        fecha: medicion.fecha,
        ql: medicion.ql,
        qo: medicion.qo,
        qw: medicion.qw,
        qg: medicion.qg,
        wcLibre: medicion.wcLibre,
        wcEmulc: medicion.wcEmulc,
        wcTotal: medicion.wcTotal,
        sales: medicion.sales,
        gor: medicion.gor,
        t: medicion.t,
        validacionControl: medicion.validacionControl,
        prTbg: medicion.prTbg,
        prLinea: medicion.prLinea,
        prCsg: medicion.prCsg,
        regimenOperacion: medicion.regimenOperacion,
        aibCarrera: medicion.aibCarrera,
        bespip: medicion.bespip,
        pcpTorque: medicion.pcpTorque,
        observaciones: medicion.observaciones,
        validadoSupervisor: medicion.validadoSupervisor,
        userIdInput: medicion.userIdInput,
        userIDValida: medicion.userIDValida,
        caudalInstantaneo: medicion.caudalInstantaneo,
        caudalMedio: medicion.caudalMedio,
        lecturaAcumulada: medicion.lecturaAcumulada,
        presionBDP: medicion.presionBDP,
        presionAntFiltro: medicion.presionAntFiltro,
        presionEC: medicion.presionEC,
        ingresoDatos: medicion.ingresoDatos,
        reenvio: medicion.reenvio,
        muestra: medicion.muestra,
        fechaCarga: medicion.fechaCarga,
        idUserValidaMuestra: medicion.idUserValidaMuestra,
        idUserImputSoft: medicion.idUserImputSoft,
        volt: medicion.volt,
        amper: medicion.amper,
        temp: medicion.temp,
        fechaCargaAPP: medicion.fechaCargaAPP,
        enviado: 2);
    DBMedicionesCabecera.update(medicioncab);
  }

  void _addRecordsDetallesServer(MedicionCabecera medicion) async {
    List<PozosControle> _pozoscontrolesselected = [];
    widget.pozoscontroles.forEach((pozoscontrol) {
      if (pozoscontrol.codigopozo == medicion.pozo) {
        _pozoscontrolesselected.add(pozoscontrol);
      }
    });
    if (_pozoscontrolesselected.length > 0) {
      _pozoscontrolesselected.forEach((_pozocontrolselected) {
        _pozocontrolselected.idformula == 1
            ? _valor = (medicion.regimenOperacion)!.toDouble()
            : _pozocontrolselected.idformula == 2
                ? _valor = (medicion.pcpTorque)!.toDouble()
                : _pozocontrolselected.idformula == 3
                    ? _valor = (medicion.regimenOperacion)!.toDouble()
                    : _pozocontrolselected.idformula == 4
                        ? _valor = (medicion.aibCarrera)!.toDouble()
                        : _pozocontrolselected.idformula == 5
                            ? _valor = (medicion.regimenOperacion)!.toDouble()
                            : _pozocontrolselected.idformula == 6
                                ? _valor = (medicion.bespip)!.toDouble()
                                : _pozocontrolselected.idformula == 7
                                    ? _valor = (medicion.amper)!.toDouble()
                                    : _pozocontrolselected.idformula == 8
                                        ? _valor = (medicion.volt)!.toDouble()
                                        : _pozocontrolselected.idformula == 9
                                            ? _valor = (0.0).toDouble()
                                            : _pozocontrolselected.idformula ==
                                                    10
                                                ? _valor =
                                                    (medicion.temp)!.toDouble()
                                                : _valor = (0.0).toDouble();

        Map<String, dynamic> request3 = {
          'idcontrolformula': 0,
          'idcontrolcab': _idCab,
          'idpozo': medicion.pozo,
          'idformula': _pozocontrolselected.idformula,
          'valor': _valor,
          'fechaapp': DateTime.now().toString(),
        };
        if (_valor > 0) {
          _grabadetalle(request3);
        }
      });
    }
  }

  void _ponefechaultimalectura(request2) async {
    Response response =
        await ApiHelper.put('/api/Pozo/', _pozo.codigopozo, request2);

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
  }

  void _grabadetalle(Map<String, dynamic> request3) async {
    Response response =
        await ApiHelper.post('/api/ControlPozoValoresFormulas', request3);

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
  }
}

Widget _noContent() {
  return Center(
    child: Container(
      margin: EdgeInsets.all(20),
      child: Text(
        '',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _noContent2() {
  return Center(
    child: Container(
      margin: EdgeInsets.all(20),
      child: Text(
        'No hay mediciones cargadas',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
