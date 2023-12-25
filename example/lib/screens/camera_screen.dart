// ignore_for_file: library_private_types_in_public_api, avoid_print, prefer_final_fields

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:example/widgets/ModelDetail.dart';
import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isModelHidden = false;
  final O3DController _o3dController = O3DController(),
      controller2 = O3DController(),
      controller3 = O3DController(),
      controller4 = O3DController();
  List<String> logs = [];
  bool cameraControls = false;

  @override
  void initState() {
    super.initState();
    _o3dController.logger = (data) {
      logs.add(data.toString());
    };
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await _cameraController.initialize();
    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        body: Center(
          child: Text('Camera Loading...'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '3D Object',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: CameraPreview(_cameraController),
          ),
          Visibility(
            visible: !_isModelHidden,
            child: ModelDetail(
              actions: [
                FilledButton(
                  onPressed: () => controller2.animationName = 'Survey',
                  child: const Text('Survey'),
                ),
                FilledButton(
                  onPressed: () => controller2.animationName = 'Walk',
                  child: const Text('Walk'),
                ),
                FilledButton(
                  onPressed: () => controller2.animationName = 'Run',
                  child: const Text('Run'),
                ),
                FilledButton(
                  onPressed: () => controller2.play(repetitions: 10),
                  child: const Text('Play Animation'),
                ),
                FilledButton(
                  onPressed: () async {
                    log("Available animations: ${await controller2.availableAnimations()}");
                  },
                  child: const Text('available animations'),
                ),
              ],
              o3d: O3D(
                controller: controller2,
                src: 'assets/fox.glb',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
