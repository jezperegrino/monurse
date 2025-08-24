import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/appkit_global.dart';
import 'profile_form_screen.dart';


class ProfilePage extends StatefulWidget {
  final ReownAppKitModal appKitModal;
  final BuildContext context;
  const ProfilePage({required this.appKitModal, required this.context, super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userRole = 'Not Selected';
  String userName = 'User Name'; // State for dynamic username
  List<String> profileData = []; // To store additional data below bio

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _loadProfileData(); // Load saved data
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole') ?? 'Not Selected';
      userName = prefs.getString('userName') ?? 'User Name'; // Load username
    });
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      profileData = prefs.getStringList('profileData') ?? [];
    });
  }

  Future<void> _saveProfileData(Map<String, dynamic> formData) async {
    final prefs = await SharedPreferences.getInstance();
    if (formData.containsKey('name')) {
      setState(() {
        userName = formData['name'];
      });
      await prefs.setString('userName', formData['name']);
    }
    final updatedData = [...profileData, _formatProfileData(formData)];
    setState(() {
      profileData = updatedData;
    });
    await prefs.setStringList('profileData', updatedData);
  }

  String _formatProfileData(Map<String, dynamic> data) {
    final entries = data.entries.where((e) => e.key != 'name'); // Exclude name (handled separately)
    return entries.map((e) => '${e.key}: ${e.value}').join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // General padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start (left)
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.grey[700],
                  ),
                  SizedBox(height: 20),
                  Text(
                    userName, // Updated to dynamic username
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Conditionally display ranking if role is Care Provider
                  if (userRole == 'Care Provider')
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4.5 ? Icons.star : Icons.star_border, // 4.5 stars example
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20), // Space between sections

            Builder(
              builder: (innerContext) {
                if (AppKitGlobal.appKitModal == null) {
                  // Optional: Trigger a refresh or wait for initialization
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && AppKitGlobal.appKitModal == null) {
                      setState(() {}); // Retry build after a frame
                    }
                  });
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Network selector not available yet. Please log in first.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return Column(children: [
                  AppKitModalNetworkSelectButton(
                    appKit: AppKitGlobal.appKitModal!,
                    context: innerContext,
                  ),
                  AppKitModalAddressButton(appKitModal: AppKitGlobal.appKitModal!),
                  AppKitModalBalanceButton(appKitModal: AppKitGlobal.appKitModal!),
                ]);
              },
            ),

            SizedBox(height: 20),
            Text(
              'Role: $userRole',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              'Bio or description goes here.',
              style: TextStyle(fontSize: 16),
            ),
            // Display saved profile data
            if (profileData.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: profileData.map((data) => Text(data, style: TextStyle(fontSize: 16))).toList(),
                ),
              ),
            // New button at the bottom
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFormScreen(
                            userRole: userRole!,
                            onSave: _saveProfileData,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8fb9ad),
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Editar Perfil',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}