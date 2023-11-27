import 'package:flutter/material.dart';
import '../Colors/app_colors.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.accentColor, // Cambiado a accentColor de AppColors
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.accentColor, // Cambiado a accentColor de AppColors
          width: 2,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color:
                  AppColors.accentColor, // Cambiado a accentColor de AppColors
            )
          : null,
    );
  }
}
