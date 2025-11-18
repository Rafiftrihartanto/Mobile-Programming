import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectedCameraIdx = 0;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initCamera(widget.cameras[selectedCameraIdx]);
  }

  void _initCamera(CameraDescription cameraDescription) {
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  Future<void> _switchCamera() async {
    if (widget.cameras.length > 1) {
      selectedCameraIdx = (selectedCameraIdx + 1) % widget.cameras.length;
      _initCamera(widget.cameras[selectedCameraIdx]);
    }
  }

  Future<void> _takePicture() async {
    try {
    await _initializeControllerFuture;

    final XFile file = await _controller.takePicture();
    final Directory dir = await path_provider.getApplicationDocumentsDirectory();
    final String newPath = join(dir.path, basename(file.path));
    await File(file.path).copy(newPath);

    setState(() {
      imagePath = newPath;
    });

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text('Foto tersimpan di: $newPath')),
    );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kamera App')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Path: $imagePath', style: const TextStyle(fontSize: 12)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Ambil Foto'),
              ),
              ElevatedButton.icon(
                onPressed: _switchCamera,
                icon: const Icon(Icons.switch_camera),
                label: const Text('Ganti Kamera'),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
