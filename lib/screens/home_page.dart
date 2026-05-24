import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String>> _students = [
    {
      "name": "John Doe",
      "rollNo": "101",
      "className": "10-A",
      "age": "15",
      "grade": "A",
    },
    {
      "name": "Jane Smith",
      "rollNo": "102",
      "className": "10-A",
      "age": "15",
      "grade": "A+",
    },
    {
      "name": "Alice Johnson",
      "rollNo": "103",
      "className": "10-B",
      "age": "16",
      "grade": "B+",
    },
    {
      "name": "Bob Brown",
      "rollNo": "104",
      "className": "10-B",
      "age": "16",
      "grade": "B",
    },
    {
      "name": "Charlie Davis",
      "rollNo": "105",
      "className": "10-C",
      "age": "15",
      "grade": "A",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return ListTile(
            leading: CircleAvatar(child: Text(student["rollNo"] ?? "")),
            title: Text(student["name"] ?? ""),
            subtitle: Text(
              "Class: ${student["className"]} • Age: ${student["age"]} • Grade: ${student["grade"]}",
            ),
          );
        },
      ),
    );
  }
}
