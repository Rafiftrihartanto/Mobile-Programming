import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyTheme extends InheritedWidget {
  final Color primaryColor;
  final bool isDarkMode;

  const MyTheme({
    super.key,
    required this.primaryColor,
    required this.isDarkMode,
    required super.child,
  });

  static MyTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyTheme>()!;
  }

  @override
  bool updateShouldNotify(covariant MyTheme oldWidget) {
    return oldWidget.isDarkMode != isDarkMode ||
        oldWidget.primaryColor != primaryColor;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTheme(
      primaryColor: Colors.blue,
      isDarkMode: false,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}