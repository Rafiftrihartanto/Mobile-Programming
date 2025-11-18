// main.dart
import 'package:flutter/material.dart';

// --- 1. Main Entry Point & State Holder ---

void main() {
  runApp(const AppProvider());
}

/// AppProvider adalah StatefulWidget yang "memiliki" state tema (isDarkMode)
/// dan bertugas membangun MyTheme.
class AppProvider extends StatefulWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  // Ini adalah state utama: apakah mode gelap aktif?
  bool _isDarkMode = false;

  // Fungsi ini akan dipanggil oleh widget anak untuk mengubah state.
  void _setTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan data tema berdasarkan state saat ini
    final ThemeData currentTheme = _isDarkMode
        ? ThemeData.dark().copyWith(
            primaryColor: Colors.tealAccent, // Kustomisasi kecil
            scaffoldBackgroundColor: const Color(0xFF121212),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Kustomisasi kecil
            scaffoldBackgroundColor: Colors.grey[100],
          );
    
    final Color currentFg = _isDarkMode ? Colors.white : Colors.black;

    // Di sinilah kita "menyediakan" (provide) data tema ke seluruh aplikasi.
    // Setiap kali _setTheme dipanggil, widget ini di-rebuild,
    // menciptakan MyTheme baru dengan data baru.
    return MyTheme(
      isDarkMode: _isDarkMode,
      themeData: currentTheme,
      foregroundColor: currentFg,
      setTheme: _setTheme, // Teruskan fungsi untuk mengubah state
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
/// Widget apa pun di bawahnya dapat mengakses data ini.
class MyTheme extends InheritedWidget {
  
  // Data yang ingin kita bagikan
  final bool isDarkMode;
  final ThemeData themeData;
  final Color foregroundColor; // Warna teks default
  final Function(bool) setTheme; // Fungsi untuk mengubah tema

  const MyTheme({
    Key? key,
    required this.isDarkMode,
    required this.themeData,
    required this.foregroundColor,
    required this.setTheme,
    required Widget child,
  }) : super(key: key, child: child);

  // Metode 'of' konvensional untuk mengakses data tema
  // Ini mendaftarkan widget sebagai "dependen"
  static MyTheme of(BuildContext context) {
    final MyTheme? result = context.dependOnInheritedWidgetOfExactType<MyTheme>();
    assert(result != null, 'No MyTheme found in context');
    return result!;
  }

  // Metode ini memberi tahu Flutter apakah perlu membangun ulang
  // widget dependen ketika MyTheme diperbarui.
  @override
  bool updateShouldNotify(MyTheme oldWidget) {
    // Jika isDarkMode berubah, bangun ulang semua yang dependen!
    return isDarkMode != oldWidget.isDarkMode;
  }
}

// --- 3. Halaman Utama (Konsumen Tema) ---

/// HomePage adalah widget "konsumen". Ia membaca data dari MyTheme.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Akses data tema dari InheritedWidget
    final theme = MyTheme.of(context);

    // Karena theme.themeData sudah diatur di MaterialApp,
    // AppBar dan Scaffold (backgroundColor) otomatis beradaptasi.
    return Scaffold(
      appBar: AppBar(
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
            
            // Ini adalah "Grid 2 Kotak" yang Anda minta,
            // diimplementasikan dengan Row dan Expanded.
            Expanded(
              child: Row(
                children: [
                  // Kotak 1: Pilihan Tema Terang
                  Expanded(
                    child: ThemeBox(
                      title: 'Mode Terang',
                      isDarkBox: false, // Ini adalah kotak untuk mode terang
                      bgColor: Colors.white,
                      fgColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Kotak 2: Pilihan Tema Gelap
                  Expanded(
                    child: ThemeBox(
                      title: 'Mode Gelap',
                      isDarkBox: true, // Ini adalah kotak untuk mode gelap
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

/// ThemeBox juga "konsumen" karena perlu tahu tema apa
/// yang sedang aktif untuk menampilkan border "terpilih".
class ThemeBox extends StatelessWidget {
  final String title;
  final bool isDarkBox; // Apakah kotak ini mewakili tema gelap?
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
    // 1. Akses tema saat ini (dari MyTheme)
    final theme = MyTheme.of(context);
    
    // 2. Cek apakah tema kotak ini = tema yang sedang aktif
    final bool isSelected = theme.isDarkMode == isDarkBox;

    return GestureDetector(
      // 3. Saat ditap, panggil fungsi 'setTheme' dari MyTheme
      onTap: () {
        theme.setTheme(isDarkBox);
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // Beri border tebal berwarna biru jika kotak ini terpilih
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