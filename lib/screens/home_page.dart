import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.purple,
              Colors.red,
            ],
            stops: [0.0, 0.14, 0.28, 0.42, 0.56, 0.70, 0.84, 1.0],
          ),
        ),
      ),
    );
  }
}
