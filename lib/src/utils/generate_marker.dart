import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint bluePaint = Paint()..color = Colors.blue;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 4, bluePaint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;
}

Future<Uint8List> generateImage() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  MyPainter().paint(canvas, const Size(50, 50));

  final picture = recorder.endRecording();
  final img = await picture.toImage(50, 50);
  final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

  return pngBytes!.buffer.asUint8List();
}
