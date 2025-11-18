import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const CameraApp());
}

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  int _selectedCameraIndex = 0;
  bool _isRecording = false;
  XFile? _capturedMedia;

  @override
  void initState() {
    super.initState();
    _initializeCamera(_cameras[_selectedCameraIndex]);
  }

  Future<void> _initializeCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _controller.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kamera depan/belakang tidak tersedia")),
      );
      return;
    }

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _controller.dispose();
    await _initializeCamera(_cameras[_selectedCameraIndex]);
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) return;
    if (_controller.value.isTakingPicture) return;

    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String filePath =
          join(appDir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

      final XFile picture = await _controller.takePicture();
      await picture.saveTo(filePath);

      if (!mounted) return;

      setState(() {
        _capturedMedia = XFile(filePath);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto disimpan di: $filePath')),
      );
    } catch (e) {
      debugPrint('Error saat mengambil foto: $e');
    }
  }

  Future<void> _recordVideo() async {
    if (!_controller.value.isInitialized) return;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String filePath =
        join(appDir.path, '${DateTime.now().millisecondsSinceEpoch}.mp4');

    try {
      if (_isRecording) {
        final XFile videoFile = await _controller.stopVideoRecording();
        await videoFile.saveTo(filePath);

        setState(() {
          _isRecording = false;
          _capturedMedia = XFile(filePath);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video disimpan di: $filePath')),
        );
      } else {
        await _controller.startVideoRecording();

        setState(() {
          _isRecording = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Merekam video...')),
        );
      }
    } catch (e) {
      debugPrint('Error saat merekam video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black, // Latar belakang agar tidak terlihat ruang kosong
        appBar: AppBar(
          title: const Text('Aplikasi Kamera Material Design'),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // ✅ Kamera tampil proporsional, tidak zoom, tidak distorsi
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: ClipRect(
                  child: CameraPreview(_controller),
                ),
              ),
            ),

            // ✅ Thumbnail foto/video hasil tangkapan
            if (_capturedMedia != null)
              Positioned(
                bottom: 140,
                left: 20,
                right: 20,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _capturedMedia!.path.endsWith(".mp4")
                      ? const Center(
                          child: Icon(Icons.videocam,
                              color: Colors.white, size: 50),
                        )
                      : Image.file(File(_capturedMedia!.path),
                          fit: BoxFit.cover),
                ),
              ),

            // ✅ Tombol kontrol kamera
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: 'switch',
                    backgroundColor: Colors.tealAccent,
                    onPressed: _switchCamera,
                    child: const Icon(Icons.cameraswitch),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: 'capture',
                    backgroundColor: Colors.tealAccent,
                    onPressed: _takePicture,
                    child: const Icon(Icons.camera_alt),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    heroTag: 'video',
                    backgroundColor:
                        _isRecording ? Colors.red : Colors.tealAccent,
                    onPressed: _recordVideo,
                    child: Icon(_isRecording ? Icons.stop : Icons.videocam),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}