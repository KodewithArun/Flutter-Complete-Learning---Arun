import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.name}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Email: ${user.email}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Age: ${user.age}", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
