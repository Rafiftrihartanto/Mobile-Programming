import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Diperlukan untuk PreferenceService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenceService();
  await prefs.init(); // Inisialisasi service pada saat aplikasi dimulai
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfilePage(),
    ); // MaterialApp
  }
}

class PreferenceService {
  // Pola Singleton
  static final PreferenceService _instance = PreferenceService._internal();

  factory PreferenceService() => _instance;

  PreferenceService._internal();

  late SharedPreferences _prefs;

  // Inisialisasi SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- Metode untuk String ---
  Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  // --- Metode untuk Int ---
  Future<bool> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  // --- Metode Kontrol ---
  Future<bool> remove(String key) async => await _prefs.remove(key);

  Future<bool> clear() async => await _prefs.clear();
}

// --- ProfilePage StatefulWidget ---
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

// --- ProfilePage State ---
class _ProfilePageState extends State<ProfilePage> {
  // Inisialisasi Service dan Controllers
  final PreferenceService _prefs = PreferenceService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Variabel untuk menampilkan data yang tersimpan
  String? _savedName;
  String? _savedEmail;
  String? _lastUpdated; // String formatted date/time

  @override
  void initState() {
    super.initState();
    // Panggil fungsi pemuatan data saat state dibuat
    _loadUserData();
  }

  // --- Fungsi untuk Memuat Data ---
  Future<void> _loadUserData() async {
    // init() dipanggil lagi di sini untuk memastikan, 
    // meskipun sudah dipanggil di main(), ini adalah praktik yang aman.
    await _prefs.init(); 

    // Mengambil data dan memperbarui State
    setState(() {
      // Mengisi field input dengan data yang tersimpan (jika ada)
      _nameController.text = _prefs.getString('user_name') ?? '';
      _emailController.text = _prefs.getString('user_email') ?? '';

      // Menyimpan data tersimpan untuk ditampilkan di bawah form
      _savedName = _prefs.getString('user_name');
      _savedEmail = _prefs.getString('user_email');

      // Memuat dan memformat waktu terakhir update
      final int? lastUpdateMillis = _prefs.getInt('last_update');
      if (lastUpdateMillis != null) {
        final DateTime dt = DateTime.fromMillisecondsSinceEpoch(lastUpdateMillis);
        _lastUpdated = DateFormat('dd MMM yyyy, HH:mm').format(dt);
      } else {
        _lastUpdated = '-';
      }
    });
  }

  // --- Fungsi untuk Menyimpan Data ---
  Future<void> _saveUserData() async {
    // Menyimpan data dari controller
    await _prefs.setString('user_name', _nameController.text);
    await _prefs.setString('user_email', _emailController.text);
    // Menyimpan waktu update dalam milidetik sejak Epoch
    await _prefs.setInt('last_update', DateTime.now().millisecondsSinceEpoch);

    // Memuat ulang data untuk memperbarui tampilan
    await _loadUserData();

    // Menampilkan Snackbar notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved successfully!')),
    );
  }

  // --- Build Tampilan (UI) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Input form
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserData,
              child: const Text('Save'),
            ),
            const Divider(height: 40),

            // Data yang disimpan
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Data Tersimpan:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Nama: ${_savedName ?? '-'}'),
                  Text('Email: ${_savedEmail ?? '-'}'),
                  Text('Terakhir diperbarui: ${_lastUpdated ?? '-'}'),
                ],
              ),
            ),
          ],
        ),
      ),
    ); // Scaffold
  }
}