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
                ],
              ),
            )));
  }
}
