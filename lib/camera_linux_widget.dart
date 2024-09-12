import 'dart:io';
import 'dart:typed_data';

import 'package:camera_linux/camera_linux.dart';
import 'package:camera_linux/camera_linux_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class CameraLinuxWidget extends StatefulWidget {
  final bool isCameraScan;
  final Function(String?)? onScan;
  final Widget Function(void Function() open)? connectedWiget;
  final Widget Function(void Function() retry)? notConnectedWidget;
  final Widget Function(void Function() retry)? errorWidget;
  final Widget Function(void Function() resume, void Function() stop)?
      pausedWidget;
  final Widget Function(void Function() pause, void Function() stop,
      Future<Uint8List?> Function() capture, Widget preview)? openedWidget;
  final Widget Function(Function() resume, Function() open)? closedWidget;

  const CameraLinuxWidget({
    super.key,
    this.onScan,
    this.connectedWiget,
    this.notConnectedWidget,
    this.errorWidget,
    this.pausedWidget,
    this.openedWidget,
    this.closedWidget,
    this.isCameraScan = false,
  });

  @override
  State<CameraLinuxWidget> createState() => _CameraLinuxWidgetState();
}

class _CameraLinuxWidgetState extends State<CameraLinuxWidget> {
  late CameraLinux _cameraP;
  late CameraStatus _status;
  Uint8List? _capturedImage;

  Future<String> _writeFrameToFile(Uint8List frame) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/temp_image_qr.png');

    await file.writeAsBytes(frame);
    return file.path;
  }

  void readQrCode() {
    _cameraP.listenCode
        .throttleTime(const Duration(milliseconds: 1200))
        .listen((frame) async {
      if (frame.isNotEmpty) {
        final filePath = await _writeFrameToFile(frame);
        final xFile = XFile(filePath);
        final result = await zx.readBarcodeImagePath(
            xFile, DecodeParams(imageFormat: ImageFormat.rgb));

        if (widget.onScan != null) widget.onScan!(result.text);
      }
    });
  }

  @override
  void initState() {
    _cameraP = CameraLinux(isCameraScan: widget.isCameraScan);
    _status = _cameraP.checkCameraStatus();
    readQrCode();
    super.initState();
  }

  Widget get _preview {
    return StreamBuilder<Uint8List>(
      stream: _cameraP.streamBarcode.stream,
      initialData: Uint8List(0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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

  Future<void> _openCam() async {
    _status = await _cameraP.startCamera();
    setState(() {});
  }

  void _retry() {
    _status = _cameraP.checkCameraStatus();
    setState(() {});
  }

  void _pause() {
    _status = _cameraP.pauseCamera();
    setState(() {});
  }

  void _stop() {
    _status = _cameraP.stopCamera();
    setState(() {});
  }

  void _resume() {
    _status = _cameraP.resumeCamera();
    setState(() {});
  }

  Future<Uint8List?> _capture() async {
    try {
      _capturedImage = await _cameraP.captureImage();
      setState(() {});
      return _capturedImage;
    } catch (e) {
      return null;
    }
  }

  Widget get _connectedWidget {
    return widget.connectedWiget != null
        ? widget.connectedWiget!(_openCam)
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
        ? widget.notConnectedWidget!(_retry)
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
        ? widget.errorWidget!(_retry)
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
        ? widget.openedWidget!(
            _pause,
            _stop,
            _capture,
            _preview,
          )
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
        ? widget.pausedWidget!(_resume, _stop)
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
                ElevatedButton(onPressed: _resume, child: const Text("Resume")),
                ElevatedButton(onPressed: _stop, child: const Text("Stop")),
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
                _status = await _cameraP.startCamera();
                setState(() {});
              },
              child: const Text("Open Camera"))
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
