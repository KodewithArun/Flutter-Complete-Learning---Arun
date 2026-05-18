import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
            SizedBox(width: 20,),
            Container(
              height: 100,
              width: 100,
              color: Colors.green,
            ),
            SizedBox(width: 20,),
            Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
          ],
        )
      ),
    );
  }
}