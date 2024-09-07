import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:rxdart_ext/not_replay_value_stream.dart';
import 'camera_linux_bindings_generated.dart'; // Binding untuk kamera

class CameraLinux {
  late CameraLinuxBindings _bindings;
  late BehaviorSubject<Uint8List> _liveView;
  late BehaviorSubject<Uint8List> _liveScanBarcode; // Barcode stream as String
  late Timer _frameTimer;
  late Pointer<Uint8> _framePointer;
  late Pointer<Int> _lengthPtr;
  int width =
      640; // Placeholder for image width (adjust based on your frame size)
  int height =
      480; // Placeholder for image height (adjust based on your frame size)
  bool isScan = false;
  bool _isPaused = false;

  final StreamController<Uint8List> _barcodeStreamController =
      StreamController<Uint8List>.broadcast();

  CameraLinux({bool? isCameraScan}) {
    final dylib = DynamicLibrary.open('libcamera_linux.so');
    _bindings = CameraLinuxBindings(dylib);

    _liveView = BehaviorSubject<Uint8List>();
    _liveScanBarcode = BehaviorSubject<Uint8List>(); // Barcode stream as String
    _framePointer = calloc<Uint8>();
    _lengthPtr = calloc<Int>();
    isScan = isCameraScan ?? false;
  }

  // Open Default Camera
  Future<void> initializeCamera() async {
    _bindings.startVideoCaptureInThread();
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
    _cleanup();
    if (isScan) {
      _liveScanBarcode.close();
    } else {
      _liveView.close();
    }
    _barcodeStreamController.close();
  }

  void pauseCamera() {
    _isPaused = true; // Set the paused status to true
  }

  // Resume the camera feed
  void resumeCamera() {
    _isPaused = false; // Set the paused status to false
  }

  // Get The Latest Frame
  Uint8List getLatestFrameData(Pointer<Uint8> framePointer, int frameSize) {
    List<int> frameList = framePointer.asTypedList(frameSize);
    return Uint8List.fromList(frameList);
  }

  // Start the Frame Timer for Live View to regularly fetch frames
  void _startFrameTimerForLiveView() {
    _frameTimer =
        Timer.periodic(const Duration(milliseconds: 30), (timer) async {
      try {
        if (_isPaused) {
          return; // If paused, skip fetching the frame
        }
        // Fetch frame
        _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
        final frameSize = _lengthPtr.value;

        // Ensure frame size is valid
        if (frameSize > 0) {
          final latestFrame = getLatestFrameData(_framePointer, frameSize);
          _liveView.add(latestFrame); // Add frame to live view stream
        }
      } catch (e) {
        print('Error fetching frame for live view: $e');
      }
    });
  }

  // Start the Frame Timer for Barcode/QR Code Scan
  void _startFrameTimerForBarcodeScan() {
    _frameTimer =
        Timer.periodic(const Duration(milliseconds: 30), (timer) async {
      try {
        if (_isPaused) {
          return; // If paused, skip fetching the frame
        }
        // Fetch frame
        _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
        final frameSize = _lengthPtr.value;

        // Ensure frame size is valid
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

  // Stream to provide detected barcode/QR code values as String
  BehaviorSubject<Uint8List> get streamBarcode => _liveScanBarcode;

  Stream<Uint8List> get listenCode => _barcodeStreamController.stream;
  StreamController<Uint8List> get streamLisstenCode => _barcodeStreamController;

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
