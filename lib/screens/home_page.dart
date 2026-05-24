import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Alignment alignment = Alignment.topLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedAlign(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic,
        alignment: alignment,
        child: Container(width: 80, height: 80, color: Colors.green),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            alignment =
                alignment == Alignment.topLeft
                    ? Alignment.bottomRight
                    : Alignment.topLeft;
          });
        },
        child: Icon(Icons.open_with),
      ),
    );
  }
}
