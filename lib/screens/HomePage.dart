import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Expanded(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 200,
              color: Colors.red,
            ),
            Container(
              height: 200,
              color: Colors.green,
            ),
            Container(
              height: 200,
              color: Colors.blue,
            ),
            Container(
              height: 200,
              color: Colors.yellow,
            ),
            Container(
              height: 200,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}