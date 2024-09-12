// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:camera_linux/camera_linux_status.dart';
import 'package:camera_linux/widget/scan_barcode.dart';
import 'package:flutter/material.dart';
import 'package:camera_linux/camera_linux.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cameraLinuxPlugin = CameraLinux(isCameraScan: true);
  late CameraStatus _status;
  Uint8List? _capturedImage;

  @override
  void initState() {
    _status = _cameraLinuxPlugin.checkCameraStatus();
    super.initState();
  }

  Widget get _connectedWidget {
    return Center(
      child: Column(
        children: [
          Text(_status.message),
          ElevatedButton(
              onPressed: () async {
                _status = await _cameraLinuxPlugin.startCamera();
                setState(() {});
              },
              child: Text("Open Camera"))
        ],
      ),
    );
  }

  Widget get _notConnectedWidget {
    return Center(
      child: Column(
        children: [
          Text(_status.message),
          ElevatedButton(
              onPressed: () {
                _status = _cameraLinuxPlugin.checkCameraStatus();
                setState(() {});
              },
              child: Text("Retry"))
        ],
      ),
    );
  }

  Widget get _errorWidget {
    return Center(
      child: Column(
        children: [
          Text(_status.message),
          ElevatedButton(
              onPressed: () {
                _status = _cameraLinuxPlugin.checkCameraStatus();
                setState(() {});
              },
              child: Text("Retry"))
        ],
      ),
    );
  }

  Widget get _openedWidget {
    return Center(
      child: Column(
        children: [
          if (_capturedImage != null)
            Image.memory(
              _capturedImage!,
              height: 40,
              width: 40,
            ),
          ScanBarcode(
              camera: _cameraLinuxPlugin,
              onScan: (text) {
                print(text);
              }),
          Text(_status.message),
          ElevatedButton(
              onPressed: () {
                _status = _cameraLinuxPlugin.pauseCamera();
                setState(() {});
              },
              child: Text("Pause")),
          ElevatedButton(
              onPressed: () {
                _status = _cameraLinuxPlugin.stopCamera();
                setState(() {});
              },
              child: Text("Stop")),
          ElevatedButton(
              onPressed: () async {
                try {
                  _capturedImage = await _cameraLinuxPlugin.captureImage();
                  setState(() {});
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Capture Image")),
        ],
      ),
    );
  }

  Widget get _pausedWidget {
    return Center(
      child: Column(
        children: [
          if (_capturedImage != null)
            Image.memory(
              _capturedImage!,
              height: 40,
              width: 40,
            ),
                     ScanBarcode(
              camera: _cameraLinuxPlugin,
              onScan: (text) {
                print(text);
              }),
          Text(_status.message),
          ElevatedButton(
              onPressed: () {
                _status = _cameraLinuxPlugin.resumeCamera();
                setState(() {});
              },
              child: Text("Resume")),
          ElevatedButton(
              onPressed: () {
                _status = _cameraLinuxPlugin.stopCamera();
                setState(() {});
              },
              child: Text("Stop")),
        ],
      ),
    );
  }

  Widget get _closedWidget {
    return Center(
      child: Column(
        children: [
          Text(_status.message),
          ElevatedButton(
              onPressed: () async {
                _status = await _cameraLinuxPlugin.startCamera();
                setState(() {});
              },
              child: Text("Open Camera"))
        ],
      ),
    );
  }

  Widget get _child {
    if (_status is CameraStatusConnected) {
      return _connectedWidget;
    } else if (_status is CameraStatusNotConnected) {
      return _notConnectedWidget;
    } else if (_status is CameraStatusError) {
      return _errorWidget;
    } else if (_status is CameraStatusOpened) {
      return _openedWidget;
    } else if (_status is CameraStatusPaused) {
      return _pausedWidget;
    } else if (_status is CameraStatusClosed) {
      return _closedWidget;
    }

    return Center(child: Text(_status.message));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: _child,
      ),
    );
  }
}
