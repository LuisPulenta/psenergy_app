import 'package:flutter/material.dart';
import 'package:psenergy_app/models/usuario.dart';
import 'package:psenergy_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioScreen extends StatelessWidget {
  final Usuario user;

  UsuarioScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Center(
            child: Text(
              user.login.toUpperCase(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              user.fullName,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text(
                  user.fechaUltimoAcceso.toString(),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text(
                  user.fechaUltimoAcceso.toString(),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text(
                  user.fechaUltimoAcceso.toString(),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text(
                  user.fechaUltimoAcceso.toString(),
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
                return Color(0xFF120E43);
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
                return Color(0xFF120E43);
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
                return Color(0xFF120E43);
              }),
            ),
            onPressed: () => _logOut(),
          ),
        ],
      ),
    );
  }

  _actualizarPassword() {}

  _logOut() {}
}
