import 'package:flutter/material.dart';

void main() {
  runApp(const sib3a());
}

class sib3a extends StatelessWidget {
  const sib3a({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Gridview());
  }
}

class Gridview extends StatelessWidget {
  const Gridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView Example')),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return Card(
            color: Colors.blue[100],
            margin: EdgeInsets.all(8),
            child: Center(
              child: Text('Item ${index + 1}', style: TextStyle(fontSize: 20)),
            ),
          );
        }),
      ),
    );
  }
}