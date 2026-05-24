import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var arrIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: ListWheelScrollView(
        itemExtent: 250,
        children:
            arrIndex
                .map(
                  (e) => Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.primaries[e % Colors.primaries.length],
                    child: Center(
                      child: Text(
                        "Item $e",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
