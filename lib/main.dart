import 'package:flutter/material.dart';
import 'package:app_gastro/screens/splash_screen.dart';

void main() {
  runApp(const QrooRecetasApp());
}

class QrooRecetasApp extends StatelessWidget {
  const QrooRecetasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Platillos Ancestrales de Quintana Roo",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}//hola
