import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// ==========================================================
// THEME INHERITED WIDGET
// ==========================================================
class AppTheme {
  // Jadikan 'final' dan terima nilainya dari constructor
  final bool isDarkMode;

  // Constructor
  AppTheme({this.isDarkMode = false});

  ThemeData get themeData => isDarkMode
      ? ThemeData.dark().copyWith(
          // Anda bisa kustomisasi tema gelap di sini
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey[900], // Background default
          cardColor: Colors.grey[850], // Warna Card di dark mode
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F1F1F),
            foregroundColor: Colors.white,
          ),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.tealAccent),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, // Warna teks tombol
            ),
          ),
        )
      : ThemeData.light().copyWith(
          // Anda bisa kustomisasi tema terang di sini
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white, // Background default
          cardColor: Colors.white, // Warna Card di light mode
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.blue),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // Warna teks tombol
            ),
          ),
        );

  // Getters ini sekarang akan bekerja dengan benar
  Color get primaryColor => isDarkMode ? Colors.tealAccent : Colors.blue;
  Color get backgroundColor => isDarkMode ? Colors.grey[900]! : Colors.white;
  Color get textColor => isDarkMode ? Colors.white : Colors.black;
}

class ThemeInheritedWidget extends InheritedWidget {
  final AppTheme appTheme;
  final VoidCallback toggleTheme;

  const ThemeInheritedWidget({
    required this.appTheme,
    required this.toggleTheme,
    required Widget child,
    super.key,
  }) : super(child: child);

  static ThemeInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return appTheme.isDarkMode != oldWidget.appTheme.isDarkMode;
  }
}

// ==========================================================
// MAIN APP
// ==========================================================
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Pindahkan state 'isDarkMode' langsung ke State
  bool _isDarkMode = false;

  void _toggleTheme() {
    // Perbarui state 'bool'
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    // Buat OBJEK BARU 'AppTheme' setiap kali 'build' dipanggil
    final AppTheme currentTheme = AppTheme(isDarkMode: _isDarkMode);

    return ThemeInheritedWidget(
      // Berikan objek BARU ke InheritedWidget
      appTheme: currentTheme,
      toggleTheme: _toggleTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Gunakan 'themeData' dari objek BARU
        theme: currentTheme.themeData,
        home: const LoginScreen(),
        routes: {'/register': (_) => const RegisterScreen()},
      ),
    );
  }
}

// ==========================================================
// LOGIN SCREEN
// ==========================================================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInheritedWidget.of(context);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: theme.appTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              theme.appTheme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: theme.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 64,
                    color: theme.appTheme.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.appTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Masuk dengan akun Anda",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.appTheme.primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    label: const Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text("Belum punya akun? Daftar di sini"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================================
// REGISTER SCREEN
// ==========================================================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String gender = "M";
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInheritedWidget.of(context);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    return Scaffold(
      backgroundColor: theme.appTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              theme.appTheme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: theme.toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.person_add_alt,
                  size: 64,
                  color: theme.appTheme.primaryColor,
                ),
                const SizedBox(height: 20),
                Text(
                  "Buat Akun Baru",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.appTheme.textColor,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: "Nama Depan",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: "Nama Belakang",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: "M", child: Text("Laki-laki")),
                    DropdownMenuItem(value: "F", child: Text("Perempuan")),
                  ],
                  onChanged: (value) => setState(() => gender = value!),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text("Admin?"),
                  value: isAdmin,
                  onChanged: (v) => setState(() => isAdmin = v),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.appTheme.primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  label: const Text(
                    "DAFTAR",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Sudah punya akun? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}