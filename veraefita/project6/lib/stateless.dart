import 'package:flutter/material.dart';

void main() {
  runApp(const MyStatelessApp());
}

 class MyStatelessApp extends StatelessWidget {
  const MyStatelessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Contoh Stateless Widget'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text(
            'Halo, saya Stateless Widget!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}