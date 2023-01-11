import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/helpers/api_helper.dart';
import 'package:psenergy_app/models/models.dart';

class NotificationsScreen extends StatefulWidget {
  final User user;
  const NotificationsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
//*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************

  List<Notificacion> _notifications = [];
  List<Notificacion> _notificationsFiltered = [];
  List<Destino> _destinos = [];
  bool _showLoader = false;
  bool _vencenhoy = false;
  bool _mias = false;

//*****************************************************************************
//************************** INIT STATE ***************************************
//*****************************************************************************

  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

//*****************************************************************************
//************************** PANTALLA *****************************************
//*****************************************************************************

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9dac2),
      appBar: AppBar(
        backgroundColor: const Color(0xff9a6a2e),
        title: const Text('Notificaciones'),
        centerTitle: true,
      ),
      body: Center(
        child: _showLoader
            ? const LoaderComponent(text: 'Por favor espere...')
            : _getContent(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

//----------------------------------------------------------------------
//---------------------------- _getNotifications -----------------------
//----------------------------------------------------------------------

  Future<void> _getNotifications() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estés conectado a Internet',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Response response = Response(isSuccess: false);

    response = await ApiHelper.getNotifications();

    setState(() {
      _showLoader = false;
    });

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

    setState(() {
      _notifications = response.result;
      _notifications.sort((a, b) {
        return a.fechacarga
            .toString()
            .toLowerCase()
            .compareTo(b.fechacarga.toString().toLowerCase());
      });
    });
    _notificationsFiltered = _notifications;
    _getDestinos();
  }

//-----------------------------------------------------------------
//---------------------------- _getDestinos -----------------------
//-----------------------------------------------------------------

  Future<void> _getDestinos() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estés conectado a Internet',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Response response = Response(isSuccess: false);

    response = await ApiHelper.getDestinos(widget.user.idUsuario);

    setState(() {
      _showLoader = false;
    });

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

    setState(() {
      _destinos = response.result;
      _destinos.sort((a, b) {
        return a.idnotificacion
            .toString()
            .toLowerCase()
            .compareTo(b.idnotificacion.toString().toLowerCase());
      });
    });

    var a = 123;
  }

//------------------------------------------------------------------
//---------------------------- _getContent -------------------------
//------------------------------------------------------------------

  Widget _getContent() {
    return Column(
      children: <Widget>[
        _showMias(),
        _showVencenHoy(),
        _showNotificationsCount(),
        Expanded(
          child: _notificationsFiltered.isEmpty ? _noContent() : _getListView(),
        )
      ],
    );
  }

//------------------------------------------------------------------
//---------------------------- _noContent --------------------------
//------------------------------------------------------------------

  Widget _noContent() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          'No hay Notificaciones registradas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

//------------------------------------------------------------------
//---------------------------- _getListView ------------------------
//------------------------------------------------------------------

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getNotifications,
      child: ListView(
        children: _notificationsFiltered.map((e) {
          return Card(
            color: const Color.fromARGB(255, 189, 162, 148),
            shadowColor: Colors.white,
            elevation: 10,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 150, //136,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text("NOTA N°: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Tipo: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Fec. Emis./Recep.: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Emisor: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Jurisdicción: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Area: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Clase: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Prioridad: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text("Fecha Fin: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF781f1e),
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(e.idnotficacion.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(e.tipo.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(e.fechaemrec!)),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(e.emisor.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(e.juridiccion.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(e.area.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(e.clase.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(e.prioridad.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(e.fechaFin!)),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ))
                                      ],
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 45,
                            color: Color(0xFF781f1e),
                          ),
                          onPressed: () {
                            _goInfoInspeccion(e);
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

//------------------------------------------------------------------
//---------------------------- _getListView ------------------------
//------------------------------------------------------------------

  void _goInfoInspeccion(Notificacion e) async {
    // String? result = await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => InspeccionDuplicarScreen(
    //               user: widget.user,
    //               vistaInspeccion: e,
    //             )));
    // if (result == 'yes') {
    //   _getNotifications();
    // }
  }

//------------------------------------------------------------------
//---------------------------- _showNotificationsCount -------------
//------------------------------------------------------------------

  Widget _showNotificationsCount() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      child: Row(
        children: [
          const Text("Cantidad de Notificaciones: ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Text(_notificationsFiltered.length.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

//-------------------------------------------------------------
//--------------------- METODO SHOWVENCENHOY ------------------
//-------------------------------------------------------------

  _showVencenHoy() {
    return CheckboxListTile(
      title: const Text('Vencen hoy:'),
      value: _vencenhoy,
      onChanged: (value) {
        setState(() {
          _vencenhoy = value!;
        });
        if (_vencenhoy) {
          _notificationsFiltered = [];

          _notifications.forEach((notificacion) {
            String fechaNotificacion =
                notificacion.fechaFin.toString().substring(0, 10);

            int anioHoy = DateTime.now().year;
            int mesHoy = DateTime.now().month;
            int diaHoy = DateTime.now().day;

            int anioNotificacion =
                int.parse(notificacion.fechaFin.toString().substring(0, 4));
            int mesNotificacion =
                int.parse(notificacion.fechaFin.toString().substring(5, 7));
            int diaNotificacion =
                int.parse(notificacion.fechaFin.toString().substring(8, 10));

            if (anioHoy == anioNotificacion &&
                mesHoy == mesNotificacion &&
                diaHoy == diaNotificacion) {
              _notificationsFiltered.add(notificacion);
            }
          });
        } else {
          _notificationsFiltered = _notifications;
        }
      },
    );
  }

//-------------------------------------------------------------
//--------------------- METODO SHOWMIAS -----------------------
//-------------------------------------------------------------

  _showMias() {
    return CheckboxListTile(
      title: const Text('Mis notificaciones:'),
      value: _mias,
      onChanged: (value) {
        setState(() {
          _mias = value!;
        });
        if (_mias) {
          _notificationsFiltered = [];

          _notifications.forEach((notificacion) {
            _destinos.forEach((destino) {
              if (notificacion.idnotficacion == destino.idnotificacion) {
                _notificationsFiltered.add(notificacion);
              }
            });
          });
        } else {
          _notificationsFiltered = _notifications;
        }
      },
    );
  }
}
