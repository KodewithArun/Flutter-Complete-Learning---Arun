import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ) ,
      body:Center(
        child: Container(
          height: 300,
          width: 400,
          color: Colors.red,
          child: Text("This is Home Page",style: TextStyle(fontSize: 30,color: Colors.blue),),
        ),
      ),
    );
  }
}