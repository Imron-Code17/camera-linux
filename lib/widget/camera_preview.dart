import 'dart:typed_data';
import 'package:camera_linux/widget/camera_controller.dart';
import 'package:flutter/material.dart';

class CameraPreview extends StatefulWidget {
  final Function(Uint8List?)? onTake;
  const CameraPreview({super.key, this.onTake});

  Widget build(context, CameraController controller) {
    controller.view = this;
    return StreamBuilder<Uint8List>(
      stream: controller.cameraLinuxPlugin.streamFrame.stream,
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

  @override
  State<CameraPreview> createState() => CameraController();
}
