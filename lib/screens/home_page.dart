import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 125, 36, 30),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 32, 182, 54),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 30, 115, 138),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 22, 40, 106),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 121, 67, 81),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 236, 123, 2),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 125, 36, 30),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 32, 182, 54),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 30, 115, 138),
          ),
          Container(
            height: 200,
            width: 200,
            color: const Color.fromARGB(255, 22, 40, 106),
          ),
        ],
      ),
    );
  }
}
