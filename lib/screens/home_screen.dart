import 'package:flutter/material.dart';
import 'package:psenergy_app/components/usuario_screen.dart';
import 'package:psenergy_app/models/usuario.dart';
import 'package:psenergy_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Usuario user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Usuario _user = Usuario(
      idUsuario: 0,
      nombre: '',
      apellido: '',
      login: '',
      contrasena: '',
      fechaUltimoAcceso: '',
      fullName: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text("PSEnergy"),
              // expandedHeight: 320,
              flexibleSpace: Container(
                decoration: BoxDecoration(),
                child: Container(
                  color: Colors.yellow.withOpacity(.5),
                ),
              ),
              pinned: true,
              bottom: TabBar(
                indicatorWeight: 5,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    child: Column(
                      children: [
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
                      children: [
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
                      children: [
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
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text("Hola"),
            ),
            Center(
              child: Text("Chau"),
            ),
            UsuarioScreen(user: _user),
          ],
        ),
      ),
    ));
  }
}
