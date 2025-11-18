import 'package:flutter/material.dart';

void main() {
  runApp(const uts_vera());
}

class uts_vera extends StatelessWidget {
  const uts_vera({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('web vera efita'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text(
            'Halo, saya vera efita!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
        ),
      ),
    );
  }
}