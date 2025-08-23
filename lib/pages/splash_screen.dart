import 'dart:async';
import 'login_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home screen after 2.5 seconds
    Timer(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8fb9ad), // Solid background color with HEX #8fb9ad
      body: Center( // Wrap the Column with Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services, // Medical services icon
              size: 100, // Adjust size as needed
              color: Colors.white60,
            ),
            SizedBox(height: 25),
            Text(
              'MONURSE',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white60,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}