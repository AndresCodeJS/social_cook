import 'package:flutter/material.dart';

import '../../models/User.dart';
import '../../utils/constants.dart';

typedef onSaveForm = Function(BuildContext context, User usuario);

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.onSave});

  final onSaveForm  onSave;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late User usuario = User();

  String _error = "";
  String repeatedPassword = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: "Nombre y Apellido"),
            validator: (value) {
              if (value!.isEmpty) {
                return isEmpty;
              }
            },
            onSaved: (value) {
              usuario.nombre = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Email"),
            validator: (value) {
              if (value!.isEmpty) {
                return isEmpty;
              }
            },
            onSaved: (value) {
              usuario.email = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Contraseña"),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return isEmpty;
              }
            },
            onSaved: (value) {
              usuario.password = value!;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Repetir Contraseña"),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return isEmpty;
              }
            },
            onSaved: (value) {
              repeatedPassword = value!;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              _onValidate(context);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60)),
            child: const Text('Guardar'),
          ),
          if (!_error.isEmpty)
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                _error,
                style: const TextStyle(color: Colors.red),
              ),
            )
        ],
      ),
    );
  }

  void _onValidate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (repeatedPassword != usuario.password) {
        setState(() {
          _error = 'La contraseña no coincide';
        });
      }

      print('Nombre en form es: ${usuario.nombre}');

      widget.onSave(context, usuario);
    }
  }
}
