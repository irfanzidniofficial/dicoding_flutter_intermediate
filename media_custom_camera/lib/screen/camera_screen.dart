import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  /// todo-camera-02: create a variable to check Camera is initialize or not
  bool _isCameraInitialized = false;
  bool _isBackCameraSelected = true;

  /// todo-camera-03: create a variable to handle a camera controller
  CameraController? controller;

  /// todo-camera-04: create a function to handle initializing camera
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    /// todo-camera-05: instantiating the camera controller and disposing the previous one
    final previousCameraController = controller;
    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    await previousCameraController?.dispose();

    /// todo-camera-06: Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    /// todo-camera-07: Update the Boolean
    if (mounted) {
      setState(() {
        controller = cameraController;
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onNewCameraSelected(widget.cameras.first);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ambil Gambar"),
          actions: [
            IconButton(
              onPressed: () => _onCameraSwitch(),
              icon: const Icon(Icons.cameraswitch),
            ),
          ],
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// todo-camera-09: show the camera view
              _isCameraInitialized
                  ? CameraPreview(controller!)
                  : const Center(child: CircularProgressIndicator()),
              Align(
                alignment: const Alignment(0, 0.95),
                child: _actionWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionWidget() {
    return FloatingActionButton(
      heroTag: "take-picture",
      tooltip: "Ambil Gambar",
      onPressed: () => _onCameraButtonClick(),
      child: const Icon(Icons.camera_alt),
    );
  }

  Future<void> _onCameraButtonClick() async {
    /// todo-click-01: take a picture and go back to HomeScreen
    final navigator = Navigator.of(context);
    final image = await controller?.takePicture();

    navigator.pop(image);
  }

  void _onCameraSwitch() {
    if (widget.cameras.length == 1) return;
    setState(() {
      _isCameraInitialized = false;
    });

    onNewCameraSelected(
      widget.cameras[_isBackCameraSelected ? 1 : 0],
    );

    setState(() {
      _isBackCameraSelected = !_isBackCameraSelected;
    });
  }
}
