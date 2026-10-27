import 'package:flutter/material.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
        backgroundColor: const Color(0xFF8B4A2B),
        foregroundColor:  Colors.white,
      ),
      body: const Center(child: Text("Acerca de"),),
    );
  }
}