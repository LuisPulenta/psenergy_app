import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';
import 'package:psenergy_app/screens/screens.dart';

class AlarmasScreen extends StatefulWidget {
  final Usuario user;
  final List<Alarma> alarmas;

  const AlarmasScreen({
    Key? key,
    required this.user,
    required this.alarmas,
  }) : super(key: key);

  @override
  _AlarmasScreenState createState() => _AlarmasScreenState();
}

class _AlarmasScreenState extends State<AlarmasScreen> {
//*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************

  List<Pozo> _pozos = [];
  List<PozosFormula> _pozosformulas = [];
  List<PozosControle> _pozoscontroles = [];
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

  List<Alarma> _alarmas = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';
  Alarma alarmaSelected = Alarma(
      idalarma: 0,
      fechacarga: '',
      provieneidcontrol: 0,
      pozo: '',
      bateria: '',
      idusuariocarga: 0,
      idusuarioapp: 0,
      fechaejecutada: '',
      nuevoidcontrol: 0,
      observacion: '',
      tag: 0);

  Alarma alarmaSeleccionada = Alarma(
      idalarma: 0,
      fechacarga: '',
      provieneidcontrol: 0,
      pozo: '',
      bateria: '',
      idusuariocarga: 0,
      idusuarioapp: 0,
      fechaejecutada: '',
      nuevoidcontrol: 0,
      observacion: '',
      tag: 0);

//*****************************************************************************
//************************** INIT STATE ***************************************
//*****************************************************************************

  @override
  void initState() {
    super.initState();
    _getAlarmas();
  }

//*****************************************************************************
//************************** PANTALLA *****************************************
//*****************************************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF484848),
      appBar: AppBar(
        backgroundColor: const Color(0xff9a6a2e),
        title: const Text('Alarmas'),
        centerTitle: true,
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _removeFilter, icon: const Icon(Icons.filter_none))
              : IconButton(
                  onPressed: _showFilter, icon: const Icon(Icons.filter_alt)),
        ],
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
        child: Center(
          child: _showLoader
              ? const LoaderComponent(text: 'Por favor espere...')
              : _getContent(),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO FILTER --------------------------
//-----------------------------------------------------------------------------

  _filter() {
    if (_search.isEmpty) {
      return;
    }
    List<Alarma> filteredList = [];
    for (var alarma in _alarmas) {
      if (alarma.bateria!.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(alarma);
      }
    }

    setState(() {
      _alarmas = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO REMOVEFILTER --------------------------
//-----------------------------------------------------------------------------

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getAlarmas();
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO SHOWFILTER --------------------------
//-----------------------------------------------------------------------------

  void _showFilter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text('Filtrar Alarmas'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const Text(
                'Escriba texto o números a buscar en Nombre de la Batería: ',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Criterio de búsqueda...',
                    labelText: 'Buscar',
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {
                  _search = value;
                },
              ),
            ]),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () => _filter(), child: const Text('Filtrar')),
            ],
          );
        });
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO GETCONTENT --------------------------
//-----------------------------------------------------------------------------

  Widget _getContent() {
    return Column(
      children: <Widget>[
        _showAlarmasCount(),
        Expanded(
          child: _alarmas.isEmpty ? _noContent() : _getListView(),
        )
      ],
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO SHOWALARMASCOUNT ----------------------
//-----------------------------------------------------------------------------

  Widget _showAlarmasCount() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      child: Row(
        children: [
          const Text("Cantidad de Alarmas: ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Text(_alarmas.length.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO NOCONTENT -----------------------------
//-----------------------------------------------------------------------------

  Widget _noContent() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          _isFiltered
              ? 'No hay Alarmas con ese criterio de búsqueda'
              : 'No hay Alarmas registradas',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO GETLISTVIEW ---------------------------
//-----------------------------------------------------------------------------

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getAlarmas,
      child: ListView(
        children: _alarmas.map((e) {
          return Card(
            color: const Color.fromARGB(255, 246, 246, 255),
            shadowColor: Colors.white,
            elevation: 10,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: InkWell(
              onTap: () {
                alarmaSelected = e;
                _goAlarma(e);
              },
              child: Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Batería: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF781f1e),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(e.bateria.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Pozo: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF781f1e),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(e.pozo.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Fecha: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF781f1e),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(
                                                    e.fechacarga.toString())),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            )),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text("Observaciones: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF781f1e),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(e.observacion.toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.red)),
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
      ),
    );
  }

//-----------------------------------------------------------------------
//-------------------------- _getAlarmas --------------------------------
//-----------------------------------------------------------------------

  Future<void> _getAlarmas() async {
    setState(() {
      _alarmas = widget.alarmas;
      _alarmas.sort((a, b) {
        return a.bateria
            .toString()
            .toLowerCase()
            .compareTo(b.bateria.toString().toLowerCase());
      });
    });
  }

//*****************************************************************************
//************************** METODO GOALARMA ********************************
//*****************************************************************************

  void _goAlarma(Alarma alarma) async {
    _pozos = await DBPozos.pozos();
    _pozosformulas = await DBPozosFormulas.pozosformulas();
    _pozoscontroles = await DBPozosControles.pozoscontroles();

    for (Pozo pozo in _pozos) {
      if (pozo.codigopozo == alarma.pozo) {
        _pozoSelected = pozo;
      }
    }

    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MedicionScreen(
                  user: widget.user,
                  pozo: _pozoSelected,
                  pozos: _pozos,
                  pozosformulas: _pozosformulas,
                  pozoscontroles: _pozoscontroles,
                  opcion: 2,
                  alarma: alarma.idalarma!,
                )));
    if (result != 'xyz') {
      _alarmas = [];
      setState(() {
        _showLoader = true;
      });

      await _getAlarmas();
      setState(() {
        _showLoader = false;
      });
    }

    setState(() {});
  }
}
