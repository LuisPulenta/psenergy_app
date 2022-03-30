import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:psenergy_app/components/loader_component.dart';
import 'package:psenergy_app/helpers/helpers.dart';
import 'package:psenergy_app/models/models.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Usuario user;
  ChangePasswordScreen({required this.user});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _showLoader = false;

  String _currentPassword = '';
  String _currentPasswordError = '';
  bool _currentPasswordShowError = false;
  TextEditingController _currentPasswordController = TextEditingController();

  String _newPassword = '';
  String _newPasswordError = '';
  bool _newPasswordShowError = false;
  TextEditingController _newPasswordController = TextEditingController();

  String _confirmPassword = '';
  String _confirmPasswordError = '';
  bool _confirmPasswordShowError = false;
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cambio de Contraseña'),
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
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  _showCurrentPassword(),
                  _showNewPassword(),
                  _showConfirmPassword(),
                  _showButtons(),
                ],
              ),
              _showLoader
                  ? LoaderComponent(
                      text: 'Por favor espere...',
                    )
                  : Container(),
            ],
          ),
        ));
  }

  Widget _showCurrentPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
          hintText: 'Ingresa la contraseña actual...',
          labelText: 'Contraseña actual',
          errorText: _currentPasswordShowError ? _currentPasswordError : null,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordShow
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordShow = !_passwordShow;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _currentPassword = value;
        },
      ),
    );
  }

  Widget _showNewPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
          hintText: 'Ingresa la nueva contraseña...',
          labelText: 'Nueva Contraseña',
          errorText: _newPasswordShowError ? _newPasswordError : null,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordShow
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordShow = !_passwordShow;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _newPassword = value;
        },
      ),
    );
  }

  Widget _showConfirmPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
          hintText: 'Confirmación de contraseña...',
          labelText: 'Confirmación de contraseña',
          errorText: _confirmPasswordShowError ? _confirmPasswordError : null,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordShow
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordShow = !_passwordShow;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _confirmPassword = value;
        },
      ),
    );
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _showChangePassword(),
        ],
      ),
    );
  }

  Widget _showChangePassword() {
    return Expanded(
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock),
            SizedBox(
              width: 15,
            ),
            Text('Cambiar contraseña'),
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
    );
  }

  void _save() async {
    if (!validateFields()) {
      return;
    }
    _changePassword();
  }

  bool validateFields() {
    bool isValid = true;

    if (_currentPassword.length < 1) {
      isValid = false;
      _currentPasswordShowError = true;
      _currentPasswordError = 'Debes ingresar tu Contraseña actual';
      setState(() {});
      return isValid;
    } else if (_currentPassword != widget.user.usrcontrasena) {
      isValid = false;
      _currentPasswordShowError = true;
      _currentPasswordError = 'Contraseña incorrecta!';
      setState(() {});
      return isValid;
    } else {
      _currentPasswordShowError = false;
    }

    if (_newPassword.length < 4) {
      isValid = false;
      _newPasswordShowError = true;
      _newPasswordError =
          'Debes ingresar una Contraseña de al menos 4 caracteres';
      setState(() {});
      return isValid;
    } else {
      _newPasswordShowError = false;
    }

    if (_confirmPassword.length < 4) {
      isValid = false;
      _confirmPasswordShowError = true;
      _confirmPasswordError =
          'Debes ingresar una Confirmación de Contraseña de al menos 4 caracteres';
      setState(() {});
      return isValid;
    } else {
      _confirmPasswordShowError = false;
    }

    if (_confirmPassword != _newPassword) {
      isValid = false;
      _newPasswordShowError = true;
      _confirmPasswordShowError = true;
      _newPasswordError = 'La contraseña y la confirmación no son iguales';
      _confirmPasswordError = 'La contraseña y la confirmación no son iguales';
      setState(() {});
      return isValid;
    } else {
      _newPasswordShowError = false;
      _confirmPasswordShowError = false;
    }

    setState(() {});

    return isValid;
  }

  void _changePassword() async {
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
          message: 'Verifica que estes conectado a internet.',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Map<String, dynamic> request = {
      'idUser': widget.user.idUser,
      'codigo': widget.user.codigo,
      'apellidonombre': widget.user.apellidonombre,
      'usrlogin': widget.user.usrlogin,
      'usrcontrasena': _newPassword.toUpperCase(),
      'perfil': widget.user.perfil,
      'habilitadoWeb': widget.user.habilitadoWeb,
      'causanteC': widget.user.causanteC,
      'habilitaPaqueteria': widget.user.habilitaPaqueteria,
    };

    Response response = await ApiHelper.put(
        '/api/Usuarios/', widget.user.idUser.toString(), request);

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    widget.user.usrcontrasena = _newPassword;
    await showAlertDialog(
        context: context,
        title: 'Confirmación',
        message: 'Su contraseña ha sido cambiada con éxito.',
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar'),
        ]);

    Navigator.pop(context, 'yes');
  }
}
