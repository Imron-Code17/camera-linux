import 'dart:io';
import 'dart:typed_data';

import 'package:camera_linux/camera_linux_controller.dart';
import 'package:camera_linux/camera_linux_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

  void onCapture(Uint8List image) {
    getApplicationDocumentsDirectory().then((dir) {
      final file = File('${dir.path}/image.png');
      file.writeAsBytesSync(image);
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
              CameraLinuxWidget(
                controller: _camLinuxC,
                type: CameraType.selfie,
                onCapture: onCapture,
                size: const Size(480, 640),
                // overlayWidget: Image.asset('assets/images/jas.png'),
              ),
          ],
        ),
      ),
    );
  }
}
