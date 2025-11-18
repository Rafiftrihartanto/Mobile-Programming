import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:material_design/material_design.dart';
import 'camera_page.dart'; // pastikan import file camera_page.dart jika dipisah

/* late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(home: CameraPreview(controller));
  }
}*/

// Implementasika Material Design dari https://pub.dev.

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  //runApp(const CameraApp());
  final cameras = await availableCameras();
  runApp(MyMaterialApp(cameras: cameras));
}

/* void main() {
  runApp(const MyMaterialApp());
} */

class MyMaterialApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyMaterialApp({super.key, required this.cameras});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Design App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightBlueAccent,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageStatefulState();
}

class _HomePageStatefulState extends State<HomePage> {
  int _selectedIndex = 0;

  // Fungsi ganti halaman botton navigation
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /* void _onTakePhotoPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Take Photo Pressed')),
    );
  } */

  void _onTakePhotoPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage(camera: _cameras[0])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Material Design App'),
        actions: const [
          CircleAvatar(backgroundImage: AssetImage('assets/gambar.jpg')),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Take Photo Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gallery ", style: textTheme.titleLarge),
                FilledButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildProfileCard('assets/gambar1.jpg'),
                buildProfileCard('assets/gambar2.jpg'),
                buildProfileCard('assets/gambar3.jpg'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onNavItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.favorite), label: ''),
          NavigationDestination(icon: Icon(Icons.explore), label: ''),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onTakePhotoPressed,
        icon: const Icon(Icons.camera_alt),
        label: const Text("Take a Photo"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  } 

  Widget buildImageCard(String title, String count, String imagePath) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$count items',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileCard(String imagePath, [String? name]) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
