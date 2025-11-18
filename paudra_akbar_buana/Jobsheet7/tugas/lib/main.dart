import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Request permissions
  await [Permission.camera, Permission.storage].request();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamera App - Material Design',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.teal,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 6,
        ),
      ),
      home: CameraScreen(cameras: cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  int selectedCameraIdx = 0; // 0: back, 1: front
  String? imagePath;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    controller = CameraController(
      widget.cameras[selectedCameraIdx],
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller!.initialize();
    if (mounted) {
      setState(() => isInitialized = true);
    }
  }

  Future<void> _switchCamera() async {
    selectedCameraIdx = selectedCameraIdx == 0 ? 1 : 0;
    await controller?.dispose();
    await _initializeCamera();
  }

  Future<void> _takePicture() async {
    if (!controller!.value.isInitialized) return;

    final XFile file = await controller!.takePicture();
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String newPath = path.join(
      appDir.path,
      'KameraApp_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await File(file.path).copy(newPath);

    setState(() => imagePath = newPath);

    // Tampilkan path di Snackbar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Foto disimpan: ${path.basename(newPath)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          action: SnackBarAction(
            label: 'Lihat',
            textColor: Colors.white,
            onPressed: () {

            },
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Preview Kamera Full Screen
            Positioned.fill(
              child: CameraPreview(controller!),
            ),
            // Overlay untuk UI
            Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  // AppBar Custom
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: const Text(
                            'Kamera App',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _switchCamera,
                          icon: Icon(
                            selectedCameraIdx == 0 ? Icons.camera_rear : Icons.camera_front,
                            color: Colors.white,
                          ),
                          tooltip: 'Switch Kamera',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Tombol Capture di Bawah
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton.large(
                  onPressed: _takePicture,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.camera_alt, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}