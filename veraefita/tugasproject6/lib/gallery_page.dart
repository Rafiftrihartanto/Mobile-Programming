// lib/gallery_page.dart

import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  final List<String> galleryImages = const [
    'assets/images/poltek.jpeg', // Contoh: ganti dengan pic1.jpg
    'assets/images/poltek.jpeg', // Contoh: ganti dengan pic2.jpg
    'assets/images/poltek.jpeg',
    'assets/images/poltek.jpeg',
    'assets/images/poltek.jpeg',
    'assets/images/poltek.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galeri Mahasiswa"),
        backgroundColor: const Color.fromARGB(255, 21, 101, 239),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // GridView.builder untuk menampilkan elemen dalam bentuk grid
        child: GridView.builder(
          itemCount: galleryImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text('Item ${index + 1}', textAlign: TextAlign.center),
                ),
                child: Image.asset(
                  galleryImages[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error_outline, color: Colors.red));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}