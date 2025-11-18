// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

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

// Tugas
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> _cameras = <CameraDescription>[];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    _cameras = await availableCameras();
  } catch (e) {
    debugPrint("⚠️ Tidak dapat mengakses kamera: $e");
  }

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ModernCameraApp(),
  ));
}

class ModernCameraApp extends StatefulWidget {
  const ModernCameraApp({super.key});

  @override
  State<ModernCameraApp> createState() => _ModernCameraAppState();
}

class _ModernCameraAppState extends State<ModernCameraApp> {
  CameraController? controller;
  bool isRecording = false;
  int selectedCameraIdx = 0;

  List<XFile> mediaFiles = [];
  VideoPlayerController? videoController;
  Map<String, Uint8List> imageCache = {};

  @override
  void initState() {
    super.initState();
    _initCamera(selectedCameraIdx);
  }

  Future<void> _initCamera(int cameraIndex) async {
    if (_cameras.isEmpty) return;

    final cameraController = CameraController(
      _cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: true,
    );

    controller = cameraController;

    try {
      await controller!.initialize();
      setState(() {});
    } catch (e) {
      debugPrint("❌ Gagal inisialisasi kamera: $e");
    }
  }

  Future<void> _takePicture() async {
    if (controller == null || !controller!.value.isInitialized) return;
    try {
      final XFile file = await controller!.takePicture();
      if (kIsWeb) {
        imageCache[file.path] = await file.readAsBytes();
      }
      setState(() => mediaFiles.add(file));
    } catch (e) {
      debugPrint("📸 Error ambil foto: $e");
    }
  }

  Future<void> _startVideoRecording() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (controller!.value.isRecordingVideo) return;
    try {
      await controller!.startVideoRecording();
      setState(() => isRecording = true);
    } catch (e) {
      debugPrint("🎥 Error mulai rekam: $e");
    }
  }

  Future<void> _stopVideoRecording() async {
    if (controller == null || !controller!.value.isRecordingVideo) return;
    try {
      final XFile file = await controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
        mediaFiles.add(file);
      });
    } catch (e) {
      debugPrint("🛑 Error stop rekam: $e");
    }
  }

  void _switchCamera() async {
    if (_cameras.length < 2) return;
    selectedCameraIdx = (selectedCameraIdx + 1) % _cameras.length;
    await _initCamera(selectedCameraIdx);
  }

  void _openGalleryDialog() {
    if (mediaFiles.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.9),
        insetPadding: const EdgeInsets.all(10),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: mediaFiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final file = mediaFiles[index];
            final isVideo = file.path.toLowerCase().endsWith(".mp4");
            final imageProvider = isVideo
                ? const AssetImage('assets/video_placeholder.png')
                : (kIsWeb && imageCache.containsKey(file.path)
                    ? MemoryImage(imageCache[file.path]!)
                    : FileImage(File(file.path))) as ImageProvider;

            return GestureDetector(
              onTap: () => _openPreview(file),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isVideo)
                    const Center(
                      child: Icon(Icons.play_circle_fill,
                          color: Colors.white, size: 30),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openPreview(XFile file) async {
    final isVideo = file.path.toLowerCase().endsWith(".mp4");

    Widget content;

    if (isVideo) {
      videoController?.dispose();

      if (kIsWeb) {
        videoController =
            VideoPlayerController.networkUrl(Uri.parse(file.path));
      } else {
        videoController = VideoPlayerController.file(File(file.path));
      }

      await videoController!.initialize();
      await videoController!.setLooping(true);
      await videoController!.play();

      content = AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: VideoPlayer(videoController!),
      );
    } else {
      final imageWidget = kIsWeb && imageCache.containsKey(file.path)
          ? Image.memory(imageCache[file.path]!, fit: BoxFit.contain)
          : Image.file(File(file.path), fit: BoxFit.contain);
      content = imageWidget;
    }

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Center(child: content),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final lastFile = mediaFiles.isNotEmpty ? mediaFiles.last : null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(controller!)),

          // 🔄 Tombol ganti kamera di pojok kanan atas
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 32),
              onPressed: _switchCamera,
            ),
          ),

          // 🎬 Tombol ambil foto & video di bawah tengah
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: Colors.black, size: 30),
                  ),
                ),
                const SizedBox(width: 40),
                GestureDetector(
                  onTap:
                      isRecording ? _stopVideoRecording : _startVideoRecording,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRecording ? Colors.grey : Colors.red,
                    ),
                    child: Icon(
                      isRecording ? Icons.stop : Icons.videocam,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🖼️ Thumbnail terakhir di pojok kanan bawah (✅ FIXED)
          if (lastFile != null)
            Positioned(
              bottom: 40,
              right: 20,
              child: GestureDetector(
                onTap: _openGalleryDialog,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                      image: lastFile.path.toLowerCase().endsWith(".mp4")
                          ? const AssetImage("assets/video_placeholder.png")
                          : (kIsWeb &&
                                  imageCache.containsKey(lastFile.path))
                              ? MemoryImage(imageCache[lastFile.path]!)
                              : FileImage(File(lastFile.path)) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: lastFile.path.toLowerCase().endsWith(".mp4")
                      ? const Center(
                          child: Icon(Icons.play_circle_fill,
                              color: Colors.white, size: 26),
                        )
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
