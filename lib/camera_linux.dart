// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:camera_linux/camera_linux_status.dart';
import 'package:ffi/ffi.dart';
import 'package:rxdart/rxdart.dart';

import 'camera_linux_bindings_generated.dart';

class CameraLinux {
  late CameraLinuxBindings _bindings;
  late BehaviorSubject<Uint8List> _liveView;
  late BehaviorSubject<Uint8List> _liveScanBarcode;
  late Timer _frameTimer;
  late Pointer<Uint8> _framePointer;
  late Pointer<Int> _lengthPtr;
  bool _isScan = false;
  bool _isPaused = false;

  StreamController<Uint8List> _barcodeStreamController =
      StreamController<Uint8List>.broadcast();

  CameraLinux({bool? isCameraScan}) {
    final dylib = DynamicLibrary.open('libcamera_linux.so');
    _bindings = CameraLinuxBindings(dylib);
    _liveView = BehaviorSubject<Uint8List>();
    _liveScanBarcode = BehaviorSubject<Uint8List>();
    _framePointer = calloc<Uint8>();
    _lengthPtr = calloc<Int>();
    _isScan = isCameraScan ?? false;
  }

  // Check camera status
  CameraStatus checkCameraStatus() {
    try {
      final status = _bindings.isCameraConnected();
      if (status == 1) {
        return CameraStatusConnected('Camera connected');
      } else {
        return CameraStatusConnected('Camera not connected');
      }
    } catch (e) {
      return CameraStatusError('Error checking camera status: $e');
    }
  }

  // Start Camera
  Future<CameraStatus> startCamera() async {
    try {
      final con = _bindings.isCameraConnected();
      if (con != 1) {
        return CameraStatusNotConnected('Camera not connected');
      }

      _bindings.startVideoCaptureInThread();
      if (_isScan) {
        _startFrameTimerForBarcodeScan();
      } else {
        _startFrameTimerForLiveView();
      }

      return CameraStatusOpened('Camera started');
    } catch (e) {
      return CameraStatusError('Error starting camera: $e');
    }
  }

  // Pause Camera
  CameraStatus pauseCamera() {
    try {
      _bindings.pauseVideoCapture();
      _isPaused = true;
      return CameraStatusPaused('Camera paused');
    } catch (e) {
      return CameraStatusError('Error pausing camera: $e');
    }
  }

  // Resume Camera
  CameraStatus resumeCamera() {
    try {
      _bindings.resumeVideoCapture();
      _isPaused = false;
      return CameraStatusOpened('Camera resumed');
    } catch (e) {
      return CameraStatusError('Error resuming camera: $e');
    }
  }

  // Stop Camera
  CameraStatus stopCamera() {
    try {
      _bindings.stopVideoCapture();
      _frameTimer.cancel();

      if (_isScan) {
        _liveScanBarcode.add(Uint8List(0));
        _liveScanBarcode.close();
        _barcodeStreamController.close();

        _liveScanBarcode = BehaviorSubject<Uint8List>();
        _barcodeStreamController = BehaviorSubject<Uint8List>();
      } else {
        _liveView.add(Uint8List(0));
        _liveView.close();

        _liveView = BehaviorSubject<Uint8List>();
      }

      calloc.free(_framePointer);
      calloc.free(_lengthPtr);
      return CameraStatusClosed('Camera stopped');
    } catch (e) {
      return CameraStatusError('Error stopping camera: $e');
    }
  }

  // Capture Image
  Future<Uint8List> captureImage() async {
    try {
      _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
      final frameSize = _lengthPtr.value;

      if (frameSize > 0) {
        return _getLatestFrameData(_framePointer, frameSize);
      } else {
        throw Exception('Frame size is 0 or invalid.');
      }
    } catch (e) {
      throw Exception('Error taking picture: $e');
    }
  }

  Uint8List _getLatestFrameData(Pointer<Uint8> framePointer, int frameSize) {
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
          final latestFrame = _getLatestFrameData(_framePointer, frameSize);
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
          final latestFrame = _getLatestFrameData(_framePointer, frameSize);
          _liveScanBarcode.add(latestFrame);
          _barcodeStreamController.add(latestFrame);
        }
      } catch (e) {
        print('Error fetching frame or detecting barcode: $e');
      }
    });
  }

  // Stream to provide frame data for live view
  BehaviorSubject<Uint8List> get streamFrame => _liveView;

  // Stream to provide detected barcode/QR code
  BehaviorSubject<Uint8List> get streamBarcode => _liveScanBarcode;

  Stream<Uint8List> get listenCode => _barcodeStreamController.stream;
  StreamController<Uint8List> get streamLisstenCode => _barcodeStreamController;

  // Capture a single picture and return it as Uint8List
  Future<Uint8List?> takePicture() async {
    try {
      _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
      final frameSize = _lengthPtr.value;

      if (frameSize > 0) {
        return _getLatestFrameData(_framePointer, frameSize);
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
