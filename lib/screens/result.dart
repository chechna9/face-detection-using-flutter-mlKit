import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ml1/services/face_painter.dart';
import 'dart:ui' as ui show Image;

import 'package:provider/provider.dart';

class Result extends StatefulWidget {
  final ui.Image? image;
  final List<Face> faces;
  Result({Key? key, required this.image, required this.faces})
      : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Text(
          "${widget.faces.length} faces Found!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            height: widget.image!.height.toDouble(),
            width: widget.image!.width.toDouble(),
            child: CustomPaint(
              painter: FacePainter(
                  image: widget.image!,
                  faces: widget.faces.map((e) => e.boundingBox).toList()),
            ),
          ),
        ),
      ],
    );
  }
}
