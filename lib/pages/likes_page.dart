import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';


class LikesPage extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  final BuildContext context;

  const LikesPage({required this.appKitModal, required this.context, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Likes'),
      ),
      body: Center(
        child: Text('View your liked caregivers here!'),
      ),
    );
  }
}