import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: StudentList(),
    );
  }
}

class StudentList extends StatelessWidget {
  final List<String> students = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Faythe',
    'Grace',
    'Heidi',
    'Ivan',
    'Judy',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(students[index][0])),
          title: Text(students[index]),
        );
      },
    );
  }
}