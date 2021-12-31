import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/models/pozo.dart';
import 'package:psenergy_app/models/pozoscontrole.dart';
import 'package:psenergy_app/models/pozosformula.dart';
import 'package:psenergy_app/models/usuario.dart';

class MedicionScreen extends StatefulWidget {
  final Usuario user;
  final Pozo pozo;
  final List<PozosFormula> pozosformulas;
  final List<PozosControle> pozoscontroles;

  MedicionScreen(
      {required this.user,
      required this.pozo,
      required this.pozosformulas,
      required this.pozoscontroles});

  @override
  _MedicionScreenState createState() => _MedicionScreenState();
}

class _MedicionScreenState extends State<MedicionScreen> {
  Pozo _pozo = new Pozo(
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

  List<PozosControle> _pozoscontroles = [];

  bool _mostrarRPM = false;
  bool _mostrarTorque = false;
  bool _mostrarGPM = false;
  bool _mostrarCarrera = false;
  bool _mostrarFrecuencia = false;
  bool _mostrarPip = false;
  bool _mostrarAmp = false;
  bool _mostrarVolt = false;
  bool _mostrarOrificio = false;
  bool _mostrarTemperatura = false;

  String _prtbg = '';
  String _prtbgError = '';
  bool _prtbgShowError = false;
  TextEditingController _prtbgController = TextEditingController();

  String _prlinea = '';
  String _prlineaError = '';
  bool _prlineaShowError = false;
  TextEditingController _prlineaController = TextEditingController();

  String _prcsg = '';
  String _prcsgError = '';
  bool _prcsgShowError = false;
  TextEditingController _prcsgController = TextEditingController();

  String _ql = '';
  String _qlError = '';
  bool _qlShowError = false;
  TextEditingController _qlController = TextEditingController();

  String _qg = '';
  String _qgError = '';
  bool _qgShowError = false;
  TextEditingController _qgController = TextEditingController();

  String _caudalinst = '';
  String _caudalinstError = '';
  bool _caudalinstShowError = false;
  TextEditingController _caudalinstController = TextEditingController();

  String _lecturaacumulada = '';
  String _lecturaacumuladaError = '';
  bool _lecturaacumuladaShowError = false;
  TextEditingController _lecturaacumuladaController = TextEditingController();

  String _presionantesdelfiltro = '';
  String _presionantesdelfiltroError = '';
  bool _presionantesdelfiltroShowError = false;
  TextEditingController _presionantesdelfiltroController =
      TextEditingController();

  String _observaciones = '';
  String _observacionesError = '';
  bool _observacionesShowError = false;
  TextEditingController _observacionesController = TextEditingController();

  String _tiempo = '';
  String _tiempoError = '';
  bool _tiempoShowError = false;
  TextEditingController _tiempoController = TextEditingController();

  String _rpm = '';
  String _rpmError = '';
  bool _rpmShowError = false;
  TextEditingController _rpmController = TextEditingController();

  String _torque = '';
  String _torqueError = '';
  bool _torqueShowError = false;
  TextEditingController _torqueController = TextEditingController();

  String _gpm = '';
  String _gpmError = '';
  bool _gpmShowError = false;
  TextEditingController _gpmController = TextEditingController();

  String _carrera = '';
  String _carreraError = '';
  bool _carreraShowError = false;
  TextEditingController _carreraController = TextEditingController();

  String _frecuencia = '';
  String _frecuenciaError = '';
  bool _frecuenciaShowError = false;
  TextEditingController _frecuenciaController = TextEditingController();

  String _pip = '';
  String _pipError = '';
  bool _pipShowError = false;
  TextEditingController _pipController = TextEditingController();

  String _amp = '';
  String _ampError = '';
  bool _ampShowError = false;
  TextEditingController _ampController = TextEditingController();

  String _volt = '';
  String _voltError = '';
  bool _voltShowError = false;
  TextEditingController _voltController = TextEditingController();

  String _orificio = '';
  String _orificioError = '';
  bool _orificioShowError = false;
  TextEditingController _orificioController = TextEditingController();

  String _temperatura = '';
  String _temperaturaError = '';
  bool _temperaturaShowError = false;
  TextEditingController _temperaturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pozo = widget.pozo;
    widget.pozoscontroles.forEach((pozoscontrol) {
      if (pozoscontrol.codigopozo == _pozo.codigopozo) {
        _pozoscontroles.add(pozoscontrol);
        if (pozoscontrol.idformula == 1) {
          _mostrarRPM = true;
        }
        if (pozoscontrol.idformula == 2) {
          _mostrarTorque = true;
        }
        if (pozoscontrol.idformula == 3) {
          _mostrarGPM = true;
        }
        if (pozoscontrol.idformula == 4) {
          _mostrarCarrera = true;
        }
        if (pozoscontrol.idformula == 5) {
          _mostrarFrecuencia = true;
        }
        if (pozoscontrol.idformula == 6) {
          _mostrarPip = true;
        }
        if (pozoscontrol.idformula == 7) {
          _mostrarAmp = true;
        }
        if (pozoscontrol.idformula == 8) {
          _mostrarVolt = true;
        }
        if (pozoscontrol.idformula == 9) {
          _mostrarOrificio = true;
        }
        if (pozoscontrol.idformula == 10) {
          _mostrarTemperatura = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe9dac2),
        appBar: AppBar(
          title: Text("Nueva medición"),
          backgroundColor: Color(0xff9a6a2e),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Pozo: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF781f1e),
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(_pozo.descripcion.toString(),
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xFF3c2920),
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Tipo Pozo: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF781f1e),
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(_pozo.tipopozo.toString(),
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xFF3c2920),
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Fecha: ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF781f1e),
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(
                              '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(0xFF3c2920),
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _showprtbg(),
                    _showprlinea(),
                    _showprcsg(),
                    widget.pozo.tipopozo.toLowerCase() == 'productor'
                        ? _showql()
                        : Container(),
                    widget.pozo.tipopozo.toLowerCase() == 'productor'
                        ? _showqg()
                        : Container(),
                    widget.pozo.tipopozo.toLowerCase() == 'productor'
                        ? _showtiempo()
                        : Container(),
                    widget.pozo.tipopozo.toLowerCase() != 'productor'
                        ? _showcaudalinst()
                        : Container(),
                    widget.pozo.tipopozo.toLowerCase() != 'productor'
                        ? _showlecturaacumulada()
                        : Container(),
                    widget.pozo.tipopozo.toLowerCase() != 'productor'
                        ? _showpresionantesdelfiltro()
                        : Container(),
                    _mostrarRPM ? _showRPM() : Container(),
                    _mostrarTorque ? _showTorque() : Container(),
                    _mostrarGPM ? _showGPM() : Container(),
                    _mostrarCarrera ? _showCarrera() : Container(),
                    _mostrarFrecuencia ? _showFrecuencia() : Container(),
                    _mostrarPip ? _showPip() : Container(),
                    _mostrarAmp ? _showAmp() : Container(),
                    _mostrarVolt ? _showVolt() : Container(),
                    _mostrarOrificio ? _showOrificio() : Container(),
                    _mostrarTemperatura ? _showTemperatura() : Container(),
                    _showobservaciones(),
                    SizedBox(
                      height: 20,
                    ),
                    _showButton(),
                  ],
                ),
              )),
        ));
  }

  Widget _showprtbg() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.compress, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Pr Tgb:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _prtbgController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Pr Tbg...',
                  errorText: _prtbgShowError ? _prtbgError : null,
                ),
                onChanged: (value) {
                  _prtbg = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("kg/cm²"),
          ],
        ),
      ),
    );
  }

  Widget _showprlinea() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.compare_sharp, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Pr Línea:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _prlineaController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Pr Línea...',
                  errorText: _prlineaShowError ? _prlineaError : null,
                ),
                onChanged: (value) {
                  _prlinea = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("kg/cm²"),
          ],
        ),
      ),
    );
  }

  Widget _showprcsg() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.compare_arrows, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Pr Csg:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _prcsgController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Pr Csg...',
                  errorText: _prcsgShowError ? _prcsgError : null,
                ),
                onChanged: (value) {
                  _prcsg = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("kg/cm²"),
          ],
        ),
      ),
    );
  }

  Widget _showql() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.water, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Ql:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _qlController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Ql...',
                  errorText: _qlShowError ? _qlError : null,
                ),
                onChanged: (value) {
                  _ql = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("m³/d"),
          ],
        ),
      ),
    );
  }

  Widget _showqg() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.waves, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Qg:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _qlController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Qg...',
                  errorText: _qgShowError ? _qgError : null,
                ),
                onChanged: (value) {
                  _qg = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("m³/d"),
          ],
        ),
      ),
    );
  }

  Widget _showtiempo() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.hourglass_bottom, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tiempo:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _tiempoController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Tiempo...',
                  errorText: _tiempoShowError ? _tiempoError : null,
                ),
                onChanged: (value) {
                  _tiempo = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("horas"),
          ],
        ),
      ),
    );
  }

  Widget _showgpm() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.av_timer, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "GPM:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _gpmController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa GPM...',
                  errorText: _gpmShowError ? _gpmError : null,
                ),
                onChanged: (value) {
                  _gpm = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(""),
          ],
        ),
      ),
    );
  }

  Widget _showcarrera() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.run_circle, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Carrera:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _carreraController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Carrera...',
                  errorText: _carreraShowError ? _carreraError : null,
                ),
                onChanged: (value) {
                  _carrera = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(""),
          ],
        ),
      ),
    );
  }

  Widget _showcaudalinst() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.air, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Caudal Inst.:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _caudalinstController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Caudal Inst...',
                  errorText: _caudalinstShowError ? _caudalinstError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("m³/h"),
          ],
        ),
      ),
    );
  }

  Widget _showlecturaacumulada() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.add_task, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Lectura Acumulada.:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _lecturaacumuladaController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Lectura Acumulada...',
                  errorText: _lecturaacumuladaShowError
                      ? _lecturaacumuladaError
                      : null,
                ),
                onChanged: (value) {
                  _lecturaacumulada = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("m³"),
          ],
        ),
      ),
    );
  }

  Widget _showpresionantesdelfiltro() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.restore, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Presión antes del filtro:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _presionantesdelfiltroController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Presión antes del filtro...',
                  errorText: _presionantesdelfiltroShowError
                      ? _presionantesdelfiltroError
                      : null,
                ),
                onChanged: (value) {
                  _presionantesdelfiltro = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text("kg/cm³"),
          ],
        ),
      ),
    );
  }

  Widget _showobservaciones() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.list, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Observaciones:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _observacionesController,
                maxLines: 3,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Observaciones...',
                  errorText:
                      _observacionesShowError ? _observacionesError : null,
                ),
                onChanged: (value) {
                  _observaciones = value;
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(""),
          ],
        ),
      ),
    );
  }

  Widget _showRPM() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.speed, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "RPM:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _rpmController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa RPM...',
                  errorText: _rpmShowError ? _rpmError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showTorque() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.sync_disabled, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Torque:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _torqueController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Torque...',
                  errorText: _torqueShowError ? _torqueError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showGPM() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.speed, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "GPM:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _gpmController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa GPM...',
                  errorText: _gpmShowError ? _gpmError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showCarrera() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.run_circle, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Carrera:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _carreraController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Carrera...',
                  errorText: _carreraShowError ? _carreraError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showFrecuencia() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.bolt, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Frecuencia:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _frecuenciaController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Frecuencia...',
                  errorText: _frecuenciaShowError ? _frecuenciaError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showPip() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.stacked_bar_chart, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Pip:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _pipController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Pip...',
                  errorText: _pipShowError ? _pipError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showAmp() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.motion_photos_auto, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Amp:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _ampController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Amp...',
                  errorText: _ampShowError ? _ampError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showVolt() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.battery_charging_full, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Volt:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _voltController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Volt...',
                  errorText: _voltShowError ? _voltError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showOrificio() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.circle, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Orificio:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _orificioController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Orificio...',
                  errorText: _orificioShowError ? _orificioError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showTemperatura() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: EdgeInsets.all(5),
      child: Expanded(
        child: Row(
          children: [
            Icon(Icons.thermostat, color: Color(0xFF781f1e)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Temperatura:",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF781f1e)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: _temperaturaController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Temperatura...',
                  errorText: _temperaturaShowError ? _temperaturaError : null,
                ),
                onChanged: (value) {
                  _caudalinst = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Enviar'),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF9a6a2e),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _save(),
            ),
          ),
        ],
      ),
    );
  }

  _save() {}
}
