import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 146, 201, 209),
              Color.fromARGB(255, 11, 180, 196)
            ])),
            /* child: const FlutterLogo(), */
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: AppBar(
                title: const Text(
                  "Registro de usuario",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: Colors.transparent),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _openImagePicker,
                  child: ClipRRect(
                   borderRadius: BorderRadius.circular(200.0),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          )
                        : Image.asset(
                            "assets/camara.png",
                            color: Colors.white,
                            height: 200,
                            width: 200,
                          ),
                  ),
                ),
                IconButton(
                    onPressed: _openImagePicker,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  File? _image;

  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}
