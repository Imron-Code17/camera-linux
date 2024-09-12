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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: CameraLinuxWidget(
          isCameraScan: true,
          openedWidget: (pause, stop, capture, preview) {
            return preview;
          },
        ),
      ),
    );
  }
}
