import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home screen after 2.5 seconds
    Timer(Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8fb9ad), // Solid background color with HEX #8fb9ad
      body: Center(
        child: Icon(
          Icons.medical_services, // Medical services icon
          size: 100, // Adjust size as needed
          color: Colors.white, // Icon color (adjust as desired)
        ),
      ),
    );
  }
}