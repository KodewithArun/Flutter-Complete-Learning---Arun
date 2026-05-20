import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Widget')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Text(
          'Flutter is Google’s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
