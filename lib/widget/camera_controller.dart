import 'dart:typed_data';

import 'package:camera_linux/camera_linux.dart';
import 'package:camera_linux/widget/camera_preview.dart';
import 'package:flutter/material.dart';

class CameraController extends State<CameraPreview> {
  static late CameraController instance;
  late CameraPreview view;

  final cameraLinuxPlugin = CameraLinux();

  Future<Uint8List?> takePicture() async {
    Uint8List? image = await cameraLinuxPlugin.takePicture();
    return image;
  }

  @override
  void initState() {
    instance = this;
    cameraLinuxPlugin.startCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraLinuxPlugin.stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
