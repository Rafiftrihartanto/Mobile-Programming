import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({required this.cameras, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamera App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: CameraScreen(cameras: cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({required this.cameras, super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCamera(widget.cameras[selectedCameraIndex]);
  }

  void _initCamera(CameraDescription cameraDescription) {
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _switchCamera() async {
    setState(() {
      selectedCameraIndex = (selectedCameraIndex + 1) % widget.cameras.length;
      _initCamera(widget.cameras[selectedCameraIndex]);
    });
  }

  Future<void> _takePicture(BuildContext context) async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, '${DateTime.now()}.png');
      await File(image.path).copy(path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto disimpan di: $path')),
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
      appBar: AppBar(title: const Text('Preview Kamera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _switchCamera,
            heroTag: "switch",
            child: const Icon(Icons.cameraswitch),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => _takePicture(context),
            heroTag: "capture",
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
