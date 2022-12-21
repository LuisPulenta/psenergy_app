import 'package:flutter/material.dart';
import 'package:psenergy_app/helpers/dbareas_helper.dart';
import 'package:psenergy_app/helpers/dbbaterias_helper.dart';
import 'package:psenergy_app/helpers/dbmedicionescabecera_helper.dart';
import 'package:psenergy_app/helpers/dbpozos_helper.dart';
import 'package:psenergy_app/helpers/dbpozoscontroles_helper.dart';
import 'package:psenergy_app/helpers/dbpozosformulas_helper.dart';
import 'package:psenergy_app/helpers/dbyacimientos_helper.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/screens/screens.dart';

import '../models/models.dart';

class DatosScreen extends StatefulWidget {
  final List<Usuario> usuarios;
  final List<Area> areas;
  final List<Yacimiento> yacimientos;
  final List<Bateria> baterias;
  final List<Pozo> pozos;
  final List<PozosFormula> pozosformulas;
  final List<PozosControle> pozoscontroles;
  final List<MedicionCabecera> medicionesCab;
  final List<Alarma> alarmas;
  const DatosScreen(
      {Key? key,
      required this.usuarios,
      required this.areas,
      required this.yacimientos,
      required this.baterias,
      required this.pozos,
      required this.pozosformulas,
      required this.pozoscontroles,
      required this.medicionesCab,
      required this.alarmas})
      : super(key: key);

  @override
  State<DatosScreen> createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosScreen> {
//*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************
  List<Usuario> _usuarios = [];
  List<Area> _areas = [];
  List<Yacimiento> _yacimientos = [];
  List<Bateria> _baterias = [];
  List<Pozo> _pozos = [];
  List<PozosFormula> _pozosformulas = [];
  List<PozosControle> _pozoscontroles = [];
  List<MedicionCabecera> _medicionesCab = [];
  List<Alarma> _alarmas = [];

//*****************************************************************************
//************************** INIT STATE ***************************************
//*****************************************************************************

  @override
  void initState() {
    super.initState();
    _usuarios = widget.usuarios;
    _areas = widget.areas;
    _yacimientos = widget.yacimientos;
    _baterias = widget.baterias;
    _pozos = widget.pozos;
    _pozosformulas = widget.pozosformulas;
    _pozoscontroles = widget.pozoscontroles;
    _medicionesCab = widget.medicionesCab;
    _alarmas = widget.alarmas;
  }

  @override
  Widget build(BuildContext context) {
    double ancho = 180;
    return Scaffold(
      backgroundColor: const Color(0xFF484848),
      appBar: AppBar(
        backgroundColor: const Color(0xff9a6a2e),
        title: const Text('Datos de la App'),
        centerTitle: true,
      ),
      body: Container(
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
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Usuarios: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50, child: Text(_usuarios.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _usuarios = [];
                    //       DBUsuarios.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Areas: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 50, child: Text(_areas.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _areas = [];
                    //       DBAreas.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Yacimientos: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50, child: Text(_yacimientos.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _yacimientos = [];
                    //       DBYacimientos.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Baterías: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50, child: Text(_baterias.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _baterias = [];
                    //       DBBaterias.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Pozos: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 50, child: Text(_pozos.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _pozos = [];
                    //       DBPozos.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Pozos Fórmulas: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50,
                        child: Text(_pozosformulas.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _pozosformulas = [];
                    //       DBPozosFormulas.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Pozos Controles: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50,
                        child: Text(_pozoscontroles.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _pozoscontroles = [];
                    //       DBPozosControles.delete();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Mediciones en BD local: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50,
                        child: Text(_medicionesCab.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _medicionesCab = [];
                    //       DBMedicionesCabecera.deleteAll();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ancho,
                      child: const Text('Alarmas: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                        width: 50, child: Text(_alarmas.length.toString())),
                    const SizedBox(
                      width: 50,
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       _alarmas = [];
                    //       DBAlarmas.deleteAll();
                    //       setState(() {});
                    //     },
                    //     child: const Text('Vaciar')),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Si Usuarios, Areas, Yacimientos, Baterias, Pozos, Pozos Fórmulas o PozosControles, están en cero, DEBE CERRAR SESION y ASEGURARSE de tener Internet para cargar los Datos necesarios desde el Servidor para el correcto Funcionamiento de la App. Los únicos que podrían estar en 0 son Mediciones en BD local y Alarmas.'),
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
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
