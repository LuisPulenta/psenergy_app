import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';
import 'package:psenergy_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicionScreen extends StatefulWidget {
  final Usuario user;
  final Pozo pozo;
  final List<Pozo> pozos;
  final List<PozosFormula> pozosformulas;
  final List<PozosControle> pozoscontroles;
  final int opcion;
  final int alarma;

  const MedicionScreen(
      {Key? key,
      required this.user,
      required this.pozo,
      required this.pozos,
      required this.pozosformulas,
      required this.pozoscontroles,
      required this.opcion,
      required this.alarma})
      : super(key: key);

  @override
  _MedicionScreenState createState() => _MedicionScreenState();
}

class _MedicionScreenState extends State<MedicionScreen> {
//*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************

  List<Alarma> _alarmas = [];

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

  final List<PozosControle> _pozoscontroles = [];
  List<MedicionCabecera> _medicionesCab = [];
  List<MedicionCabecera> _medicionesCabCompleta = [];
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
  String _validohasta = '';

  String _prtbg = '';
  final String _prtbgError = '';
  final bool _prtbgShowError = false;
  final TextEditingController _prtbgController = TextEditingController();

  String _prlinea = '';
  final String _prlineaError = '';
  final bool _prlineaShowError = false;
  final TextEditingController _prlineaController = TextEditingController();

  String _prcsg = '';
  final String _prcsgError = '';
  final bool _prcsgShowError = false;
  final TextEditingController _prcsgController = TextEditingController();

  String _ql = '';
  final String _qlError = '';
  final bool _qlShowError = false;
  final TextEditingController _qlController = TextEditingController();

  String _qg = '';
  final String _qgError = '';
  final bool _qgShowError = false;
  final TextEditingController _qgController = TextEditingController();

  String _caudalinst = '';
  final String _caudalinstError = '';
  final bool _caudalinstShowError = false;
  final TextEditingController _caudalinstController = TextEditingController();

  String _lecturaacumulada = '';
  final String _lecturaacumuladaError = '';
  final bool _lecturaacumuladaShowError = false;
  final TextEditingController _lecturaacumuladaController =
      TextEditingController();

  String _presionantesdelfiltro = '';
  final String _presionantesdelfiltroError = '';
  final bool _presionantesdelfiltroShowError = false;
  final TextEditingController _presionantesdelfiltroController =
      TextEditingController();

  String _observaciones = '';
  final String _observacionesError = '';
  final bool _observacionesShowError = false;
  final TextEditingController _observacionesController =
      TextEditingController();

  String _tiempo = '';
  final String _tiempoError = '';
  final bool _tiempoShowError = false;
  final TextEditingController _tiempoController = TextEditingController();

  final String _rpm = '';
  final String _rpmError = '';
  final bool _rpmShowError = false;
  final TextEditingController _rpmController = TextEditingController();

  String _torque = '';
  final String _torqueError = '';
  final bool _torqueShowError = false;
  final TextEditingController _torqueController = TextEditingController();

  final String _gpm = '';
  final String _gpmError = '';
  final bool _gpmShowError = false;
  final TextEditingController _gpmController = TextEditingController();

  String _carrera = '';
  final String _carreraError = '';
  final bool _carreraShowError = false;
  final TextEditingController _carreraController = TextEditingController();

  String _frecuencia = '';
  final String _frecuenciaError = '';
  final bool _frecuenciaShowError = false;
  final TextEditingController _frecuenciaController = TextEditingController();

  String _pip = '';
  final String _pipError = '';
  final bool _pipShowError = false;
  final TextEditingController _pipController = TextEditingController();

  String _amp = '';
  final String _ampError = '';
  final bool _ampShowError = false;
  final TextEditingController _ampController = TextEditingController();

  String _volt = '';
  final String _voltError = '';
  final bool _voltShowError = false;
  final TextEditingController _voltController = TextEditingController();

  String _orificio = '';
  final String _orificioError = '';
  final bool _orificioShowError = false;
  final TextEditingController _orificioController = TextEditingController();

  String _temperatura = '';
  final String _temperaturaError = '';
  final bool _temperaturaShowError = false;
  final TextEditingController _temperaturaController = TextEditingController();

//****************************************************************
//************************** INIT STATE **************************
//****************************************************************

  @override
  void initState() {
    super.initState();
    _getprefs();

    _pozo = widget.pozo;
    for (var pozoscontrol in widget.pozoscontroles) {
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
    }
  }

//****************************************************************
//************************** PANTALLA ****************************
//****************************************************************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe9dac2),
        appBar: AppBar(
          title: const Text("Nueva medición"),
          backgroundColor: const Color(0xff9a6a2e),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Text("Pozo: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF781f1e),
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(_pozo.descripcion.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color(0xFF3c2920),
                          height: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            const Text("Tipo Pozo: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF781f1e),
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(_pozo.tipopozo.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color(0xFF3c2920),
                          height: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            const Text("Fecha: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF781f1e),
                                  fontWeight: FontWeight.bold,
                                )),
                            Expanded(
                              child: Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color(0xFF3c2920),
                          height: 2,
                        ),
                        const SizedBox(
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
                        const SizedBox(
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

//****************************************************************
//************************** _showprtbg **************************
//****************************************************************

  Widget _showprtbg() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.compress, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Pr Tgb:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("kg/cm²"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showprlinea ************************
//****************************************************************

  Widget _showprlinea() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.compare_sharp, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Pr Línea:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("kg/cm²"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showprcsg **************************
//****************************************************************

  Widget _showprcsg() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.compare_arrows, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Pr Csg:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("kg/cm²"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showql *****************************
//****************************************************************

  Widget _showql() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.water, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Ql:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _qlController,
              //keyboardType: TextInputType.number,
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
          const SizedBox(
            width: 10,
          ),
          const Text("m³/d"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showqg *****************************
//****************************************************************

  Widget _showqg() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.waves, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Qg:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("m³/d"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showtiempo *************************
//****************************************************************

  Widget _showtiempo() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.hourglass_bottom, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Tiempo:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("horas"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showcaudalinst *********************
//****************************************************************

  Widget _showcaudalinst() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.air, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Caudal Inst.:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("m³/h"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showlecturaacumulada ***************
//****************************************************************

  Widget _showlecturaacumulada() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.add_task, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Lectura Acumulada.:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _lecturaacumuladaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Ingresa Lectura Acumulada...',
                errorText:
                    _lecturaacumuladaShowError ? _lecturaacumuladaError : null,
              ),
              onChanged: (value) {
                _lecturaacumulada = value;
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text("m³"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showpresionantesdelfiltro **********
//****************************************************************

  Widget _showpresionantesdelfiltro() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.restore, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Presión antes del filtro:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
          const SizedBox(
            width: 10,
          ),
          const Text("kg/cm³"),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showobservaciones ******************
//****************************************************************

  Widget _showobservaciones() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.list, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Observaciones:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              controller: _observacionesController,
              maxLines: 3,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: 'Ingresa Observaciones...',
                errorText: _observacionesShowError ? _observacionesError : null,
              ),
              onChanged: (value) {
                _observaciones = value;
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(""),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showRPM ****************************
//****************************************************************

  Widget _showRPM() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.speed, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "RPM:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
                _frecuencia = value;
              },
            ),
          ),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showTorque *************************
//****************************************************************

  Widget _showTorque() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.sync_disabled, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Torque:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showGPM ****************************
//****************************************************************

  Widget _showGPM() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.speed, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "GPM:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
                _frecuencia = value;
              },
            ),
          ),
        ],
      ),
    );
  }

//****************************************************************
//************************** _showCarrera ************************
//****************************************************************

  Widget _showCarrera() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.run_circle, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Carrera:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showFrecuencia *********************
//****************************************************************

  Widget _showFrecuencia() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.bolt, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Frecuencia:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showPip ****************************
//****************************************************************

  Widget _showPip() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.stacked_bar_chart, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Pip:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showAmp ****************************
//****************************************************************

  Widget _showAmp() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.motion_photos_auto, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Amp:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showVolt ***************************
//****************************************************************

  Widget _showVolt() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.battery_charging_full, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Volt:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showOrificio ***********************
//****************************************************************

  Widget _showOrificio() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.circle, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Orificio:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showTemperatura ********************
//****************************************************************

  Widget _showTemperatura() {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.yellow,
          border: Border.all(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(colors: [
            Color(
              (0xffe9dac2),
            ),
            Color(
              (0xffd3a735),
            )
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                offset: Offset(3, 5),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          const Icon(Icons.thermostat, color: Color(0xFF781f1e)),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Temperatura:",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF781f1e)),
          ),
          const SizedBox(
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
    );
  }

//****************************************************************
//************************** _showButton *************************
//****************************************************************

  Widget _showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.save),
                SizedBox(
                  width: 20,
                ),
                Text('Enviar'),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9a6a2e),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              if (DateTime.parse(_validohasta).isBefore(DateTime.now())) {
                _logOut();
              } else {
                _save();
              }
            },
          ),
        ),
      ],
    );
  }

//****************************************************************
//************************** _save *******************************
//****************************************************************

  _save() async {
    if (!validateFields()) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'No ha ingresado ninguna medición',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
    _addRecord();
  }

//****************************************************************
//************************** validateFields **********************
//****************************************************************

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

//****************************************************************
//************************** _addRecord **************************
//****************************************************************

  void _addRecord() async {
    setState(() {});
//---------------------- GRABA MEDICION EN TABLA LOCAL ------------------
    await _actualizaMedicionesCab();

    if (_medicionesCabCompleta.isEmpty) {
      _idMedicion = 1;
    } else {
      _idMedicion = 0;
      for (var element in _medicionesCabCompleta) {
        if (element.idControlPozo > _idMedicion) {
          _idMedicion = element.idControlPozo;
        }
      }
      _idMedicion = _idMedicion + 1;
    }

    MedicionCabecera medicionCabecera = MedicionCabecera(
        idControlPozo: _idMedicion,
        bateria: widget.pozo.codigobateria,
        pozo: widget.pozo.codigopozo,
        fecha: DateTime.now()
            .add(const Duration(days: 0))
            .toString()
            .substring(0, 10),
        ql: _ql == "" ? 0 : double.parse(_ql.replaceAll(',', '.')),
        qo: 0,
        qw: 0,
        qg: _qg == "" ? 0 : double.parse(_qg.replaceAll(',', '.')),
        wcLibre: 0,
        wcEmulc: 0,
        wcTotal: 0,
        sales: 0,
        gor: 0,
        t: _tiempo == "" ? 0 : double.parse(_tiempo.replaceAll(',', '.')),
        validacionControl: '',
        prTbg: _prtbg == "" ? 0 : double.parse(_prtbg.replaceAll(',', '.')),
        prLinea:
            _prlinea == "" ? 0 : double.parse(_prlinea.replaceAll(',', '.')),
        prCsg: _prcsg == "" ? 0 : double.parse(_prcsg.replaceAll(',', '.')),
        regimenOperacion: _frecuencia == ""
            ? 0
            : double.parse(_frecuencia.replaceAll(',', '.')),
        aibCarrera:
            _carrera == "" ? 0 : double.parse(_carrera.replaceAll(',', '.')),
        bespip: _pip == "" ? 0 : double.parse(_pip.replaceAll(',', '.')),
        pcpTorque:
            _torque == "" ? 0 : double.parse(_torque.replaceAll(',', '.')),
        observaciones: _observaciones,
        validadoSupervisor: 0,
        userIdInput: widget.user.idUser,
        userIDValida: 0,
        caudalInstantaneo: _caudalinst == ""
            ? 0
            : double.parse(_caudalinst.replaceAll(',', '.')),
        caudalMedio: 0,
        lecturaAcumulada: _lecturaacumulada == ""
            ? 0
            : double.parse(_lecturaacumulada.replaceAll(',', '.')),
        presionBDP:
            _prtbg == "" ? 0 : double.parse(_prtbg.replaceAll(',', '.')),
        presionAntFiltro: _presionantesdelfiltro == ""
            ? 0
            : double.parse(_presionantesdelfiltro.replaceAll(',', '.')),
        presionEC: _prcsg == "" ? 0 : double.parse(_prcsg.replaceAll(',', '.')),
        ingresoDatos: 'APP',
        reenvio: 0,
        muestra: 'NO',
        fechaCarga: DateTime.now().toString(),
        idUserValidaMuestra: 0,
        idUserImputSoft: 0,
        volt: _volt == "" ? 0 : double.parse(_volt.replaceAll(',', '.')),
        amper: _amp == "" ? 0 : double.parse(_amp.replaceAll(',', '.')),
        temp: _temperatura == ""
            ? 0
            : double.parse(_temperatura.replaceAll(',', '.')),
        fechaCargaAPP: '',
        enviado: 0,
        alarma: widget.opcion == 1 ? 0 : widget.alarma);

    DBMedicionesCabecera.insertMedicionCab(medicionCabecera);

    _alarmas = await DBAlarmas.alarma();

    for (Alarma alarma in _alarmas) {
      if (alarma.idalarma.toString() == medicionCabecera.alarma.toString()) {
        DBAlarmas.delete(alarma);
      }
    }

    await _actualizaMedicionesCab();
    _showSnackbar('Nueva medición grabada con éxito en Base de Datos Local');
    setState(() {});

//********************************************************************
//************ RECORRE TABLA LOCAL PARA GRABAR EN SERVIDOR ***********
//************ Y PONER ENVIADO = 1 EN TABLA LOCAL ********************
//********************************************************************

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

          //_addRecordsDetallesServer(medicion);
        }
      }
    }

    Navigator.pop(context, 'yes');
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

    Map<String, dynamic> request2 = {
      'IDALARMA': medicion.alarma,
      'FECHACARGA': '',
      'PROVIENEIDCONTROL': 0,
      'POZO': '',
      'BATERIA': '',
      'IDUSUARIOCARGA': 0,
      'IDUSUARIOAPP': widget.user.idUser,
      'FECHAEJECUTADA': DateTime.now().toString(),
      'NUEVOIDCONTROL': 999999,
      'OBSERVACION': '',
      'TAG': 1,
    };

    if (medicion.alarma > 0) {
      await ApiHelper.put(
        '/api/ControlDePozoAlarmas/',
        medicion.alarma.toString(),
        request2,
      );
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

//****************************************************************
//************************** _ponefechaultimalectura *************
//****************************************************************

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

//****************************************************************
//************************** _poneenviado1 ***********************
//****************************************************************

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

//****************************************************************
//************************** _poneenviado2 ***********************
//****************************************************************

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

//****************************************************************
//************************** _addRecordsDetallesServer ***********
//****************************************************************

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

//****************************************************************
//************************** _grabadetalle ***********************
//****************************************************************

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

//****************************************************************
//************************** _actualizaMedicionesCab *************
//****************************************************************

  Future<void> _actualizaMedicionesCab() async {
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
  }

//****************************************************************
//************************** _getprefs ***************************
//****************************************************************

  void _getprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _validohasta = prefs.getString('validohasta').toString();
    //_carteles();
    setState(() {});
  }

//****************************************************************
//************************** _logOut *****************************
//****************************************************************

  void _logOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
