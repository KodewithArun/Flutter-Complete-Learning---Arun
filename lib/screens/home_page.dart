import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,

          ),
          Container(width: 200, height: 200, color: Colors.orange),
          Container(width: 100, height: 100, color: Colors.white),
          Container(width: 50, height: 50, color: Colors.red),
        ],
      ),
    );
  }
}
