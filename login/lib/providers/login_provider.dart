// login_provider.dart

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> getEmail() async {
    // Puedes agregar lógica adicional aquí si es necesario.
    // Por ejemplo, podrías realizar una llamada a la base de datos o autenticación.

    // Simplemente retornamos el email, pero podrías personalizarlo según tus necesidades.
    return email.isNotEmpty ? email : null;
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}
