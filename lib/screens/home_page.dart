import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double boxSize = 800;
  Color boxColor = Colors.blue;
  double boxOpacity = 1.0;

  void animateBox() {
    setState(() {
      boxSize = boxSize == 800 ? 200 : 800;
      boxColor = boxColor == Colors.blue ? Colors.red : Colors.blue;
      boxOpacity = boxOpacity == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedContainer')),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          opacity: boxOpacity,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: boxSize,
            height: boxSize,
            color: boxColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: animateBox,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
