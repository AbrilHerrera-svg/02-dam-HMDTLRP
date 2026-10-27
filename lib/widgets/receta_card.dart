import 'package:flutter/material.dart';
import 'package:app_gastro/models/receta.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;

  const RecetaCard({super.key, required this.receta});

  static const Color _marronTexto = Color(0xFF6B3A1F);
  static const Color _fondoCard = Color(0xFFFBF1E6);
  static const Color _bordeCard = Color(0xFFE6CBA8);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: _fondoCard,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: _bordeCard),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                receta.imagenUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFFF1E2CE),
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFFF1E2CE),
                    child: const Icon(Icons.image_not_supported, color: _marronTexto),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receta.nombre,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _marronTexto),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text("Cocina: ${receta.cocina}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  Text("Dificultad: ${receta.dificultad}", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  Text("${receta.caloriasPorPorcion} kcal por porción", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}