import 'dart:io';
import 'dart:typed_data';
import 'package:camera_linux/camera_linux.dart';
import 'package:camera_linux/camera_linux_controller.dart';
import 'package:camera_linux/camera_linux_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class CameraLinuxWidget extends StatefulWidget {
  final CameraLinuxController controller;
  final Widget? loadingWidget;
  final Widget? connectedWiget;
  final Widget? notConnectedWidget;
  final Widget? errorWidget;
  final Widget? Function(Widget preview)? pausedWidget;
  final Widget? Function(Widget preview)? openedWidget;
  final Widget? closedWidget;

  const CameraLinuxWidget({
    super.key,
    required this.controller,
    this.connectedWiget,
    this.notConnectedWidget,
    this.errorWidget,
    this.pausedWidget,
    this.openedWidget,
    this.loadingWidget,
    this.closedWidget,
  });

  @override
  State<CameraLinuxWidget> createState() => _CameraLinuxWidgetState();
}

class _CameraLinuxWidgetState extends State<CameraLinuxWidget> {
  late CameraLinux _cameraP;
  late CameraStatus _status;

  @override
  void initState() {
    _cameraP = CameraLinux(isCameraScan: widget.controller.onScan != null);
    _status = _cameraP.checkCameraStatus();
    if (_status is CameraStatusConnected) _openCam();
    if (widget.controller.onScan != null) _readQrCode();
    widget.controller.openCam = _openCam;
    widget.controller.retry = _retry;
    widget.controller.pause = _pause;
    widget.controller.stop = _stop;
    widget.controller.resume = _resume;
    widget.controller.capture = _capture;
    super.initState();
  }

  Uint8List? _capturedImage;

  Future<void> _openCam() async {
    _status = await _cameraP.startCamera();
    if (mounted) setState(() {});
  }

  void _retry() {
    _status = _cameraP.checkCameraStatus();
    if (mounted) setState(() {});
  }

  void _pause() {
    _status = _cameraP.pauseCamera();
    if (mounted) setState(() {});
  }

  void _stop() {
    _status = _cameraP.stopCamera();
    if (mounted) setState(() {});
  }

  void _resume() {
    _status = _cameraP.resumeCamera();
    if (mounted) setState(() {});
  }

  Future<Uint8List?> _capture() async {
    try {
      _capturedImage = await _cameraP.captureImage();
      if (mounted) setState(() {});
      return _capturedImage;
    } catch (e) {
      return null;
    }
  }

  void _readQrCode() {
    _cameraP.listenCode
        .throttleTime(const Duration(milliseconds: 1200))
        .listen((frame) async {
      if (frame.isNotEmpty) {
        final filePath = await _writeFrameToFile(frame);
        final xFile = XFile(filePath);
        final result = await zx.readBarcodeImagePath(
            xFile, DecodeParams(imageFormat: ImageFormat.rgb));

        if (result.text != null) {
          widget.controller.onScan!(result.text!);
        }
      }
    });
  }

  Future<String> _writeFrameToFile(Uint8List frame) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/temp_image_qr.png');

    await file.writeAsBytes(frame);
    return file.path;
  }

  Widget get _preview {
    return StreamBuilder<Uint8List>(
      stream: _cameraP.streamBarcode.stream,
      initialData: Uint8List(0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ??
              const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No frame available'));
        }

        return Transform.rotate(
          angle: -3.14159 / 2,
          filterQuality: FilterQuality.high,
          child: Image.memory(
            snapshot.data!,
            gaplessPlayback: true,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget get _connectedWidget {
    return widget.connectedWiget != null
        ? widget.connectedWiget!
        : Center(
            child: Column(
              children: [
                Text(_status.message),
                ElevatedButton(
                    onPressed: _openCam, child: const Text("Open Camera"))
              ],
            ),
          );
  }

  Widget get _notConnectedWidget {
    return widget.notConnectedWidget != null
        ? widget.notConnectedWidget!
        : Center(
            child: Column(
              children: [
                Text(_status.message),
                ElevatedButton(onPressed: _retry, child: const Text("Retry"))
              ],
            ),
          );
  }

  Widget get _errorWidget {
    return widget.errorWidget != null
        ? widget.errorWidget!
        : Center(
            child: Column(
              children: [
                Text(_status.message),
                ElevatedButton(onPressed: _retry, child: const Text("Retry"))
              ],
            ),
          );
  }

  Widget get _openedWidget {
    return widget.openedWidget != null
        ? widget.openedWidget!(_preview)!
        : Center(
            child: Column(
              children: [
                if (_capturedImage != null)
                  Image.memory(
                    _capturedImage!,
                    height: 40,
                    width: 40,
                  ),
                _preview,
                Text(_status.message),
                ElevatedButton(onPressed: _pause, child: const Text("Pause")),
                ElevatedButton(onPressed: _stop, child: const Text("Stop")),
                ElevatedButton(
                    onPressed: _capture, child: const Text("Capture Image")),
              ],
            ),
          );
  }

  Widget get _pausedWidget {
    return widget.pausedWidget != null
        ? widget.pausedWidget!(_preview)!
        : Center(
            child: Column(
              children: [
                if (_capturedImage != null)
                  Image.memory(
                    _capturedImage!,
                    height: 40,
                    width: 40,
                  ),
                _preview,
                Text(_status.message),
                ElevatedButton(
                  onPressed: _resume,
                  child: const Text("Resume"),
                ),
                ElevatedButton(
                  onPressed: _stop,
                  child: const Text("Stop"),
                ),
              ],
            ),
          );
  }

  Widget get _closedWidget {
    return Center(
      child: Column(
        children: [
          Text(_status.message),
          ElevatedButton(onPressed: _openCam, child: const Text("Open Camera"))
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
    return _child;
  }
}
