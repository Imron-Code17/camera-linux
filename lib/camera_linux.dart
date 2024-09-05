import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'camera_linux_bindings_generated.dart';
import 'package:ffi/ffi.dart';
import 'package:rxdart_ext/not_replay_value_stream.dart';

class CameraLinux {
  late CameraLinuxBindings _bindings;
  late BehaviorSubject<Uint8List> _liveView;
  late Timer _frameTimer;
  late Pointer<Uint8> _framePointer;
  late Pointer<Int> _lengthPtr;

  CameraLinux() {
    final dylib = DynamicLibrary.open('libcamera_linux.so');
    _bindings = CameraLinuxBindings(dylib);
    _liveView = BehaviorSubject<Uint8List>();
    _framePointer = calloc<Uint8>();
    _lengthPtr = calloc<Int>();
  }

  // Open Default Camera
  Future<void> initializeCamera() async {
    _bindings.startVideoCaptureInThread();
    _startFrameTimer();
  }

  // Close The Camera
void stopCamera() {
  _bindings.stopVideoCapture();
  _stopFrameTimer();
  _cleanup();
  _liveView.close();
}

  // Get The Latest Frame
  Uint8List getLatestFrameData(Pointer<Uint8> framePointer, int frameSize) {
    List<int> frameList = framePointer.asTypedList(frameSize);
    return Uint8List.fromList(frameList);
  }

  // Start the Frame Timer to regularly fetch frames
  void _startFrameTimer() {
    _frameTimer = Timer.periodic(Duration(milliseconds: 30), (timer) async {
      try {
        // Fetch frame
        _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
        final frameSize = _lengthPtr.value;

        // Ensure frame size is valid
        if (frameSize > 0) {
          final latestFrame = getLatestFrameData(_framePointer, frameSize);
          _liveView.add(latestFrame);
        }
      } catch (e) {
        // Handle any potential errors
        print('Error fetching frame: $e');
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

  // Stream to provide frame data
  BehaviorSubject<Uint8List> get streamFrame => _liveView;

  // Capture a single picture and return it as Uint8List
  Future<Uint8List?> takePicture() async {
    try {
      // Fetch a single frame
      _framePointer = _bindings.getLatestFrameBytes(_lengthPtr);
      final frameSize = _lengthPtr.value;

      // Ensure frame size is valid
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
