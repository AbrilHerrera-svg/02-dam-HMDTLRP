# Guía de desarrollo — App Gastronómica QROO (app_gastro)

Proyecto: `C:\App_moviles\App_Gastro`
Paquete Dart: `app_gastro`
API: https://dummyjson.com/recipes
Estilo y convenciones de nombres (igual que en Tienda Delfinesv2):

```dart
// snake case. producto_nuevos_
// Pascal case. Main ProductosNuevos
// camel case. nombreCompletoEstudiante atributos
// kebab case. proyecto-integrador
// UPPERCASE IVA PI ISR Constantes
```

- Archivos: snake_case (`receta_card.dart`)
- Clases/Widgets: PascalCase (`RecetaCard`)
- Variables/métodos: camelCase, en español (`obtenerRecetas`, `_mostrarMensajeMapa`)
- Modelos inmutables (`final`, `const` constructor) con `factory fromJson`
- Servicios: una clase por recurso, URL base `static const`, `throw Exception` en error
- Paleta de color consistente en toda la app: `Color(0xFF8B4A2B)` (marrón/tierra, tema gastronómico)

---

## Desarrollador 1 — Estructura base y splash

```powershell
cd C:\App_moviles\App_Gastro
flutter create --project-name app_gastro .
flutter pub add http
New-Item -ItemType Directory -Force lib/models, lib/screens, lib/widgets, lib/services
```

**`lib/screens/splash_screen.dart`**
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_gastro/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B4A2B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.restaurant, color: Colors.white, size: 60),
            SizedBox(height: 16),
            Text(
              "Platillos Ancestrales\nde Quintana Roo",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
```

**`lib/screens/home_screen.dart`** (placeholder, se completa en Dev4/Dev6)
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Home")),
    );
  }
}
```

**`lib/main.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:app_gastro/screens/splash_screen.dart';

void main() {
  runApp(const AppGastroApp());
}

class AppGastroApp extends StatelessWidget {
  const AppGastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Platillos Ancestrales de Quintana Roo",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
```

```powershell
git init
git add .
git commit -m "feat: estructura de carpetas y splash screen de 4 segundos"
```
*(Llamar al docente aquí antes de seguir)*

---

## Desarrollador 2 — Modelos y servicios

**`lib/models/receta.dart`**
```dart
class Receta {
  final int id;
  final String nombre;
  final String imagenUrl;
  final String cocina;
  final String dificultad;
  final int caloriasPorPorcion;
  final int tiempoPreparacionMinutos;
  final int porciones;
  final List<String> ingredientes;
  final List<String> instrucciones;

  const Receta({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
    required this.cocina,
    required this.dificultad,
    required this.caloriasPorPorcion,
    required this.tiempoPreparacionMinutos,
    required this.porciones,
    required this.ingredientes,
    required this.instrucciones,
  });

  factory Receta.fromJson(Map<String, dynamic> json) {
    return Receta(
      id: json['id'],
      nombre: json['name'],
      imagenUrl: json['image'],
      cocina: json['cuisine'],
      dificultad: json['difficulty'],
      caloriasPorPorcion: json['caloriesPerServing'],
      tiempoPreparacionMinutos: json['prepTimeMinutes'],
      porciones: json['servings'],
      ingredientes: List<String>.from(json['ingredients']),
      instrucciones: List<String>.from(json['instructions']),
    );
  }
}
```

**`lib/services/receta_service.dart`**
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_gastro/models/receta.dart';

class RecetaService {
  static const String _baseUrl = "https://dummyjson.com/recipes";

  Future<List<Receta>> obtenerRecetas() async {
    final Uri url = Uri.parse(_baseUrl);
    final http.Response respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      final Map<String, dynamic> datos = jsonDecode(respuesta.body);
      final List<dynamic> listaRecetas = datos['recipes'];

      return listaRecetas
          .map((recetaJson) => Receta.fromJson(recetaJson))
          .toList();
    } else {
      throw Exception("Error al obtener la lista de recetas: ${respuesta.statusCode}");
    }
  }
}
```

```powershell
git add .
git commit -m "feat: modelo de receta y servicio http para dummyjson"
```

---

## Desarrollador 3 — Scaffold y Bottom Navigation

**`lib/screens/favoritos_screen.dart`** (placeholder)
```dart
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
      body: const Center(child: Text("Favoritos")),
    );
  }
}
```

**`lib/screens/acerca_screen.dart`** (placeholder)
```dart
import 'package:flutter/material.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
        backgroundColor: const Color(0xFF8B4A2B),
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text("Acerca de")),
    );
  }
}
```

**`lib/screens/main_screen.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:app_gastro/screens/home_screen.dart';
import 'package:app_gastro/screens/favoritos_screen.dart';
import 'package:app_gastro/screens/acerca_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indiceActual = 0;

  final List<Widget> _pantallas = const [
    HomeScreen(),
    FavoritosScreen(),
    AcercaScreen(),
  ];

  void _cambiarPantalla(int index) {
    setState(() {
      _indiceActual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indiceActual,
        children: _pantallas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _cambiarPantalla,
        currentIndex: _indiceActual,
        selectedItemColor: const Color(0xFF8B4A2B),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Acerca de"),
        ],
      ),
    );
  }
}
```

Edita **`lib/screens/splash_screen.dart`**: cambia el import y el destino del timer de `HomeScreen` a `MainScreen`:
```dart
import 'package:app_gastro/screens/main_screen.dart';
// ...
MaterialPageRoute(builder: (context) => const MainScreen()),
```

```powershell
git add .
git commit -m "feat: implementa scaffold base y bottom navigation bar"
```

---

## Desarrollador 4 — Encabezado y botón flotante

Reemplaza **`lib/screens/home_screen.dart`** completo:
```dart
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
```

```powershell
git add .
git commit -m "feat: agrega titulo introductorio y fab con snackbar del mapa"
```

---

## Desarrollador 5 — Widget personalizado de receta

**`lib/widgets/receta_card.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:app_gastro/models/receta.dart';
import 'package:app_gastro/screens/detalle_receta_screen.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;

  const RecetaCard({super.key, required this.receta});

  static const Color _marronTexto = Color(0xFF6B3A1F);
  static const Color _fondoCard = Color(0xFFFBF1E6);
  static const Color _bordeCard = Color(0xFFE6CBA8);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetalleRecetaScreen(receta: receta)),
        );
      },
      child: Card(
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
      ),
    );
  }
}
```

> Nota: este widget ya referencia `DetalleRecetaScreen`, que se crea como extra después del Desarrollador 6 (ver sección "Detalle de receta" al final). Si aún no la has creado, quita el `InkWell`/`onTap` y deja el `Card` como `return Card(...)` directo, y agrégalo cuando llegues a esa parte.

```powershell
git add .
git commit -m "feat: diseno de widget de receta imagen izquierda texto derecha"
```

---

## Desarrollador 6 — Integración de API en la vista

Reemplaza de nuevo **`lib/screens/home_screen.dart`** completo:
```dart
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
```

```powershell
git add .
git commit -m "feat: integra servicio rest con listview usando futurebuilder"
```

---

## Desarrollador 7 — Vistas secundarias

Reemplaza **`lib/screens/favoritos_screen.dart`**:
```dart
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
```

Reemplaza **`lib/screens/acerca_screen.dart`** (cambia los 8 nombres por los reales cuando los tengas):
```dart
import 'package:flutter/material.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  static const List<String> _integrantes = [
    "Integrante 1",
    "Integrante 2",
    "Integrante 3",
    "Integrante 4",
    "Integrante 5",
    "Integrante 6",
    "Integrante 7",
    "Integrante 8",
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
```

```powershell
git add .
git commit -m "feat: pantallas de favoritos y acerca de con nombres del equipo"
```

---

## Desarrollador 8 — Auditoría UX y Nielsen

Revisa que los colores (`Color(0xFF8B4A2B)`), paddings (`16`/`10`/`12`) y estilos de texto sean consistentes en todas las pantallas (ya lo son en el código de arriba).

Crea **`USABILIDAD_NIELSEN.md`** en la raíz del repo:

```markdown
# Evaluación heurística — Jakob Nielsen

App: Platillos Ancestrales de Quintana Roo

1. **Visibilidad del estado del sistema**: `CircularProgressIndicator` mientras carga la lista de recetas (home_screen.dart) y mientras cargan las imágenes (receta_card.dart).
2. **Coincidencia entre el sistema y el mundo real**: textos en español, íconos reconocibles (mapa, favorito, persona) e imágenes reales de los platillos.
3. **Control y libertad del usuario**: navegación inferior persistente que permite volver a Home en cualquier momento.
4. **Consistencia y estándares**: mismo color primario (#8B4A2B), mismos paddings y mismo estilo de tarjeta en toda la app.
5. **Prevención de errores**: `errorBuilder` en las imágenes de red y manejo de excepción HTTP en `RecetaService`.
6. **Reconocer en lugar de recordar**: barra inferior siempre visible con ícono + etiqueta de texto.
7. **Flexibilidad y eficiencia de uso**: FAB de acceso directo al mapa desde Home sin navegar a otra pantalla.
8. **Estética y diseño minimalista**: tarjetas limpias con solo la información esencial (nombre, cocina, dificultad, calorías).
9. **Ayudar a reconocer, diagnosticar y recuperarse de errores**: mensaje de error legible en pantalla (`snapshot.hasError`) en vez de un crash.
10. **Ayuda y documentación**: texto introductorio en Home que explica el propósito de la app antes de mostrar el contenido.
```

```powershell
git add .
git commit -m "docs: pulido visual y documento de evaluacion heuristica de nielsen"
```

---

## Extra — Detalle de receta (opcional, no pedido en la hoja pero recomendado)

**`lib/screens/detalle_receta_screen.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:app_gastro/models/receta.dart';

class DetalleRecetaScreen extends StatelessWidget {
  final Receta receta;

  const DetalleRecetaScreen({super.key, required this.receta});

  static const Color _marronTexto = Color(0xFF6B3A1F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receta.nombre),
        backgroundColor: const Color(0xFF8B4A2B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              receta.imagenUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: const Color(0xFFF1E2CE),
                  child: const Icon(Icons.image_not_supported, color: _marronTexto),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            receta.nombre,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _marronTexto),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              _InfoChip(icono: Icons.public, texto: receta.cocina),
              _InfoChip(icono: Icons.bar_chart, texto: receta.dificultad),
              _InfoChip(icono: Icons.timer, texto: "${receta.tiempoPreparacionMinutos} min"),
              _InfoChip(icono: Icons.people, texto: "${receta.porciones} porciones"),
              _InfoChip(icono: Icons.local_fire_department, texto: "${receta.caloriasPorPorcion} kcal"),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Ingredientes",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: _marronTexto),
          ),
          const SizedBox(height: 8),
          ...receta.ingredientes.map(
            (ingrediente) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 6, color: _marronTexto),
                  const SizedBox(width: 8),
                  Expanded(child: Text(ingrediente)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Preparación",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: _marronTexto),
          ),
          const SizedBox(height: 8),
          ...receta.instrucciones.asMap().entries.map(
            (entrada) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFF8B4A2B),
                    child: Text(
                      "${entrada.key + 1}",
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(entrada.value)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icono;
  final String texto;

  const _InfoChip({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icono, size: 16, color: Colors.white),
      label: Text(texto, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: const Color(0xFF8B4A2B),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
```

```powershell
git add .
git commit -m "feat: agrega pantalla de detalle de receta al tocar la tarjeta"
```

---

## Conectar y subir a GitHub

```powershell
git remote add origin https://github.com/AbrilHerrera-svg/02-dam-HMDTLRP.git
git branch -M main
git push -u origin main
```

Si da error de "remote origin already exists":
```powershell
git remote set-url origin https://github.com/AbrilHerrera-svg/02-dam-HMDTLRP.git
```

Si el push se rechaza por historiales distintos:
```powershell
git pull origin main --allow-unrelated-histories
git push -u origin main
```
