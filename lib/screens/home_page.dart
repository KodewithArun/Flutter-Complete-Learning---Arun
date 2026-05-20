import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      //  make a date picker simple body
      body: Builder(
        builder: (context) {
          return Center(
            child: ElevatedButton(
              onPressed: () async {
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (dateTime != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected date: $dateTime')),
                  );
                }
              },
              child: Text('Show Date Picker'),
            ),
          );
        },
      ),
    );
  }
}
