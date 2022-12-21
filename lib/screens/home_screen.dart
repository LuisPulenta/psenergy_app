import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';
import 'package:psenergy_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Usuario user;
  final List<Area> areas;
  final List<Yacimiento> yacimientos;
  final List<Bateria> baterias;
  final List<Pozo> pozos;
  final List<PozosFormula> pozosformulas;
  final List<PozosControle> pozoscontroles;

  const HomeScreen(
      {Key? key,
      required this.user,
      required this.areas,
      required this.yacimientos,
      required this.baterias,
      required this.pozos,
      required this.pozosformulas,
      required this.pozoscontroles})
      : super(key: key);

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

  MedicionCabecera medicionSelected = MedicionCabecera(
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
      enviado: 0,
      alarma: 0);

  bool _showLoader = false;
  String _conectadodesde = '';
  String _validohasta = '';
  String _ultimaactualizacion = '';
  List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];

  String _areaSelected = 'Seleccione un Área...';
  final String _areaError = '';
  final bool _areaShowError = false;
  List<Area> _areas = [];

  String _yacimientoSelected = 'Seleccione un Yacimiento...';
  final String _yacimientoError = '';
  final bool _yacimientoShowError = false;
  List<Yacimiento> _yacimientos = [];

  String _bateriaSelected = 'Seleccione una Batería...';
  final String _bateriaError = '';
  final bool _bateriaShowError = false;
  List<Bateria> _baterias = [];

  Pozo _pozoSelected = Pozo(
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

  String titulo = "Nueva medición";

  @override
  void initState() {
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
      backgroundColor: const Color(0xffe9dac2),
      // appBar: AppBar(
      //   //title: (Text("PSEnergy App")),
      //   title: (Text(Titulo)),
      //   centerTitle: true,
      //   backgroundColor: Color(0xff9a6a2e),
      // ),
      body: Stack(
        children: [
          Container(
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
            child: TabBarView(
              controller: _tabController,
              physics: const AlwaysScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AppBar(
                      title: (const Text("Nueva medición")),
                      centerTitle: true,
                      backgroundColor: const Color(0xff9a6a2e),
                    ),
                    widget.areas.isNotEmpty
                        ? _showAreas()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'No hay áreas cargadas en el Sistema. Asegúrese de tener Internet y volver a conectarse para actualizar los Datos de la App necesarios para su funcionamiento.'),
                          ),
                    widget.yacimientos.isNotEmpty
                        ? _showYacimientos()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'No hay yacimientos cargados en el Sistema. Asegúrese de tener Internet y volver a conectarse para actualizar los Datos de la App necesarios para su funcionamiento.'),
                          ),
                    widget.baterias.isNotEmpty
                        ? _showBaterias()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                'No hay baterías cargadas en el Sistema. Asegúrese de tener Internet y volver a conectarse para actualizar los Datos de la App necesarios para su funcionamiento.'),
                          ),
                    Expanded(
                      child: _pozos.isEmpty ? _noContent() : _showPozos(),
                    )
                  ],
                ),
                Column(
                  children: [
                    AppBar(
                      title: (const Text("Ultimas mediciones      ")),
                      actions: [
                        ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.done,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              Icon(
                                Icons.done,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: const Size(50, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () async {
                            await _deRojoAGris();
                            setState(() {});
                          },
                        ),
                      ],
                      centerTitle: true,
                      backgroundColor: const Color(0xff9a6a2e),
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
                        title: (const Text("Información")),
                        centerTitle: true,
                        backgroundColor: const Color(0xff9a6a2e),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(children: [
                          Center(
                            child: Text(
                              _user.usrlogin.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              _user.apellidonombre,
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Conectado desde:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                _conectadodesde == ''
                                    ? ''
                                    : DateFormat('dd/MM/yyyy HH:mm').format(
                                        DateTime.parse(_conectadodesde)),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Válido hasta:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                _validohasta == ''
                                    ? ''
                                    : DateFormat('dd/MM/yyyy HH:mm')
                                        .format(DateTime.parse(_validohasta)),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Ultima actualización de Usuarios:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                _ultimaactualizacion == ''
                                    ? ''
                                    : DateFormat('dd/MM/yyyy HH:mm').format(
                                        DateTime.parse(_ultimaactualizacion)),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: const [
                              Text(
                                "Versión:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                Constants.version,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.password),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('ACTUALIZAR CONTRASEÑA'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF9a6a2e),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () => _actualizarPassword(),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('BORRAR MEDICIONES LOCALES'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () async {
                              _password = '';
                              _result2 = "no";

                              await _borrarMedicionesLocales();
                              if (_result2 == 'yes') {
                                await _actualizaMedicionesCab2();
                              }
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.keyboard),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('CONTACTO KEYPRESS'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF9a6a2e),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () => _contacto(),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.exit_to_app),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('CERRAR SESION'),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF9a6a2e),
                              minimumSize: const Size(double.infinity, 50),
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
              ? const LoaderComponent(
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
            indicatorColor: const Color(0xff9a6a2e),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            // isScrollable: false,
            labelColor: const Color(0xff9a6a2e),
            unselectedLabelColor: Colors.grey,
            labelPadding: const EdgeInsets.all(10),
            tabs: <Widget>[
              Tab(
                child: Column(
                  children: const [
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
                  children: const [
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
                  children: const [
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
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _contacto() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ContactoScreen()));
  }

  void _getprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _conectadodesde = prefs.getString('conectadodesde').toString();
    _validohasta = prefs.getString('validohasta').toString();
    _ultimaactualizacion = prefs.getString('ultimaactualizacion').toString();
    setState(() {});
  }

  void _loadData() async {
    await _getAreas();
    await _actualizaMedicionesCab();
  }

  Future<void> _getAreas() async {
    setState(() {
      _areas = widget.areas;
    });
  }

  Widget _showAreas() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: _areas.isEmpty
          ? const Text('Cargando áreas...')
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
    list.add(const DropdownMenuItem(
      child: Text('Seleccione un Área...'),
      value: 'Seleccione un Área...',
      //value: 0,
    ));

    for (var area in _areas) {
      list.add(DropdownMenuItem(
        child: Text(area.nombrearea),
        value: area.nombrearea,
      ));
    }

    return list;
  }

  Widget _showYacimientos() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: _yacimientos.isEmpty
          ? const Text('')
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
    list.add(const DropdownMenuItem(
      child: Text('Seleccione un Yacimiento...'),
      value: 'Seleccione un Yacimiento...',
    ));

    for (var yacimiento in _yacimientos) {
      list.add(DropdownMenuItem(
        child: Text(yacimiento.nombreyacimiento),
        value: yacimiento.nombreyacimiento,
      ));
    }

    return list;
  }

  Future<void> _getYacimientos(String area) async {
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
      padding: const EdgeInsets.all(10),
      child: _baterias.isEmpty
          ? const Text('')
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
    list.add(const DropdownMenuItem(
      child: Text('Seleccione una Batería...'),
      value: 'Seleccione una Batería...',
    ));

    for (var bateria in _baterias) {
      list.add(DropdownMenuItem(
        child: Text(bateria.descripcion),
        value: bateria.codigobateria,
      ));
    }

    return list;
  }

  Future<void> _getBaterias(String yacimiento) async {
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

  Future<void> _getPozos(String bateria) async {
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
          color: const Color(0xFFe9dac2),
          shadowColor: Colors.white,
          elevation: 10,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
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
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text("Pozo: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Expanded(
                                      child: Text(e.descripcion.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                    ),
                                    const Text("Tipo Pozo: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Expanded(
                                      child: Text(e.tipopozo.toString(),
                                          style: const TextStyle(
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
                  const Icon(Icons.arrow_forward_ios),
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
                  opcion: 1,
                  alarma: 0,
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
    return _medicionesCab.isEmpty ? _noContent2() : _getListView();
  }

  Widget _getListView() {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Icon(Icons.done_all, color: Colors.green),
            ),
            Text('Med. enviada al Servidor'),
          ],
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Icon(Icons.done, color: Colors.grey),
            ),
            Text('Med. grabada local sin enviar al Servidor'),
          ],
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Icon(Icons.done, color: Colors.red),
            ),
            Text('Med. que no se puede enviar al Servidor'),
          ],
        ),
        RefreshIndicator(
          onRefresh: _grabaMediciones,
          child: SizedBox(
            height: 550,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: _medicionesCab.map((e) {
                return Card(
                  color: const Color(0xFFe9dac2),
                  shadowColor: Colors.white,
                  elevation: 10,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: InkWell(
                    onTap: () {
                      medicionSelected = e;
                      _goInfoMedicion(e);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  e.enviado == 1
                                      ? const Icon(Icons.done_all,
                                          color: Colors.green)
                                      : e.enviado == 0
                                          ? const Icon(Icons.done,
                                              color: Colors.grey)
                                          : const Icon(Icons.done,
                                              color: Colors.red),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      e.alarma! > 0
                                          ? const Text("Alarma: ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF781f1e),
                                                fontWeight: FontWeight.bold,
                                              ))
                                          : Container(),
                                      const Text("N° Med.: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const Text("Batería: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const Text("Usuario: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      e.fechaCargaAPP == ""
                                          ? Container()
                                          : const Text("Fec. sub.:",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF781f1e),
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      e.alarma! > 0
                                          ? Text(e.alarma.toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ))
                                          : Container(),
                                      Text(e.idControlPozo.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                      Text(e.bateria,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                      Text(e.userIdInput.toString(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                      e.fechaCargaAPP == ""
                                          ? Container()
                                          : Text(
                                              //e.fechaCargaAPP,
                                              DateFormat('dd/MM/yyyy').format(
                                                  DateTime.parse(
                                                      e.fechaCargaAPP)),
                                              style: const TextStyle(
                                                fontSize: 12,
                                              )),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      e.alarma! > 0
                                          ? const Text(" ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF781f1e),
                                                fontWeight: FontWeight.bold,
                                              ))
                                          : Container(),
                                      const Text("Fecha: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      const Text("Pozo: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF781f1e),
                                            fontWeight: FontWeight.bold,
                                          )),
                                      e.fechaCargaAPP == ""
                                          ? Container()
                                          : const Text("",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF781f1e),
                                                fontWeight: FontWeight.bold,
                                              )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      e.alarma! > 0
                                          ? const Text(" ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF781f1e),
                                                fontWeight: FontWeight.bold,
                                              ))
                                          : Container(),
                                      Text(e.fecha,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                      Text(e.pozo,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )),
                                      e.fechaCargaAPP == ""
                                          ? Container()
                                          : const Text("",
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
        ),
      ],
    );
  }

  void _goInfoMedicion(MedicionCabecera e) {}

  _borrarMedicionesLocales() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
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
                      const Text(
                        "Para borrar las mediciones locales de su Usuario debe escribir su contraseña",
                        style: TextStyle(fontSize: 14),
                      ),
                      const Text(""),
                      TextField(
                        obscureText: !_passwordShow,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Contraseña...',
                            labelText: 'Contraseña',
                            errorText:
                                _passwordShowError ? _passwordError : null,
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
                      children: const [
                        Icon(Icons.delete),
                        SizedBox(
                          width: 15,
                        ),
                        Text('BORRAR'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
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
                        for (var element in _medicionesCab) {
                          if (element.userIdInput == widget.user.idUser) {
                            DBMedicionesCabecera.delete(element);
                          }
                        }
                        _medicionesCab = [];
                        setState(() {});
                        _result2 = "yes";
                        Navigator.pop(context, 'yes');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CANCELAR'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF9a6a2e),
                      minimumSize: const Size(double.infinity, 50),
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
    return Future.delayed(const Duration(seconds: 0), () async {
      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
      for (var medicion in _medicionesCabCompleta) {
        if (DateTime.parse(medicion.fecha)
                .isBefore(DateTime.now().add(const Duration(days: -30))) &&
            medicion.enviado != 0) {
          DBMedicionesCabecera.delete(medicion);
        }
      }

      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();

      _medicionesCab = [];
      for (var medicion in _medicionesCabCompleta) {
        //if (medicion.userIdInput == widget.user.idUser) {
        _medicionesCab.add(medicion);
        //}
      }
      _medicionesCab.sort((b, a) {
        return a.idControlPozo
            .toString()
            .toLowerCase()
            .compareTo(b.idControlPozo.toString().toLowerCase());
      });

      var a1 = 1;
    });
  }

  Future<void> _actualizaMedicionesCab2() async {
    return Future.delayed(const Duration(seconds: 0), () async {
      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
      for (var medicion in _medicionesCabCompleta) {
        if (DateTime.parse(medicion.fecha)
                .isBefore(DateTime.now().add(const Duration(days: -30))) &&
            medicion.enviado != 0) {
          DBMedicionesCabecera.delete(medicion);
        }
      }

      _medicionesCabCompleta = await DBMedicionesCabecera.medicionescabecera();
      _medicionesCab = [];
      for (var medicion in _medicionesCabCompleta) {
        if (medicion.userIdInput == widget.user.idUser) {
          _medicionesCab.add(medicion);
        }
      }
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
      for (var medicion in _medicionesCab) {
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

          for (var pozo in widget.pozos) {
            if (pozo.codigopozo == medicion.pozo) {
              _pozo = pozo;
            }
          }
          _addRecordServer(request, medicion);
        }
      }
      await _actualizaMedicionesCab();

      var b = _medicionesCab;

      var c = 1;

      setState(() {});
    }
  }

//****************************************************************
//************************** _addRecordServer ********************
//****************************************************************

  void _addRecordServer(request, medicion) async {
    _idCab = 0;
    Response response = await ApiHelper.post(
      '/api/ControlDePozoEMBLLES',
      request,
    );

    if (response.isSuccess) {
      var body = response.result;

      var decodedJson = jsonDecode(body);

      var medicioncab = MedicionCabecera.fromJson(decodedJson);

      int nuevoidControlPozo = medicioncab.idControlPozo;

//------------------- Actualiza Tabla ControlDePozoAlarmas ----------------
      Map<String, dynamic> request2 = {
        'IDALARMA': medicion.alarma,
        'FECHACARGA': '',
        'PROVIENEIDCONTROL': 0,
        'POZO': '',
        'BATERIA': '',
        'IDUSUARIOCARGA': 0,
        'IDUSUARIOAPP': widget.user.idUser,
        'FECHAEJECUTADA': DateTime.now().toString(),
        'NUEVOIDCONTROL': nuevoidControlPozo,
        'OBSERVACION': '',
        'TAG': 1,
      };

      if (medicion.alarma > 0) {
        Response response2 = await ApiHelper.put(
          '/api/ControlDePozoAlarmas/',
          medicion.alarma.toString(),
          request2,
        );
      }
    }

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
        enviado: 1,
        alarma: 0);

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
        enviado: 2,
        alarma: 0);
    DBMedicionesCabecera.update(medicioncab);
  }

  void _poneenviado0(MedicionCabecera medicion) {
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
        enviado: 0,
        alarma: 0);
    DBMedicionesCabecera.update(medicioncab);
  }

  void _addRecordsDetallesServer(MedicionCabecera medicion) async {
    List<PozosControle> _pozoscontrolesselected = [];
    for (var pozoscontrol in widget.pozoscontroles) {
      if (pozoscontrol.codigopozo == medicion.pozo) {
        _pozoscontrolesselected.add(pozoscontrol);
      }
    }
    if (_pozoscontrolesselected.isNotEmpty) {
      for (var _pozocontrolselected in _pozoscontrolesselected) {
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
      }
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
            const AlertDialogAction(key: null, label: 'Aceptar'),
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
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
  }

  _deRojoAGris() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "Atención!!",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: const [
                      Text(
                        "Esta opción es SOLAMENTE para el caso de que Ud. está seguro que una medición que no haya sido subida al servidor y haya sido marcada con tilde ROJO, se vuelva a marcar con tilde GRIS para tratar de volver a subirla al Servidor.",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(""),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.refresh),
                          SizedBox(
                            width: 15,
                          ),
                          Text('ACEPTAR'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        for (MedicionCabecera medicion in _medicionesCab) {
                          if (medicion.enviado == 2) {
                            _poneenviado0(medicion);
                          }
                        }

                        setState(() {});
                        Navigator.pop(context, 'yes');
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CANCELAR'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF9a6a2e),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
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

  Widget _noContent() {
    return Center(
        child: _bateriaSelected != "Seleccione una Batería..." && _pozos.isEmpty
            ? Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  'No existen pozos para esta Batería',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  '',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
  }

  Widget _noContent2() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const Text(
              'No hay mediciones cargadas. ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text(
                'Toque para refrescar.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
