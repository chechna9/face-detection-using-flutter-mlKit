import 'dart:io';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml1/screens/result.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  final ImagePicker _picker = ImagePicker();
  // face detector instance
  // final FaceDetectorOptions faceDetectorOption = FaceDetectorOptions();

  var faceDetector = GoogleMlKit.vision.faceDetector();

  File? fileImage;

  @override
  Widget build(BuildContext context) {
    void _pick() async {
      try {
        //pickingimage
        final image = await _picker.pickImage(source: ImageSource.camera);
        fileImage = File(image!.path);
        // converting image for mlkit
        final inputImage = InputImage.fromFilePath(image.path);
        //processing image
        final List<Face> faces = await faceDetector.processImage(inputImage);
        final ui.Image rendredImage = await _loadImage(fileImage!);
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.amber,
            builder: (context) => Result(
                  image: rendredImage,
                  faces: faces,
                ));
      } catch (e) {
        print(e);
      }
    }

    return Material(
      color: Colors.brown[400],
      child: Center(
        child: ElevatedButton.icon(
          onPressed: _pick,
          icon: Icon(Icons.camera),
          label: Text('pick image'),
        ),
      ),
    );
  }
}
