import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/appkit_global.dart';
import 'pages/chat_page.dart';
import 'pages/home_page.dart';
import 'pages/likes_page.dart';
import 'pages/profile_page.dart';
import 'pages/splash_screen.dart';


void main() {
  AppKitGlobal.initializeNetworks();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monurse Network',
      theme: ThemeData(), // Colors can be customized later
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class HomeScreen extends StatefulWidget {
  final BuildContext loginContext; // Context passed from LoginScreen

  const HomeScreen({required this.loginContext});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ReownAppKitModal _appKitModal;
  String? userRole;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
    // Initialize _appKitModal with context from LoginScreen
    _appKitModal = ReownAppKitModal(
      context: widget.loginContext,
      projectId: '3d4c8463082f14d414346a0cd923e6f9',
      metadata: const PairingMetadata(
        name: 'monurse',
        description: 'A network for caregivers and seekers',
        url: 'https://example.com/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://',
          universal: 'https://reown.com/exampleapp',
        ),
      ),
      optionalNamespaces: {
        'eip155': RequiredNamespace.fromJson({
          'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: 'eip155',
          ).map((chain) => '${chain.chainId}').toList(),
          'methods': NetworkUtils.defaultNetworkMethods['eip155']!.toList(),
          'events': NetworkUtils.defaultNetworkEvents['eip155']!.toList(),
        }),
        // 'monad': RequiredNamespace.fromJson({
        //   'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
        //     namespace: 'monad',
        //   ).map((chain) => '${chain.chainId}').toList(),
        //   'methods': [],
        //   'events': [],
        // }),
      },
    );
    _appKitModal.init().then((value) {
      setState(() {}); // Refresh UI after initialization
      AppKitGlobal.setAppKitModal(_appKitModal); // Set global instance
      _appKitModal.addListener(_updateConnectionState); // Add listener
    });
  }

  void _updateConnectionState() {
    if (mounted) {
      setState(() {}); // Update UI when connection state changes
    }
  }

  @override
  void dispose() {
    _appKitModal.removeListener(_updateConnectionState);
    super.dispose();
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole') ?? 'Not Selected';
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(appKitModal: _appKitModal, context: widget.loginContext),
      LikesPage(appKitModal: _appKitModal, context: widget.loginContext),
      // ChatPage(appKitModal: _appKitModal, context: widget.loginContext),
      ProfilePage(appKitModal: _appKitModal, context: widget.loginContext),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Solicitudes'),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Cuidador'),
          // BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}