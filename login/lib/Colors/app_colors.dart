import 'package:flutter/material.dart';

class AppColors {
  // Colores para el tema original
  static const Color primaryColor = Color(0xFFAD5D5D); // Rojo oscuro
  static const Color accentColor = Color(0xFFD8AE47); // Amarillo oscuro
  static const Color secondaryColor = Color(0xFF92B6D5); // Azul claro/oscuro
  static const Color buttonGreenColor = Color(0xFF006E51); // Verde oscuro
  static const Color buttonBrownColor =
      Color(0xFFAF947E); // Marrón claro/oscuro

  // Colores para el tema de hielo
  static const Color icePrimaryColor = Color(0xFF64B5F6); // Azul claro
  static const Color iceAccentColor = Color(0xFF1976D2); // Azul más oscuro
  static const Color iceSecondaryColor = Color(0xFF455A64); // Gris azulado
  static const Color iceButtonGreenColor = Color(0xFF00E676); // Verde claro

  // Colores para el tema de fuego
  static const Color firePrimaryColor = Color(0xFFFF7043); // Naranja claro
  static const Color fireAccentColor = Color(0xFFFF3D00); // Naranja más oscuro
  static const Color fireSecondaryColor = Color(0xFFBDBDBD); // Gris claro
  static const Color fireButtonGreenColor = Color(0xFF388E3C); // Verde oscuro

  //Colores normales:
  static const Color mhwhite = Colors.white;
  static const Color mhwblack = Colors.black;

  // Estilos de texto para cada tema
  static const TextStyle titulo = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitulo = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const TextStyle botonTexto = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle hintTexto = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );
}
