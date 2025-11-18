import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Pengguna',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CobaProfile(),
    );
  }
}

class CobaProfile extends StatefulWidget {
  const CobaProfile({Key? key}) : super(key: key);

  @override
  State<CobaProfile> createState() => _CobaProfileState();
}

class _CobaProfileState extends State<CobaProfile> {
  bool mute = false;
  bool disappearing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 46,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Nama Pengguna',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Status singkat pengguna — "Available"',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Tentang'),
            subtitle: Text('Hidup sederhana'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Nomor telepon'),
            subtitle: const Text('+62 85791357577'),
            trailing: IconButton(icon: const Icon(Icons.message), onPressed: () {}),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Media, tautan, dan dokumen'),
            subtitle: const Text('120 item'),
            onTap: () {},
          ),
          const Divider(),
          SwitchListTile(
            value: mute,
            onChanged: (v) => setState(() => mute = v),
            title: const Text('Bisukan notifikasi'),
            secondary: const Icon(Icons.volume_off),
          ),
          SwitchListTile(
            value: disappearing,
            onChanged: (v) => setState(() => disappearing = v),
            title: const Text('Pesan sementara'),
            secondary: const Icon(Icons.timer),
          ),
          const SizedBox(height: 12),
          const ListTile(
            leading: Icon(Icons.lock),
            title: Text('End-to-end encryption'),
            subtitle: Text('Pesan dan panggilan terlindungi. Ketuk untuk memverifikasi.'),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.share),
            label: const Text('Bagikan kontak'),
          ),
        ],
      ),
    );
  }
}