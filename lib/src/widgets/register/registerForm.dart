import 'package:flutter/material.dart';

import '../../models/User.dart';
import '../../utils/constants.dart';

typedef onSaveForm = Function(BuildContext context, User usuario);

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.onSave});

  final onSaveForm onSave;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late User usuario = User();

  String _error = "";
  String repeatedPassword = "";

  bool showPassword = false;
  bool showPasswordR = false;

  Genrer? _genrer = Genrer.male;

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
            decoration: InputDecoration(
                labelText: "Contraseña",
                suffixIcon: IconButton(
                  icon: !showPassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )),
            obscureText: !showPassword,
            onChanged: (value) {
              onChangePassword();
            },
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
            decoration: InputDecoration(
                labelText: "Repetir Contraseña",
                suffixIcon: IconButton(
                  icon: !showPasswordR
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPasswordR = !showPasswordR;
                    });
                  },
                )),
            obscureText: !showPasswordR,
            onChanged: (value) {
              onChangePassword();
            },
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
          SizedBox(
            width: double.infinity,
            child: Text(
              "Género:",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
          Column(
            children: [
              RadioListTile(
                title: const Text('Masculino'),
                contentPadding: const EdgeInsets.all(0),
                value: Genrer.male,
                activeColor: Colors.blue,
                groupValue: _genrer,
                onChanged: (Genrer? value) {
                  setState(() {
                    _genrer = value;
                  });
                },
              ),
              SizedBox(
                child: RadioListTile(
                  title: const Text('Femenino'),
                  contentPadding: const EdgeInsets.all(0),
                  value: Genrer.female,
                  activeColor: Colors.blue,
                  groupValue: _genrer,
                  onChanged: (Genrer? value) {
                    setState(() {
                      _genrer = value;
                    });
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _onValidate(context);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60)),
            child: const Text('Guardar'),
          ),
          _error.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  void onChangePassword() {
    if (_error.isNotEmpty) {
      setState(() {
        _error = "";
      });
    }
  }

  void _onValidate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (repeatedPassword != usuario.password) {
        setState(() {
          _error = 'La contraseña no coincide';
        });
        return;
      }

    /*   print('Nombre en form es: ${usuario.nombre}');

      print('El genero seleccionado es: ${_genrer.toString()}');
 */
      widget.onSave(context, usuario);
    }
  }
}
