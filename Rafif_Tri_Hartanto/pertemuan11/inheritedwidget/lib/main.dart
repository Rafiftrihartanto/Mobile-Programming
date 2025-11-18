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
        debugShowCheckedModeBanner: false,
        title: 'Theme App',
        theme: appTheme.themeData,
        home: const LoginScreen(),
        routes: {'/register': (context) => const RegisterScreen()},
      ),
    );
  }
}

void main() {
  runApp(const ThemeApp());
}

// =======================================================
// LOGIN SCREEN (SCREEN 1)
// =======================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: [
          IconButton(
            icon: Icon(
              theme?.appTheme.isDarkMode == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: theme?.toggleTheme,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        color: theme?.appTheme.backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme?.appTheme.textColor,
                    ),
                  ),

                  const SizedBox(height: 40),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Email wajib diisi";
                      }
                      if (!emailRegExp.hasMatch(v)) {
                        return "Format email tidak valid";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Password wajib diisi";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login Berhasil")),
                          );
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text("Register"),
                    ),
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

// =======================================================
// REGISTER SCREEN (SCREEN 2)
// =======================================================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedRole = "User";

  final emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

  @override
  Widget build(BuildContext context) {
    final theme = ThemeInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        actions: [
          IconButton(
            icon: Icon(
              theme?.appTheme.isDarkMode == true
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: theme?.toggleTheme,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        color: theme?.appTheme.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Form Registrasi",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: theme?.appTheme.textColor,
                ),
              ),

              const SizedBox(height: 30),

              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // ROLE DROPDOWN
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "User", child: Text("User")),
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // BUTTON REGIST
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registrasi Berhasil")),
                    );
                  },
                  child: const Text("Regist"),
                ),
              ),

              const SizedBox(height: 10),

              // BUTTON LOGIN KEMBALI KE SCREEN LOGIN
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}