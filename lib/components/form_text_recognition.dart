import 'dart:io';

import 'package:camera/camera.dart';
import 'package:digital_data_tree/components/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';

import '../view_models/form_info_view_model.dart';

class TextRecognition extends StatefulWidget {
  const TextRecognition({super.key, required this.label});
  final String label;

  @override
  State<TextRecognition> createState() => _TextRecognition();
}

class _TextRecognition extends State<TextRecognition>
    with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  String _scanResult = "Scan something";
  bool _scanDone = false;

  late final Future<void> _future;
  final textRecognizer = TextRecognizer();

  // Add this controller to be able to control de camera
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  // We should stop the camera once this widget is disposed
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  // Starts and stops the camera according to the lifecycle of the app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            // Show the camera feed behind everything
            if (_isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(child: CameraPreview(_cameraController!));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              // Set the background to transparent so you can see the camera preview
              backgroundColor: _isPermissionGranted ? Colors.transparent : null,
              body: _isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Column(
                            children: [
                              Text(
                                _scanResult,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              AppButton.normalButton(
                                  title: _scanDone ? 'Done' : 'Scan Text',
                                  onPress: () {
                                    if (_scanDone) {
                                      context
                                          .read<FormInfoViewModel>()
                                          .addInfo({
                                        'label': widget.label,
                                        'info': _scanResult,
                                        'element': 18
                                      });

                                      Navigator.pop(context);
                                    } else {
                                      _scanImage(widget.label);
                                    }
                                  })
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          'Camera permission denied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage(String label) async {
    if (_cameraController == null) return;

    try {
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);

      setState(() {
        _scanResult = recognizedText.text;
        _scanDone = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }
}
