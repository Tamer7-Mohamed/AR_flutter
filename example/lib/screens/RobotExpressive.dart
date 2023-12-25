// ignore_for_file: file_names, prefer_final_fields

import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:example/widgets/ModelDetail.dart';
import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class RobotExpressive extends StatefulWidget {
  const RobotExpressive({Key? key}) : super(key: key);

  @override
  State<RobotExpressive> createState() => _RobotExpressiveState();
}

class _RobotExpressiveState extends State<RobotExpressive> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isModelHidden = false;
  final O3DController controller = O3DController(),
      controller3 = O3DController(),
      controller2 = O3DController();

  List<String> logs = [];
  bool cameraControls = false;

  @override
  void initState() {
    super.initState();
    controller.logger = (data) {
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
                  onPressed: () => controller3.animationName = 'Running',
                  child: const Text('Running'),
                ),
                FilledButton(
                  onPressed: () => controller3.animationName = 'Dance',
                  child: const Text('Dance'),
                ),
                FilledButton(
                  onPressed: () => controller3.animationName = 'Wave',
                  child: const Text('Wave'),
                ),
                FilledButton(
                  onPressed: () => controller3.animationName = 'Idle',
                  child: const Text('Idle'),
                ),
                FilledButton(
                  onPressed: () {
                    controller2
                        .availableAnimations()
                        .then((value) => log("Available animations: $value"));
                  },
                  child: const Text('available animations'),
                ),
              ],
              o3d: O3D(
                controller: controller3,
                src:
                    'https://modelviewer.dev/shared-assets/models/RobotExpressive.glb',
                autoPlay: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
