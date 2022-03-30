import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;

import 'package:google_ml_kit/google_ml_kit.dart';

class FacePainter extends CustomPainter {
  FacePainter({required this.image, required this.faces});
  final ui.Image image;
  final List<Rect> faces;
  final myPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
    for (int i = 0; i < faces.length; i++) {
      canvas.drawRect(faces[i], myPaint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) => false;
  // bool shouldRepaint(FacePainter oldDelegate) =>
  //     imageAsFile != oldDelegate.imageAsFile || faces != oldDelegate.faces;
}
