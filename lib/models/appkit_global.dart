import 'package:reown_appkit/reown_appkit.dart';

class AppKitGlobal {
  static ReownAppKitModal? appKitModal;

  static void setAppKitModal(ReownAppKitModal modal) {
    appKitModal = modal;
  }
}