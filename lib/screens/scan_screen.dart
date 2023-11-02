import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr_app/screens/scanned_meter_details.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  late CameraController controller;
  final textRecognizer = TextRecognizer();
  //request permission
  void requestCameraPermission() async {
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
    // if(await Permission.sensors.)
    final cameras = await availableCameras();
    initializeCameraController(cameras);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // controller?.dispose();
      stopCamera();
    } else if (state == AppLifecycleState.resumed) {
      // cameraSelected(controller!.description);
      startCamera();
      // _initializeCameraController(cameraController.description);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    requestCameraPermission();
    startCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Scan Meter',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  if (controller.value.isInitialized) {
                    debugPrint(
                        'Flash mode --------------------------- ${controller.value.flashMode}');
                    if (controller.value.flashMode == FlashMode.torch) {
                      await controller.setFlashMode(FlashMode.off);
                    } else {
                      await controller.setFlashMode(FlashMode.always);
                    }
                  }
                },
                icon: Icon(controller.value.isInitialized
                    ? Icons.offline_bolt
                    : Icons.bolt))
          ],
        ),
        body: controller.value.isInitialized
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: CameraPreview(controller),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () => scanImage(),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 50, right: 50, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0XFF2B4196)),
                        child: const Text('Scan'),
                      ),
                    ),
                  )
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  void startCamera() async {
    if (controller.value.isInitialized) {
      cameraSelected(controller.description);
    }
  }

  void stopCamera() {
    controller.dispose();
  }

  Future<void> cameraSelected(CameraDescription camera) async {
    controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await controller.initialize();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void initializeCameraController(List<CameraDescription> cameras) {
    // If the controller is updated then update the UI.
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.back) {
        cameraSelected(camera);
      }
    }
  }

  Future<void> scanImage() async {
    if (!controller.value.isInitialized) return;
    try {
      final pictureFile = await controller.takePicture();
      final file = File(pictureFile.path);
      final inputImage = InputImage.fromFile(file);
      final text = await textRecognizer
          .processImage(inputImage)
          .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScannedMeterDetails(
                  file: file,
                  scannedText: value.text,
                ),
              )));
      debugPrint(
          '------------------Scanned Text------------------\n${text.text}');
    } catch (e) {
      debugPrint('Error --------------------------------------- $e');
    }
  }
}
