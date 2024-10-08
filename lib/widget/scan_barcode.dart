// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera_linux/camera_linux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class ScanBarcode extends StatefulWidget {
  final Function(String?)? onScan;
  const ScanBarcode({super.key, this.onScan});

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  final cameraLinuxPlugin = CameraLinux();
  Future<String> _writeFrameToFile(Uint8List frame) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/temp_image_qr.png');

    await file.writeAsBytes(frame);
    return file.path;
  }

  void readQrCode() {
    cameraLinuxPlugin.listenCode
        .throttleTime(const Duration(milliseconds: 1200))
        .listen((frame) async {
      if (frame != null && frame.isNotEmpty) {
        final filePath = await _writeFrameToFile(frame);
        final xFile = XFile(filePath);
        final Code result = await zx.readBarcodeImagePath(
            xFile, DecodeParams(imageFormat: ImageFormat.rgb));
        widget.onScan?.call(result.text);
      } else {
        log("Received null or empty frame");
      }
    });
  }

  @override
  void initState() {
    cameraLinuxPlugin.initializeCamera();
    readQrCode();
    super.initState();
  }

  @override
  void dispose() {
    cameraLinuxPlugin.stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uint8List>(
      stream: cameraLinuxPlugin.streamBarcode.stream,
      initialData: Uint8List(0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No frame available'));
        }

        return Transform.flip(
          flipX: false,
          flipY: false,
          filterQuality: FilterQuality.high,
          child: Image.memory(
            snapshot.data!,
            gaplessPlayback: true,
            filterQuality: FilterQuality.high,
          ),
        );
      },
    );
  }
}
