import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

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
      home: const WelcomeScreen(),
    );
  }
}
