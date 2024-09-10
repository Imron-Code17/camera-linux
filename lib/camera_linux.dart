// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:rxdart/rxdart.dart';
import 'camera_linux_bindings_generated.dart';

class CameraLinux {
  late CameraLinuxBindings _bindings;
  late BehaviorSubject<Uint8List> _liveView;
  late BehaviorSubject<Uint8List> _liveScanBarcode;
  late Timer _frameTimer;
  late Timer _statusTimer;
  late Pointer<Uint8> _framePointer;
  late Pointer<Int> _lengthPtr;
  bool isScan = false;
  bool _isPaused = false;

  final StreamController<Uint8List> _barcodeStreamController =
      StreamController<Uint8List>.broadcast();
  final StreamController<bool> _checkCameraConnection =
      StreamController<bool>.broadcast();

  CameraLinux({bool? isCameraScan}) {
    final dylib = DynamicLibrary.open('libcamera_linux.so');
    _bindings = CameraLinuxBindings(dylib);

    _liveView = BehaviorSubject<Uint8List>();
    _liveScanBarcode = BehaviorSubject<Uint8List>();
    _framePointer = calloc<Uint8>();
    _lengthPtr = calloc<Int>();
    isScan = isCameraScan ?? false;
  }

  void startCheckingCameraConnection() {
    _statusTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      isCameraConnected();
    });
  }

  void stopCheckingCameraConnection() {
    _statusTimer.cancel();
  }

  void isCameraConnected() {
    final status = _bindings.isCameraConnected();
    _checkCameraConnection.add(status == 1);
  }

  // Open Default Camera
  Future<void> initializeCamera() async {
    _bindings.startVideoCaptureInThread();
    startCheckingCameraConnection();
    if (isScan) {
      _startFrameTimerForBarcodeScan();
    } else {
      _startFrameTimerForLiveView();
    }
  }

  // Close The Camera
  void stopCamera() {
    _bindings.stopVideoCapture();
    _stopFrameTimer();
    stopCheckingCameraConnection();
    if (isScan) {
      _liveScanBarcode.add(Uint8List(0));
      _liveScanBarcode.close();
      _barcodeStreamController.close();
    } else {
      _liveView.add(Uint8List(0));
      _liveView.close();
    }

    _checkCameraConnection.close();
    _cleanup();
  }

  void pauseCamera() {
    _isPaused = true;
    _bindings.pauseVideoCapture();
  }

  // Resume the camera feed
  void resumeCamera() {
    _isPaused = false;
    _bindings.resumeVideoCapture();
  }

  Uint8List getLatestFrameData(Pointer<Uint8> framePointer, int frameSize) {
    if (frameSize <= 0) {
      return Uint8List(0);
    }
    return framePointer.asTypedList(frameSize);
  }

  void _startFrameTimerForLiveView() {
    _frameTimer =
        Timer.periodic(const Duration(milliseconds: 2), (timer) async {
      try {
        if (_isPaused) {
          return;
        }
        // Fetch frame
        _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
        final frameSize = _lengthPtr.value;

        if (frameSize > 0) {
          final latestFrame = getLatestFrameData(_framePointer, frameSize);
          _liveView.add(latestFrame);
        }
      } catch (e) {
        print('Error fetching frame for live view: $e');
      }
    });
  }

  // Start the Frame Timer for Barcode/QR Code Scan
  void _startFrameTimerForBarcodeScan() {
    _frameTimer =
        Timer.periodic(const Duration(milliseconds: 20), (timer) async {
      try {
        if (_isPaused) {
          return;
        }

        _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
        final frameSize = _lengthPtr.value;

        if (frameSize > 0) {
          final latestFrame = getLatestFrameData(_framePointer, frameSize);
          _liveScanBarcode.add(latestFrame);
          _barcodeStreamController.add(latestFrame);
        }
      } catch (e) {
        print('Error fetching frame or detecting barcode: $e');
      }
    });
  }

  // Stop the Frame Timer
  void _stopFrameTimer() {
    _frameTimer.cancel();
  }

  // Cleanup resources
  void _cleanup() {
    calloc.free(_framePointer);
    calloc.free(_lengthPtr);
  }

  // Stream to provide frame data for live view
  BehaviorSubject<Uint8List> get streamFrame => _liveView;

  // Stream to provide detected barcode/QR code
  BehaviorSubject<Uint8List> get streamBarcode => _liveScanBarcode;

  Stream<Uint8List> get listenCode => _barcodeStreamController.stream;
  StreamController<Uint8List> get streamLisstenCode => _barcodeStreamController;
  StreamController<bool> get cameraStatus => _checkCameraConnection;

  // Capture a single picture and return it as Uint8List
  Future<Uint8List?> takePicture() async {
    try {
      _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
      final frameSize = _lengthPtr.value;

      if (frameSize > 0) {
        return getLatestFrameData(_framePointer, frameSize);
      } else {
        print('Error: Frame size is 0 or invalid.');
        return null;
      }
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }
}
