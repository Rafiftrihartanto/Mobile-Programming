// lib/home_page.dart

import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import tampilan profil yang sudah dibuat

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // HomePage hanya berfungsi sebagai wrapper/penampung.
    // Tampilan utamanya adalah ProfilePage.
    return const ProfilePage();
  }
}