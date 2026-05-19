import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page', style: GoogleFonts.lato())),
      body: Card(
        elevation: 4,
        margin: EdgeInsets.all(16), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    'Welcome to the Home Page!',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.orangeAccent,
                child: Center(
                  child: Text(
                    'Enjoy exploring the app.',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.greenAccent,
                child: Center(
                  child: Text(
                    'Have a great day!',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.purpleAccent,
                child: Center(
                  child: Text(
                    'Enjoy your day!',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.redAccent,
                child: Center(
                  child: Text(
                    'Flutter is awesome!',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.tealAccent,
                child: Center(
                  child: Text(
                    'Keep coding!',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
