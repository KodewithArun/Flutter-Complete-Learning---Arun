import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String _result = '';

  @override
  void initState() {
    super.initState();
    // You can perform any initialization tasks here if needed
  }

  void _addNumbers() {
    var number1 = double.tryParse(_number1Controller.text);
    var number2 = double.tryParse(_number2Controller.text);
    if (number1 == null || number2 == null) return;
    setState(() {
      _result = 'Result: ${number1 + number2}';
    });
  }

  void _subtractNumbers() {
    var number1 = double.tryParse(_number1Controller.text);
    var number2 = double.tryParse(_number2Controller.text);
    if (number1 == null || number2 == null) return;
    setState(() {
      _result = 'Result: ${number1 - number2}';
    });
  }

  void _multiplyNumbers() {
    var number1 = double.tryParse(_number1Controller.text);
    var number2 = double.tryParse(_number2Controller.text);
    if (number1 == null || number2 == null) return;
    setState(() {
      _result = 'Result: ${number1 * number2}';
    });
  }

  void _divideNumbers() {
    var number1 = double.tryParse(_number1Controller.text);
    var number2 = double.tryParse(_number2Controller.text);
    if (number1 == null || number2 == null || number2 == 0) return;
    setState(() {
      _result = 'Result: ${number1 / number2}';
    });
  }

  @override
  void dispose() {
    // You can perform any cleanup tasks here if needed
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _number1Controller,
            decoration: InputDecoration(
              labelText: 'Number 1',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _number2Controller,
            decoration: InputDecoration(
              labelText: 'Number 2',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Text(_result),
          SizedBox(height: 16),
          ElevatedButton(onPressed: _addNumbers, child: Text('Add')),
          ElevatedButton(onPressed: _subtractNumbers, child: Text("Subtract")),
          ElevatedButton(onPressed: _multiplyNumbers, child: Text("Multiply")),
          ElevatedButton(onPressed: _divideNumbers, child: Text("Divide")),
        ],
      ),
    );
  }
}
