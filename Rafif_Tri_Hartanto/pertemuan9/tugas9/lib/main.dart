import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: CameraPage(cameras: cameras),
    );
  }
}

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
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  void _switchCamera() {
    setState(() {
      selectedCameraIdx = (selectedCameraIdx + 1) % widget.cameras.length;
      _initCamera(widget.cameras[selectedCameraIdx]);
    });
  }

  Future<void> _takePicture(BuildContext context) async {
    try {
      await _initializeControllerFuture;

      // Ambil gambar
      final image = await _controller.takePicture();

      // Simpan foto ke direktori lokal (Documents)
      final directory = await getApplicationDocumentsDirectory();
      final newPath = join(
        directory.path,
        'foto_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await File(image.path).copy(newPath);

      setState(() {
        imagePath = newPath;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto tersimpan di: $newPath')),
      );
    } catch (e) {
      debugPrint("Error saat mengambil gambar: $e");
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
      appBar: AppBar(
        title: const Text('Camera Preview'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(child: CameraPreview(_controller)),
                if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Path foto terakhir:\n$imagePath',
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _takePicture(context),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
