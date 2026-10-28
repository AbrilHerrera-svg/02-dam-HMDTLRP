import 'package:flutter/material.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        backgroundColor: const Color(0xFF8B4A2B),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text("Aquí se verán tus favoritos"),
      ),
    );
  }
}