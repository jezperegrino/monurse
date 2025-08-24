import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // Import your HomeScreen


class RoleSelectionScreen extends StatefulWidget {
  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // Set to false after the first launch
      await prefs.setBool('isFirstLaunch', false);
    } else {
      // Skip to HomeScreen if not first launch
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen(loginContext: context)),
      );
    }
  }

  void _navigateToHome(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role); // Save the selected role
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen(loginContext: context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd9e8eb), // Solid background color with HEX #d9e8eb
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              'Determine Your Role',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8fb9ad),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // Care Provider Button
            ElevatedButton(
              onPressed: () => _navigateToHome('Care Provider'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Large button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_hospital, // Stethoscope-like icon (use local_hospital as a proxy)
                    size: 60,
                    color: Color(0xFF8fb9ad),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Care Provider',
                    style: TextStyle(fontSize: 20, color: Color(0xFF8fb9ad)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 45),
            // Care Seeker Button
            ElevatedButton(
              onPressed: () => _navigateToHome('Care Seeker'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 100), // Large button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.baby_changing_station, // Home health icon
                    size: 60,
                    color: Color(0xFF8fb9ad),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Care Seeker',
                    style: TextStyle(fontSize: 20, color: Color(0xFF8fb9ad)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}