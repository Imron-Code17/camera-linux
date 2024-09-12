class CameraLinuxController {
  Future<void> Function()? openCam;
  void Function()? retry;
  void Function()? pause;
  void Function()? stop;
  void Function()? resume;
  void Function()? capture;
  late void Function(String)? onScan;

  CameraLinuxController({this.onScan});
}
