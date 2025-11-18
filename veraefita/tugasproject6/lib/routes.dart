// lib/routes.dart

import 'package:flutter/material.dart';
import 'gallery_page.dart';
import 'profile_page.dart';

// Definisikan Named Routes Map
final Map<String, WidgetBuilder> routes = {
  '/': (context) => const ProfilePage(), // Home (Profil)
  '/galeri': (context) => const GalleryPage(), // Galeri
};

// Nama-nama Rute untuk dipanggil
class AppRoutes {
  static const String profile = '/';
  // Pastikan nama ini sesuai dengan key di map routes di atas!
  static const String gallery = '/galeri'; 
}