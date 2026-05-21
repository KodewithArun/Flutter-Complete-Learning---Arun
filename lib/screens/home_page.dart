import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Widget')),
      body: const Icon(
        Icons.headphones,
        size: 100,
        color: Color.fromARGB(255, 154, 172, 22),
      ),
    );
  }
}
