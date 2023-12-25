// ignore_for_file: prefer_final_fields

import 'package:camera/camera.dart';
import 'package:example/widgets/ModelDetail.dart';
import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class CameraZombie extends StatefulWidget {
  const CameraZombie({Key? key}) : super(key: key);

  @override
  State<CameraZombie> createState() => _CameraZombieState();
}

class _CameraZombieState extends State<CameraZombie> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isModelHidden = false;
  final O3DController controller = O3DController(),
      controller4 = O3DController();
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
                FilledButton.icon(
                    onPressed: () => controller4.animationName = 'FallingBack',
                    icon: const Icon(Icons.add),
                    label: const Text("shoot him")),
                FilledButton.icon(
                    onPressed: () =>
                        controller4.animationName = 'FallingForward',
                    icon: const Icon(Icons.add),
                    label: const Text("shoot leg")),
                FilledButton(
                    onPressed: () => controller4.animationName = 'Run',
                    child: const Text('Run')),
                FilledButton(
                    onPressed: () => controller4.animationName = 'Idle',
                    child: const Text('Idle')),
                FilledButton(
                    onPressed: () => controller4.cameraTarget(0, 1, 2.5),
                    child: const Text('ZoomOut')),
                FilledButton(
                    onPressed: () => controller4.cameraTarget(0, 1, 0),
                    child: const Text('ZoomIn'))
              ],
              o3d: O3D(
                  controller: controller4,
                  src: 'assets/zombie.glb',
                  autoPlay: true,
                  cameraControls: false,
                  cameraTarget: CameraTarget(0, 1, 0)),
            ),
          ),
        ],
      ),
    );
  }
}
