import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/helpers/dbmedicionescabecera_helper.dart';
import 'package:psenergy_app/models/medicioncabecera.dart';
import 'package:psenergy_app/models/medicioncabeceraserver.dart';
import 'package:psenergy_app/models/pozo.dart';
import 'package:psenergy_app/models/pozoscontrole.dart';
import 'package:psenergy_app/models/pozosformula.dart';
import 'package:psenergy_app/models/response.dart';
import 'package:psenergy_app/models/usuario.dart';

class MedicionScreen extends StatefulWidget {
  final Usuario user;
  final Pozo pozo;
  final List<Pozo> pozos;
  final List<PozosFormula> pozosformulas;
  final List<PozosControle> pozoscontroles;

  MedicionScreen(
      {required this.user,
      required this.pozo,
      required this.pozos,
      required this.pozosformulas,
      required this.pozoscontroles});

  @override
  _MedicionScreenState createState() => _MedicionScreenState();
}

class _MedicionScreenState extends State<MedicionScreen> {
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

  List<PozosControle> _pozoscontroles = [];
  List<PozosControle> _pozoscontrolesselected = [];
  List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];
  bool _showLoader = false;
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
  int _idMedicion = 0;
  int _idCab = 0;
  double _valor = 0;

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
        body: Stack(
          children: [
            SingleChildScrollView(
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
            ),
            // _showLoader
            //     ? LoaderComponent(
            //         text: 'Por favor espere...',
            //       )
            //     : Container(),
          ],
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                controller: _qgController,
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa RPM...',
                  errorText: _rpmShowError ? _rpmError : null,
                ),
                onChanged: (value) {
                  _rpm = value;
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Torque...',
                  errorText: _torqueShowError ? _torqueError : null,
                ),
                onChanged: (value) {
                  _torque = value;
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Frecuencia...',
                  errorText: _frecuenciaShowError ? _frecuenciaError : null,
                ),
                onChanged: (value) {
                  _frecuencia = value;
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Pip...',
                  errorText: _pipShowError ? _pipError : null,
                ),
                onChanged: (value) {
                  _pip = value;
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Amp...',
                  errorText: _ampShowError ? _ampError : null,
                ),
                onChanged: (value) {
                  _amp = value;
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Volt...',
                  errorText: _voltShowError ? _voltError : null,
                ),
                onChanged: (value) {
                  _volt = value;
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Orificio...',
                  errorText: _orificioShowError ? _orificioError : null,
                ),
                onChanged: (value) {
                  _orificio = value;
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ingresa Temperatura...',
                  errorText: _temperaturaShowError ? _temperaturaError : null,
                ),
                onChanged: (value) {
                  _temperatura = value;
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

  _save() async {
    if (!validateFields()) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'No ha ingresado ninguna medición',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
    _addRecord();
  }

  bool validateFields() {
    bool isValid = true;
    if (_prtbg == "" &&
        _prlinea == "" &&
        _prcsg == "" &&
        _ql == "" &&
        _qg == "" &&
        _caudalinst == "" &&
        _lecturaacumulada == "" &&
        _presionantesdelfiltro == "" &&
        _observaciones == "" &&
        _tiempo == "" &&
        _rpm == "" &&
        _torque == "" &&
        _gpm == "" &&
        _carrera == "" &&
        _frecuencia == "" &&
        _pip == "" &&
        _amp == "" &&
        _volt == "" &&
        _orificio == "" &&
        _temperatura == "") {
      isValid = false;
    }
    setState(() {});
    return isValid;
  }

  void _addRecord() async {
    setState(() {
      _showLoader = true;
    });

//********************************************************************
//********************* GRABA MEDICION EN TABLA LOCAL ****************
//********************************************************************
    await _actualizaMedicionesCab();

    if (_medicionesCabCompleta.length == 0) {
      _idMedicion = 1;
    } else {
      _idMedicion = 0;
      _medicionesCabCompleta.forEach((element) {
        if (element.idControlPozo > _idMedicion) {
          _idMedicion = element.idControlPozo;
        }
      });
      _idMedicion = _idMedicion + 1;
    }

    MedicionCabecera medicionCabecera = MedicionCabecera(
        idControlPozo: _idMedicion,
        bateria: widget.pozo.codigobateria,
        pozo: widget.pozo.codigopozo,
        fecha:
            DateTime.now().add(Duration(days: 0)).toString().substring(0, 10),
        ql: _ql == "" ? 0 : double.parse(_ql),
        qo: 0,
        qw: 0,
        qg: _qg == "" ? 0 : double.parse(_qg),
        wcLibre: 0,
        wcEmulc: 0,
        wcTotal: 0,
        sales: 0,
        gor: 0,
        t: _tiempo == "" ? 0 : double.parse(_tiempo),
        validacionControl: '',
        prTbg: _prtbg == "" ? 0 : double.parse(_prtbg),
        prLinea: _prlinea == "" ? 0 : double.parse(_prlinea),
        prCsg: _prcsg == "" ? 0 : double.parse(_prcsg),
        regimenOperacion: _frecuencia == "" ? 0 : double.parse(_frecuencia),
        aibCarrera: _carrera == "" ? 0 : double.parse(_carrera),
        bespip: _pip == "" ? 0 : double.parse(_pip),
        pcpTorque: _torque == "" ? 0 : double.parse(_torque),
        observaciones: _observaciones,
        validadoSupervisor: 0,
        userIdInput: widget.user.idUser,
        userIDValida: 0,
        caudalInstantaneo: _caudalinst == "" ? 0 : double.parse(_caudalinst),
        caudalMedio: 0,
        lecturaAcumulada:
            _lecturaacumulada == "" ? 0 : double.parse(_lecturaacumulada),
        presionBDP: _prtbg == "" ? 0 : double.parse(_prtbg),
        presionAntFiltro: _presionantesdelfiltro == ""
            ? 0
            : double.parse(_presionantesdelfiltro),
        presionEC: _prcsg == "" ? 0 : double.parse(_prcsg),
        ingresoDatos: 'APP',
        reenvio: 0,
        muestra: 'NO',
        fechaCarga: DateTime.now().toString(),
        idUserValidaMuestra: 0,
        idUserImputSoft: 0,
        volt: _volt == "" ? 0 : double.parse(_volt),
        amper: _amp == "" ? 0 : double.parse(_amp),
        temp: _temperatura == "" ? 0 : double.parse(_temperatura),
        fechaCargaAPP: '',
        enviado: 0);

    DBMedicionesCabecera.insertMedicionCab(medicionCabecera);

    await _actualizaMedicionesCab();
    setState(() {
      _showLoader = false;
    });

//********************************************************************
//************ RECORRE TABLA LOCAL PARA GRABAR EN SERVIDOR ***********
//************ Y PONER ENVIADO = 1 EN TABLA LOCAL ********************
//********************************************************************

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

          //_addRecordsDetallesServer(medicion);
        }
      });
    }
    Navigator.pop(context, 'yes');
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

  Future<void> _actualizaMedicionesCab() async {
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
  }
}
