import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class AppSettings {
  bool isDarkMode = false;
  String userName = "Teman";
  int fontSize = 20;

  Color get backgroundColor {
    return isDarkMode ? Colors.grey[900]! : Colors.white;
  }

  Color get textColor {
    return isDarkMode ? Colors.white : Colors.black;
  }

  String get greeting {
    return "Hello, $userName!";
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppSettings settings = AppSettings();

  void toggleTheme() {
    setState(() {
      settings.isDarkMode = !settings.isDarkMode;
    });
  }

  void updateUserName(String name) {
    setState(() {
      settings.userName = name;
    });
  }

  void increaseFont() {
    setState(() {
      settings.fontSize += 2;
    });
  }

  void decreaseFont() {
    setState(() {
      if (settings.fontSize > 12) {
        settings.fontSize -= 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: settings.isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplikasi Settings Sederhana'),
          backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                settings.greeting,
                style: TextStyle(
                  color: settings.textColor,
                  fontSize: settings.fontSize.toDouble(),
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30),

              
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mode: ${settings.isDarkMode ? "Gelap" : "Terang"}',
                      style: TextStyle(
                        color: settings.textColor,
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: settings.isDarkMode,
                      onChanged: (value) => toggleTheme(),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              TextField(
                onChanged: updateUserName,
                decoration: InputDecoration(
                  labelText: 'Ubah Nama',
                  labelStyle: TextStyle(color: settings.textColor),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: settings.isDarkMode ? Colors.grey[800] : Colors.grey[100],
                ),
                style: TextStyle(color: settings.textColor),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ukuran Font: ${settings.fontSize}',
                      style: TextStyle(
                        color: settings.textColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => decreaseFont(),
                          icon: Icon(Icons.remove_circle, color: settings.textColor),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: () => increaseFont(),
                          icon: Icon(Icons.add_circle, color: settings.textColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: settings.textColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Ini adalah preview teks dengan ukuran font saat ini.',
                  style: TextStyle(
                    color: settings.textColor,
                    fontSize: settings.fontSize.toDouble(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleTheme,
          child: Icon(settings.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          backgroundColor: settings.isDarkMode ? Colors.blueGrey[800] : Colors.blue,
        ),
      ),
    );
  }
}


