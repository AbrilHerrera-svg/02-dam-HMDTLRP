import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _mostrarMensajeMapa() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("El mapa de los pueblos originarios se está abriendo....")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platillos Ancestrales de Quintana Roo"),
        backgroundColor: const Color(0xFF8B4A2B),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarMensajeMapa,
        backgroundColor: const Color(0xFF8B4A2B),
        child: const Icon(Icons.map, color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Platillos Ancestrales de Quintana Roo",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Descubre las recetas tradicionales de los pueblos originarios de Quintana Roo, "
              "preservadas de generación en generación.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}