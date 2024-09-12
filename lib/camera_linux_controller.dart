class CameraLinuxController {
  late Future<void> Function() openCam;
  late void Function() retry;
  late void Function() pause;
  late void Function() stop;
  late void Function() resume;
  late void Function() capture;
  late void Function(String)? onScan;

  CameraLinuxController({this.onScan});
}
