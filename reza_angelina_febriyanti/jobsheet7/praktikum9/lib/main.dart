import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras(); // Dapatkan daftar kamera
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    //Menggunakan Material Design
    return MaterialApp(
      title: 'Praktikum 9 - Kamera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true, // 🔹 Material Design 3
      ),
      home: CameraPage(cameras: cameras),
    );
  }
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  int _selectedCameraIdx = 0;
  bool _isCameraReady = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera(_selectedCameraIdx);
  }

  Future<void> _initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.medium,
    );

    await _controller!.initialize();
    if (!mounted) return;
    setState(() => _isCameraReady = true);
  }

  void _onSwitchCamera() {
    if (widget.cameras.length < 2) return;
    _selectedCameraIdx = (_selectedCameraIdx + 1) % widget.cameras.length;
    _initializeCamera(_selectedCameraIdx);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 9 - Kamera'),
        centerTitle: true,
        actions: [
          IconButton( //Switch kamera depan/belakang
            icon: const Icon(Icons.cameraswitch),
            tooltip: 'Ganti Kamera',
            onPressed: _onSwitchCamera,
          ),
        ],
      ),
      body: _isCameraReady
          ? Column(
              children: [
                Expanded(child: CameraPreview(_controller!)), //Menampilkan preview kamera
                if (_capturedImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'File path: ${_capturedImage!.path}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final image = await _controller!.takePicture(); //mengambil gambar
          setState(() => _capturedImage = image);
          ScaffoldMessenger.of(context).showSnackBar( //Menampilkan hasil foto
            SnackBar(content: Text('Captured: ${image.path}')),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}