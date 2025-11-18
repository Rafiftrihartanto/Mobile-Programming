// lib/profile_page.dart

import 'package:flutter/material.dart';
import 'routes.dart'; // ✅ Import file routes

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final List<String> mataKuliah = const [
    "1. Pemrograman Mobile",
    "2. Sistem Operasi",
    "3. Jaringan Komputer",
    "4. Praktikum Basis Data",
    "5. Kewirausahaan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Profil Mahasiswa"),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 21, 101, 239),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 45, 251).withOpacity(0.6), 
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/poltek.jpeg', 
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Vera Efita Hudi Putri',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const Text(
                      'NIM: 2341760047',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const Text(
                      'Jurusan Teknologi Informasi',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, color: Colors.white70),
                        SizedBox(width: 8),
                        Text('veraefita05@email.com', style: TextStyle(color: Colors.white70)),
                        SizedBox(width: 20),
                        Icon(Icons.phone, color: Colors.white70),
                        SizedBox(width: 8),
                        Text('0896-2606-5619', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              // Daftar Mata Kuliah
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), 
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mata Kuliah Semester 5:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 26, 45, 251)),
                    ),
                    const Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mataKuliah.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.book, color: Color.fromARGB(255, 21, 101, 239)),
                          title: Text(mataKuliah[index]),
                          dense: true,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Navigasi ke Galeri
              ElevatedButton.icon(
                onPressed: () {
                  // ✅ Navigator.pushNamed akan berfungsi jika 'routes.dart' di-import
                  Navigator.pushNamed(context, AppRoutes.gallery); 
                },
                icon: const Icon(Icons.photo_library),
                label: const Text("Lihat Galeri (GridView)"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 10, 18, 130),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}