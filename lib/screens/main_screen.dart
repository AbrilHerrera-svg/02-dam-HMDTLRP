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