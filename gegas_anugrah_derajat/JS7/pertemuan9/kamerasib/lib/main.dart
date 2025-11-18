import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

// late List<CameraDescription> _cameras;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   _cameras = await availableCameras();
//   runApp(const CameraApp());
// }

// /// CameraApp is the Main Application.
// class CameraApp extends StatefulWidget {
//   /// Default Constructor
//   const CameraApp({super.key});

//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   late CameraController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(_cameras[0], ResolutionPreset.max);
//     controller
//         .initialize()
//         .then((_) {
//           if (!mounted) {
//             return;
//           }
//           setState(() {});
//         })
//         .catchError((Object e) {
//           if (e is CameraException) {
//             switch (e.code) {
//               case 'CameraAccessDenied':
//                 // Handle access errors here.
//                 break;
//               default:
//                 // Handle other errors here.
//                 break;
//             }
//           }
//         });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }
//     return MaterialApp(home: CameraPreview(controller));
//   }
// }

// main.dart
// Flutter app: Camera preview, take picture, switch cameras, show saved path, save to local directory
// Packages used (add to pubspec.yaml):
//   camera: ^0.10.0
//   path_provider: ^2.0.0
//   permission_handler: ^10.0.0


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp(this.cameras, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraScreen(cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen(this.cameras, {super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late int selectedCameraIndex;

  @override
  void initState() {
    super.initState();
    selectedCameraIndex = 0;
    _initCamera();
  }

  void _initCamera() {
    _controller = CameraController(
      widget.cameras[selectedCameraIndex],
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  void _switchCamera() {
    setState(() {
      selectedCameraIndex =
          selectedCameraIndex == 0 ? 1 : 0;
      _initCamera();
    });
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) return;

    final picture = await _controller.takePicture();
    final directory = await getApplicationDocumentsDirectory();
    final newPath = '${directory.path}/${DateTime.now()}.jpg';
    File(picture.path).copy(newPath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Foto disimpan di: $newPath")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Preview Kamera")),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_controller)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _switchCamera,
                icon: const Icon(Icons.cameraswitch),
                label: const Text("Ganti Kamera"),
              ),
              ElevatedButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Ambil Foto"),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}