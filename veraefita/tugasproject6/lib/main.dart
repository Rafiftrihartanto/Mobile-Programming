// lib/main.dart

import 'package:flutter/material.dart';
import 'routes.dart'; // Import routes yang sudah dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa & Galeri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 78, 20, 225),
          foregroundColor: Colors.white,
        ),
      ),
      
      // Menggunakan Named Routes
      initialRoute: AppRoutes.profile, // Mulai dari halaman Profil
      routes: routes, // Menggunakan Map routes dari lib/routes.dart
      
      debugShowCheckedModeBanner: false,
      
      builder: (context, child) {
        // Wrapper untuk Body agar memiliki background gradasi
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 242, 167, 54), // Biru gelap (Atas)
                Color.fromARGB(255, 255, 248, 255), // Putih/Biru sangat terang (Bawah)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        );
      },
    );
  }
}