import 'package:flutter/material.dart';
import 'package:psenergy_app/models/usuario.dart';
import 'package:psenergy_app/screens/change_password_screen.dart';
import 'package:psenergy_app/screens/contacto_screen.dart';
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      _user.login.toUpperCase(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      _user.fullName,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Conectado desde:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _user.fechaUltimoAcceso.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Válido hasta:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _user.fechaUltimoAcceso.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Ultima actualización de Usuarios:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _user.fechaUltimoAcceso.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Versión:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          _user.fechaUltimoAcceso.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.password),
                        SizedBox(
                          width: 15,
                        ),
                        Text('ACTUALIZAR CONTRASEÑA'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF9a6a2e);
                      }),
                    ),
                    onPressed: () => _actualizarPassword(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CONTACTO KEYPRESS'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF9a6a2e);
                      }),
                    ),
                    onPressed: () => _contacto(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 15,
                        ),
                        Text('CERRAR SESION'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color(0xFF9a6a2e);
                      }),
                    ),
                    onPressed: () => _logOut(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _actualizarPassword() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
  }

  void _logOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _contacto() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactoScreen()));
  }
}
