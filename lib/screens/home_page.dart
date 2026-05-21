import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: RichText(
        text: TextSpan(
          text:
              'Flutter is Google’s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text:
                  '\n\nIt allows you to build beautiful apps with a single codebase.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
