import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'role_selection_screen.dart'; // Import the role selection screen
import '../main.dart';
import '../models/appkit_global.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ReownAppKitModal _appKitModal;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
    // Initialize _appKitModal with context)

    ReownAppKitModalNetworks.removeSupportedNetworks('solana');


    ReownAppKitModalNetworks.addSupportedNetworks('monad', [
      ReownAppKitModalNetworkInfo(
        name: 'Monad Testnet',
        chainId: '10143',
        chainIcon: 'https://files.svgcdn.io/token-branded/monad.png',
        currency: 'MON',
        rpcUrl: 'https://testnet-rpc.monad.xyz',
        explorerUrl: 'https://testnet.monadexplorer.com',
        isTestNetwork: true,
      ),
    ]);

    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: '3d4c8463082f14d414346a0cd923e6f9',
      metadata: const PairingMetadata(
        name: 'monurse',
        description: 'A network for caregivers and seekers',
        url: 'https://example.com/',
        icons: ['https://example.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://', // Match your URL scheme
          universal: 'https://reown.com/exampleapp',
        ),
      ),
      optionalNamespaces: {
        'eip155': RequiredNamespace.fromJson({
          'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: 'eip155',
          ).map((chain) => '${chain.chainId}').toList(),
          'methods':
              NetworkUtils.defaultNetworkMethods['eip155']!.toList(),
          'events':
              NetworkUtils.defaultNetworkEvents['eip155']!.toList(),
        }),
        'monad': RequiredNamespace.fromJson({
          'chains': ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: 'monad',
          ).map((chain) => '${chain.chainId}').toList(),
          'methods': [
            // NetworkUtils.defaultNetworkMethods['monad']!.toList(),
          ],
          'events': [
            // NetworkUtils.defaultNetworkEvents['monad']!.toList()
          ]
        }),
      },
    );
    _appKitModal.init().then((value) {
      setState(() {}); // Refresh UI after initialization
      AppKitGlobal.setAppKitModal(_appKitModal); // Set the global instance
      // Add listener for connection changes
      _appKitModal.addListener(_updateConnectionState);
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

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (!isFirstLaunch) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _onConnectTap() {
    if (_appKitModal.isConnected) {
      _appKitModal.disconnect();
    } else {
      _appKitModal.openModalView(); // Manually open the connection modal
    }
  }

  void _onContinue() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd9e8eb),
      body: Builder(
        builder: (innerContext) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppKitModalNetworkSelectButton(appKit: _appKitModal),
                ElevatedButton(
                  onPressed: _onConnectTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8fb9ad),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _appKitModal.isConnected ? 'Disconnect' : 'Connect to Wallet',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                if (_appKitModal.isConnected)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8fb9ad),
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////


//   @override
//   void initState() {
//     super.initState();
//     _checkFirstLaunch();
//   }

//   Future<void> _checkFirstLaunch() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

//     if (!isFirstLaunch) {
//       // Skip to HomeScreen if not first launch
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     }
//   }

//   void _onContinue() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFd9e8eb), // Background color #d9e8eb
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _onContinue,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFF8fb9ad), // Button color #8fb9ad
//             minimumSize: Size(200, 50), // Adjust size as needed
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: Text(
//             'Continue',
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }


////////////////////////////////////////////////////////////////////////


// import 'package:flutter/material.dart';
// import 'package:reown_appkit/reown_appkit.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'role_selection_screen.dart'; // Import the role selection screen
// import '../main.dart';
// import '../models/appkit_global.dart';


// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late ReownAppKitModal _appKitModal;

//   @override
//   void initState() {
//     super.initState();
//     _checkFirstLaunch();
//     // Initialize _appKitModal with context
//     _appKitModal = ReownAppKitModal(
//       context: context,
//       projectId: '3d4c8463082f14d414346a0cd923e6f9', // Replace with your Reown project ID
//       metadata: const PairingMetadata(
//         name: 'monurse',
//         description: 'A network for caregivers and seekers',
//         url: 'https://example.com/',
//         icons: ['https://example.com/logo.png'],
//         redirect: Redirect(
//           native: 'exampleapp://', // Match your URL scheme
//           universal: 'https://reown.com/exampleapp',
//         ),
//       ),
//     );
//     _appKitModal.init().then((value) {
//       setState(() {}); // Refresh UI after initialization
//       AppKitGlobal.setAppKitModal(_appKitModal); // Set the global instance
//     });
//   }

//   Future<void> _checkFirstLaunch() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

//     if (!isFirstLaunch) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     }
//   }

//   void _onWalletConnected() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFd9e8eb),
//       body: Builder(
//         builder: (innerContext) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AppKitModalConnectButton(
//                   appKit: _appKitModal,
//                   context: innerContext,
//                 ),
//                 if (_appKitModal.isConnected)
//                   ElevatedButton(
//                     onPressed: _onWalletConnected,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF8fb9ad),
//                       minimumSize: Size(200, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }