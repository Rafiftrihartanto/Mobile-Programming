import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const CameraApp());
}

class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
        brightness: Brightness.light,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ModernCameraPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Kamera Flutter",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class ModernCameraPage extends StatefulWidget {
  const ModernCameraPage({super.key});

  @override
  State<ModernCameraPage> createState() => _ModernCameraPageState();
}

class _ModernCameraPageState extends State<ModernCameraPage>
    with SingleTickerProviderStateMixin {
  late CameraController controller;
  int selectedCameraIdx = 0;
  String? imagePath;
  bool isSwitching = false;

  @override
  void initState() {
    super.initState();
    _initCamera(selectedCameraIdx);
  }

  Future<void> _initCamera(int index) async {
    controller = CameraController(_cameras[index], ResolutionPreset.high);
    await controller.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;
    setState(() => isSwitching = true);

    selectedCameraIdx = selectedCameraIdx == 0 ? 1 : 0;
    await controller.dispose();
    await _initCamera(selectedCameraIdx);

    // animasi fade
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => isSwitching = false);
  }

  Future<void> _takePicture(BuildContext context) async {
    if (!controller.value.isInitialized) return;

    final image = await controller.takePicture();

    final directory = await getApplicationDocumentsDirectory();
    final name = '${DateTime.now()}.jpg';
    final localPath = join(directory.path, name);

    await File(image.path).copy(localPath);
    setState(() => imagePath = localPath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📸 Foto disimpan di: $localPath'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            opacity: isSwitching ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: CameraPreview(controller),
          ),

          // Tombol di atas preview
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black45,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    icon: const Icon(Icons.switch_camera),
                    label: const Text("Switch"),
                    onPressed: _switchCamera,
                  ),
                  if (imagePath != null)
                    IconButton(
                      icon: const Icon(Icons.photo, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PreviewPage(imagePath!),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          // Tombol capture di bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: FloatingActionButton.large(
                backgroundColor: Colors.white,
                onPressed: () => _takePicture(context),
                child: const Icon(Icons.camera_alt, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Foto')),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
