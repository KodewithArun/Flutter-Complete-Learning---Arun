import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: Text("Date & Time")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              "Current Date",

              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "${now.day}/${now.month}/${now.year}",

              style: TextStyle(fontSize: 22),
            ),

            SizedBox(height: 30),

            Text(
              "Current Time",

              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "${now.hour}:${now.minute}:${now.second}",

              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
