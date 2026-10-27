class Receta {
  final int id;
  final String nombre;
  final String imagenUrl;
  final String cocina;
  final String dificultad;
  final int caloriasPorPorcion;
  final List<String> ingredientes;

  const Receta({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
    required this.cocina,
    required this.dificultad,
    required this.caloriasPorPorcion,
    required this.ingredientes,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'],
      nombre: json['name'],
      imagenUrl: json['image'],
      cocina: json['cuisine'],
      dificultad: json['difficulty'],
      caloriasPorPorcion: json['caloriesPerServing'],
      ingredientes: List<String>.from(json['ingredients']),
    );
  }
}