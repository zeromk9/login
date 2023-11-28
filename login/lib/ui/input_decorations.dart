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
          color: AppColors.mhwblack, //color lineas
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primaryColor, //color focus linea
          width: 2,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: AppColors.iceAccentColor, //color de labels email y password
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: AppColors.buttonGreenColor, //color iconos
            )
          : null,
    );
  }
}
