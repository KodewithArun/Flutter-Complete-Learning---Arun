import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: controller),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hello ${controller.text}')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
