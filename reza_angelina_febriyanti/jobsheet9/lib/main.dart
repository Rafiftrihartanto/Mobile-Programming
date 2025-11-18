import 'package:flutter/material.dart';

// =======================================================
// DATA THEME
// =======================================================

class AppTheme {
  bool isDarkMode = false;

  ThemeData get themeData {
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

// =======================================================
// INHERITED WIDGET UNTUK THEME
// =======================================================

class ThemeInheritedWidget extends InheritedWidget {
  final AppTheme appTheme;
  final VoidCallback toggleTheme;

  const ThemeInheritedWidget({
    super.key,
    required this.appTheme,
    required this.toggleTheme,
    required Widget child,
  }) : super(child: child);

  static ThemeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return appTheme.isDarkMode != oldWidget.appTheme.isDarkMode;
  }
}

// =======================================================
// APLIKASI UTAMA
// =======================================================

class ThemeApp extends StatefulWidget {
  const ThemeApp({super.key});

  @override
  _ThemeAppState createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  final AppTheme appTheme = AppTheme();

  void toggleTheme() {
    setState(() {
      appTheme.isDarkMode = !appTheme.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      appTheme: appTheme,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        //title: 'Theme App',
        theme: appTheme.themeData,
        home: const FirstScreen(),
        routes: {'/second': (context) => SecondScreen()},
      ),
    );
  }
}

void main() {
  runApp(const ThemeApp());
}

// =======================================================
// SCREEN PERTAMA
// =======================================================

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 1'),
        actions: [
          IconButton(
            icon: Icon(
              themeInherited?.appTheme.isDarkMode == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeInherited?.toggleTheme,
          ),
        ],
      ),
      body: Container(
        color: themeInherited?.appTheme.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Screen Pertama',
                style: TextStyle(
                  fontSize: 24,
                  color: themeInherited?.appTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                themeInherited?.appTheme.isDarkMode == true
                    ? 'Mode Gelap'
                    : 'Mode Terang',
                style: TextStyle(color: themeInherited?.appTheme.textColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: const Text('Pergi ke Screen 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// SCREEN KEDUA
// =======================================================

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeInherited = ThemeInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
        actions: [
          IconButton(
            icon: Icon(
              themeInherited?.appTheme.isDarkMode == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: themeInherited?.toggleTheme,
          ),
        ],
      ),
      body: Container(
        color: themeInherited?.appTheme.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Screen Kedua',
                style: TextStyle(
                  fontSize: 24,
                  color: themeInherited?.appTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Theme sama di semua screen!',
                style: TextStyle(color: themeInherited?.appTheme.textColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}