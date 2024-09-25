// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera_linux/camera_linux.dart';
import 'package:camera_linux/camera_linux_controller.dart';
import 'package:camera_linux/camera_linux_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:image/image.dart' as img;

enum CameraType { scan, selfie }

class CameraLinuxWidget extends StatefulWidget {
  final CameraLinuxController controller;
  final CameraType type;
  final Widget? loadingWidget;
  final Widget? connectedWiget;
  final Widget? notConnectedWidget;
  final Widget? errorWidget;
  final Widget? Function(Widget preview)? pausedWidget;
  final Widget? Function(Widget preview)? openedWidget;
  final Widget? closedWidget;
  final Function(Uint8List)? onCapture;
  final Widget? overlayWidget;

  const CameraLinuxWidget(
      {super.key,
      required this.controller,
      this.type = CameraType.selfie,
      this.connectedWiget,
      this.notConnectedWidget,
      this.errorWidget,
      this.pausedWidget,
      this.openedWidget,
      this.loadingWidget,
      this.closedWidget,
      this.onCapture,
      this.overlayWidget});

  @override
  State<CameraLinuxWidget> createState() => _CameraLinuxWidgetState();
}

class _CameraLinuxWidgetState extends State<CameraLinuxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late CameraLinux _cameraP;
  late CameraStatus _status;
  int countTakePhoto = 4;
  Timer? _timer;

  @override
  void initState() {
    _cameraP = CameraLinux(isCameraScan: widget.type == CameraType.scan);
    _status = _cameraP.checkCameraStatus();
    if (_status is CameraStatusConnected) _openCam();
    if (widget.controller.onScan != null) _readQrCode();
    widget.controller.openCam = _openCam;
    widget.controller.retry = _retry;
    widget.controller.pause = _pause;
    widget.controller.stop = _stop;
    widget.controller.resume = _resume;
    widget.controller.capture = _capture;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  void _capture() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (value) async {
      countTakePhoto--;
      if (mounted) setState(() {});

      if (countTakePhoto == 0) {
        countTakePhoto = 4;
        _timer?.cancel();
        final result = await _cameraP.captureImage();
        _capturedImage = rotateImage(result);
        widget.onCapture!(_capturedImage!);
        if (mounted) setState(() {});
        _pause();
        if (mounted) setState(() {});
      }
    });
  }

  Uint8List? rotateImage(Uint8List captureImage) {
    img.Image? originalImage = img.decodeImage(captureImage);
    if (originalImage != null) {
      img.Image rotatedImage = img.copyRotate(originalImage, angle: -90);
      Uint8List rotatedBytes = Uint8List.fromList(img.encodeJpg(rotatedImage));
      return rotatedBytes;
    } else {
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

  Widget get _scanPreview {
    return Stack(
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.width / 1.8,
            width: MediaQuery.of(context).size.width / 1.8,
            decoration: BoxDecoration(
                border: DashedBorder.all(
                  color: const Color(0xffAD9A4A),
                  dashLength: 40,
                  width: 3,
                  isOnlyCorner: true,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  strokeCap: StrokeCap.round,
                ),
                borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.width / 1.94,
                  width: MediaQuery.of(context).size.width / 1.94,
                  child: StreamBuilder<Uint8List>(
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
                  )),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Align(
                  alignment: Alignment(0, _animation.value * 2 - 1),
                  child: child,
                );
              },
              child: Container(
                height: (MediaQuery.of(context).size.width / 1.94) / 4,
                width: MediaQuery.of(context).size.width / 1.94,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blue.withOpacity(0),
                  Colors.blue.withOpacity(0.2),
                  Colors.blue.withOpacity(0.4),
                  Colors.blue.withOpacity(0.2),
                  Colors.blue.withOpacity(0),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _preview {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      width: MediaQuery.of(context).size.width / 1.14,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: StreamBuilder<Uint8List>(
                stream: _cameraP.streamFrame.stream,
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

                  return Transform.scale(
                    scale: 1.4,
                    child: Transform.rotate(
                      angle: -3.14159 / 2,
                      filterQuality: FilterQuality.high,
                      child: Image.memory(
                        snapshot.data!,
                        gaplessPlayback: true,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: widget.overlayWidget ?? const SizedBox.shrink()),
          ),
          Positioned.fill(
              child: Visibility(
            visible: countTakePhoto < 4 && countTakePhoto != 0,
            child: Center(
                child: GradientText(
                    Text('$countTakePhoto',
                        style: const TextStyle(
                            fontSize: 72, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                    type: Type.linear,
                    radius: 1,
                    colors: const [Color(0xffAD9A4A), Colors.white])),
          ))
        ],
      ),
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
        ? widget.openedWidget!(
            widget.type == CameraType.scan ? _scanPreview : _preview)!
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
