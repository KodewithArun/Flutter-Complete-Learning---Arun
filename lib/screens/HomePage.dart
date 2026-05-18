import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Item 1"),
            subtitle: Text("Description for Item 1"),
            leading: Icon(Icons.star),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("Item 2"),
            subtitle: Text("Description for Item 2"),
            leading: Icon(Icons.star_border),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("Item 3"),
            subtitle: Text("Description for Item 3"),
            leading: Icon(Icons.star_half),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      )
    );
  }
}