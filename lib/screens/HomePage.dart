import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
//         child: Image.network(
//   "https://picsum.photos/300",
// )
// child: Image.asset("assets/images/superman.png",height:200,width: 300,),
child: CircleAvatar(
  radius: 100,
  backgroundImage: AssetImage("assets/images/superman.png")
),
      ),
    );
  }
}