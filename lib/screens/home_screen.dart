import 'package:flutter/material.dart';
import 'package:app_gastro/models/receta.dart';
import 'package:app_gastro/services/receta_service.dart';
import 'package:app_gastro/widgets/receta_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecetaService _recetaService = RecetaService();
  late Future<List<Receta>> _futureRecetas;

  @override
  void initState() {
    super.initState();
    _futureRecetas = _recetaService.obtenerRecetas();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Platillos Ancestrales de Quintana Roo",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Descubre las recetas tradicionales de los pueblos originarios de Quintana Roo, "
              "preservadas de generación en generación.",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Receta>>(
                future: _futureRecetas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error al conectarse a la api ${snapshot.error}"));
                  }
                  final recetas = snapshot.data!;
                  return ListView.builder(
                    itemCount: recetas.length,
                    itemBuilder: (context, index) {
                      return RecetaCard(receta: recetas[index]);
                    },
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