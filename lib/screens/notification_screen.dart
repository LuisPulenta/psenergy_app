import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psenergy_app/models/models.dart';

class NotificationScreen extends StatefulWidget {
  final User user;
  final Notificacion notification;
  const NotificationScreen(
      {Key? key, required this.user, required this.notification})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double ancho = 120;
    return Scaffold(
        backgroundColor: const Color(0xffe9dac2),
        appBar: AppBar(
          title: const Text("Notificación"),
          backgroundColor: const Color(0xff9a6a2e),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
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
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("NOTA N°: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.idnotficacion.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Tipo: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.tipo.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Fecha Carga: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(
                      DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(widget.notification.fechacarga!)),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Fec. Emis./Recep.: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(
                      DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(widget.notification.fechaemrec!)),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Emisor: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.emisor.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Receptor: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.enteempresa.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Jurisdicción: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.juridiccion.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Area: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.area.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Plazo: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.plazo.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Dirigido a: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.dirigidoa.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Clase: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.clase.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("N° Expediente: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.nroExpediente.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Estado: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.estado.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Prioridad: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(widget.notification.prioridad.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Fecha Fin: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text(
                      DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(widget.notification.fechaFin!)),
                      style: const TextStyle(
                        fontSize: 12,
                      ))
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  SizedBox(
                    width: ancho,
                    child: const Text("Nota Refer.: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Text(
                      widget.notification.notareferencia.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 25,
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
