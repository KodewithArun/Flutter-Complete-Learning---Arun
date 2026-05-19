import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(height: 100, width: 100, color: Colors.red),
          ),
          Expanded(
            child: Container(height: 100, width: 100, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
