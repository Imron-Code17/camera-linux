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

  @override
  void initState() {
    _camLinuxC = CameraLinuxController(onScan: (p0) => print(p0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: CameraLinuxWidget(
            controller: _camLinuxC, openedWidget: (p) => Center(child: p)),
      ),
    );
  }
}
