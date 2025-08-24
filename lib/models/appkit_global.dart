import 'package:reown_appkit/reown_appkit.dart';

class AppKitGlobal {
  static ReownAppKitModal? appKitModal; // Nullable to handle uninitialized state

  static void setAppKitModal(ReownAppKitModal modal) {
    appKitModal = modal;
  }

  // Initialize supported networks globally
  static void initializeNetworks() {
    // Remove Solana network if previously added
    // ReownAppKitModalNetworks.removeSupportedNetworks('solana');

    // Add Monad Testnet as the only supported network
    ReownAppKitModalNetworks.addSupportedNetworks('monad', [
      ReownAppKitModalNetworkInfo(
        name: 'Monad Testnet',
        chainId: '10143',
        chainIcon: 'https://files.svgcdn.io/token-branded/monad.png',
        currency: 'MON',
        rpcUrl: 'testnet-rpc.monad.xyz',
        explorerUrl: 'https://testnet.monadexplorer.com',
        isTestNetwork: true,
      ),
    ]);
  }
}

///////////////////////////////////////////////////////

// import 'package:reown_appkit/reown_appkit.dart';

// class AppKitGlobal {
//   static ReownAppKitModal? appKitModal;

//   static void setAppKitModal(ReownAppKitModal modal) {
//     appKitModal = modal;
//   }
// }