import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/appkit_global.dart';


class ProfilePage extends StatefulWidget {
  final ReownAppKitModal appKitModal;
  final BuildContext context;
  const ProfilePage({required this.appKitModal, required this.context, super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userRole = 'Not Selected';

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole') ?? 'Not Selected';
    });
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
                    'User Name',
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
          ],
        ),
      ),
    );
  }
}
