import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/models/pozo.dart';
import 'package:psenergy_app/models/usuario.dart';

class MedicionScreen extends StatefulWidget {
  final Usuario user;
  final Pozo pozo;

  MedicionScreen({required this.user, required this.pozo});

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

  String _tiempo = '';
  String _tiempoError = '';
  bool _tiempoShowError = false;
  TextEditingController _tiempoController = TextEditingController();

  String _gpm = '';
  String _gpmError = '';
  bool _gpmShowError = false;
  TextEditingController _gpmController = TextEditingController();

  String _carrera = '';
  String _carreraError = '';
  bool _carreraShowError = false;
  TextEditingController _carreraController = TextEditingController();

  String _observaciones = '';
  String _observacionesError = '';
  bool _observacionesShowError = false;
  TextEditingController _observacionesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pozo = widget.pozo;
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
                    widget.pozo.tipopozo.toLowerCase() == 'productor'
                        ? _showgpm()
                        : Container(),
                    widget.pozo.tipopozo.toLowerCase() == 'productor'
                        ? _showcarrera()
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
