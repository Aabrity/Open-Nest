import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeImageViewer extends StatefulWidget {
  final Uint8List imageBytes;

  const GyroscopeImageViewer({Key? key, required this.imageBytes}) : super(key: key);

  @override
  _GyroscopeImageViewerState createState() => _GyroscopeImageViewerState();
}

class _GyroscopeImageViewerState extends State<GyroscopeImageViewer> {
  double _rotationX = 0.0;
  double _rotationY = 0.0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _rotationX = event.x * 0.1; // Scale down for smoother rotation
        _rotationY = event.y * 0.1;
      });
    });
  }


@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Scaffold(
    body: GestureDetector(
      onTap: () {
        Navigator.pop(context); // Exit the 360-degree view on tap
      },
      child: Transform(
        transform: Matrix4.rotationX(_rotationX)..rotateY(_rotationY),
        alignment: Alignment.center,
        child: Image.memory(
          widget.imageBytes,
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
}