import 'dart:typed_data';

import 'package:camera_linux/camera_linux_controller.dart';
import 'package:camera_linux/camera_linux_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraLinuxController _camLinuxC;
  bool isLoading = false;
  Uint8List? _imageCapture;

  void onCapture(Uint8List image) {
    setState(() {
      _imageCapture = image;
    });
  }

  @override
  void initState() {
    _camLinuxC = CameraLinuxController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            if (isLoading) const Center(child: CircularProgressIndicator()),
            if (!isLoading)
              Visibility(
                visible: _imageCapture == null,
                child: CameraLinuxWidget(
                  controller: _camLinuxC,
                  type: CameraType.selfie,
                  openedWidget: (p) => Center(child: p),
                  pausedWidget: (p) => Center(child: p),
                  onCapture: onCapture,
                ),
              ),
            Visibility(
                visible: _imageCapture != null,
                child: _imageCapture != null
                    ? Image.memory(_imageCapture!)
                    : const SizedBox.shrink()),
            const SizedBox(height: 34),
            const ElevatedButton(onPressed: null, child: Text('Action'))
          ],
        ),
      ),
    );
  }
}
