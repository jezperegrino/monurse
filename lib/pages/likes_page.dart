import 'package:flutter/material.dart';


class LikesPage extends StatelessWidget {
  const LikesPage({super.key});

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