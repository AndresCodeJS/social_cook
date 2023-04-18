import 'dart:io';
import 'package:flutter/material.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key, required this.image, required this.openImagePicker});

  final Function openImagePicker;

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){openImagePicker();},
                  child: ClipRRect(
                   borderRadius: BorderRadius.circular(200.0),
                    child: image != null
                        ? Image.file(
                            image!,
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
                    onPressed: (){openImagePicker();},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ))
              ],
            );






  }
}