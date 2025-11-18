// main.dart
import 'package:flutter/material.dart';

// --- 1. Main Entry Point & State Holder ---

void main() {
  runApp(const AppProvider());
}

/// AppProvider adalah StatefulWidget yang "memiliki" state tema (isDarkMode)
class AppProvider extends StatefulWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  bool _isDarkMode = false;

  void _setTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData currentTheme = _isDarkMode
        ? ThemeData.dark().copyWith(
            primaryColor: Colors.tealAccent,
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1F1F),
              foregroundColor: Colors.white,
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[100],
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          );
    
    final Color currentFg = _isDarkMode ? Colors.white : Colors.black;

    // MyTheme membungkus MaterialApp agar tersedia di SEMUA layar/rute
    return MyTheme(
      isDarkMode: _isDarkMode,
      themeData: currentTheme,
      foregroundColor: currentFg,
      setTheme: _setTheme,
      child: MaterialApp(
        theme: currentTheme, // Atur tema global MaterialApp
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// --- 2. InheritedWidget Kustom (MyTheme) ---

/// MyTheme adalah InheritedWidget yang "membawa" data tema.
class MyTheme extends InheritedWidget {
  
  final bool isDarkMode;
  final ThemeData themeData;
  final Color foregroundColor;
  final Function(bool) setTheme;

  const MyTheme({
    Key? key,
    required this.isDarkMode,
    required this.themeData,
    required this.foregroundColor,
    required this.setTheme,
    required Widget child,
  }) : super(key: key, child: child);

  // Metode 'of' konvensional untuk mengakses data tema
  static MyTheme of(BuildContext context) {
    final MyTheme? result = context.dependOnInheritedWidgetOfExactType<MyTheme>();
    assert(result != null, 'No MyTheme found in context');
    return result!;
  }

  // Bangun ulang widget dependen jika 'isDarkMode' berubah
  @override
  bool updateShouldNotify(MyTheme oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}

// --- 3. Halaman Utama (Konsumen Tema) ---

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        // --- TOMBOL LEADING DITAMBAHKAN ---
        // Ini adalah tombol leading kustom di halaman utama
        leading: IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Buka Pengaturan',
          onPressed: () {
            // Navigasi ke layar kedua (dual screen)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        // Judul AppBar juga bereaksi terhadap perubahan tema
        title: Text('Tema: ${theme.isDarkMode ? "Gelap" : "Terang"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Tema:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.foregroundColor, // Teks ini bereaksi pada tema
              ),
            ),
            const SizedBox(height: 16),
            
            // Grid 2 Kotak (Row + Expanded)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ThemeBox(
                      title: 'Mode Terang',
                      isDarkBox: false,
                      bgColor: Colors.white,
                      fgColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ThemeBox(
                      title: 'Mode Gelap',
                      isDarkBox: true,
                      bgColor: const Color(0xFF303030),
                      fgColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 4. Widget Kotak Pilihan Tema (Konsumen Tema) ---

class ThemeBox extends StatelessWidget {
  final String title;
  final bool isDarkBox;
  final Color bgColor;
  final Color fgColor;

  const ThemeBox({
    Key? key,
    required this.title,
    required this.isDarkBox,
    required this.bgColor,
    required this.fgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final bool isSelected = theme.isDarkMode == isDarkBox;

    return GestureDetector(
      onTap: () {
        theme.setTheme(isDarkBox);
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.grey[400]!,
            width: isSelected ? 4.0 : 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: fgColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

// --- 5. Layar Kedua (Dual Screen) ---
// Ini adalah layar baru yang kita tambahkan.

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Layar ini juga bisa mengakses tema dari MyTheme!
    final theme = MyTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        // Tombol 'leading' (panah kembali) di sini
        // ditambahkan secara otomatis oleh Navigator.
        title: const Text('Layar Kedua'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ini adalah layar kedua.',
              style: TextStyle(
                fontSize: 20,
                color: theme.foregroundColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Tema (InheritedWidget) juga berfungsi di sini:',
              style: TextStyle(color: theme.foregroundColor),
            ),
            const SizedBox(height: 10),
            // Ikon ini akan berubah berdasarkan tema
            Icon(
              theme.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: theme.foregroundColor,
              size: 50,
            ),
            const SizedBox(height: 30),
            // Kita bahkan bisa menaruh tombol ganti tema di sini
            Switch(
              value: theme.isDarkMode,
              onChanged: (isDark) {
                theme.setTheme(isDark);
              },
            ),
            Text(
              'Ganti Tema dari Layar 2',
              style: TextStyle(color: theme.foregroundColor),
            ),
          ],
        ),
      ),
    );
  }
}