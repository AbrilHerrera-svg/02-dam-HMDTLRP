import 'package:flutter/material.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  static const List<String> _integrantes = [
    "Herrera Dominguez Abril Andrea",
    "Mendoza Ramos Luis Angel",
    "De la Cruz Bravo Santos Aldimer",
    "Puc Flores Jesus Alejandro",
    "Lopez Bautista Ricardo",
    "Rivera Martinez Ariadna Sayuri",
    "Tun Mena Yair Alejandro",
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
        backgroundColor: const Color(0xFF8B4A2B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Platillos Ancestrales de Quintana Roo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Esta app nace del deseo de preservar y compartir el sabor de nuestras raíces: "
              "las recetas de los pueblos originarios de Quintana Roo, transmitidas de generación "
              "en generación. Cada platillo cuenta una historia de identidad y comunidad.",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            const Text(
              "Equipo de desarrollo",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _integrantes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person, color: Color(0xFF8B4A2B)),
                    title: Text(_integrantes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}