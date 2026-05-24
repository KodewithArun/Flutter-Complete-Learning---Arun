import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.orange,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 12, 12),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: HomePage(),
    );
  }
}
