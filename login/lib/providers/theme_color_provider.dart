import 'package:flutter/material.dart';
import '/Colors/app_colors.dart';

class TemaManager extends ChangeNotifier {
  late ThemeData _tema;
  late String _imagenTema;

  TemaManager() {
    _tema = _obtenerTemaOriginal();
    _imagenTema = 'assets/imgs/normal.jpg';
  }

  ThemeData get tema => _tema;
  String get imagenTema => _imagenTema;

  ThemeData _obtenerTemaOriginal() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.primaryColor,
      textTheme: _obtenerTextoTemaOriginal(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonGreenColor,
        ),
      ),
    );
  }

  ThemeData _obtenerTemaHielo() {
    _imagenTema = 'assets/imgs/ice.jpg';
    return ThemeData(
      scaffoldBackgroundColor: AppColors.icePrimaryColor,
      textTheme: _obtenerTextoTemaHielo(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.iceButtonGreenColor,
        ),
      ),
    );
  }

  ThemeData _obtenerTemaFuego() {
    _imagenTema = 'assets/imgs/fire.jpg';
    return ThemeData(
      scaffoldBackgroundColor: AppColors.firePrimaryColor,
      textTheme: _obtenerTextoTemaFuego(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.fireButtonGreenColor,
        ),
      ),
    );
  }

  TextTheme _obtenerTextoTemaOriginal() {
    return const TextTheme(
      displayLarge: AppColors.titulo,
      displayMedium: AppColors.subtitulo,
      labelLarge: AppColors.botonTexto,
      bodyMedium: AppColors.hintTexto,
    );
  }

  TextTheme _obtenerTextoTemaHielo() {
    return TextTheme(
      displayLarge: AppColors.titulo.copyWith(color: Colors.white),
      displayMedium: AppColors.subtitulo.copyWith(color: Colors.white),
      labelLarge: AppColors.botonTexto.copyWith(color: Colors.white),
      bodyMedium: AppColors.hintTexto,
    );
  }

  TextTheme _obtenerTextoTemaFuego() {
    return TextTheme(
      displayLarge:
          AppColors.titulo.copyWith(fontSize: 26, color: Colors.orange),
      displayMedium:
          AppColors.subtitulo.copyWith(fontSize: 20, color: Colors.orange),
      labelLarge: AppColors.botonTexto.copyWith(color: Colors.white),
      bodyMedium: AppColors.hintTexto,
    );
  }

  void cambiarTema(Tema nuevoTema) {
    switch (nuevoTema) {
      case Tema.original:
        _tema = _obtenerTemaOriginal();
        break;
      case Tema.hielo:
        _tema = _obtenerTemaHielo();
        break;
      case Tema.fuego:
        _tema = _obtenerTemaFuego();
        break;
    }
    notifyListeners();
  }
}

enum Tema { original, hielo, fuego }
