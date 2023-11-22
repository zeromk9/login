// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/registrar_screen.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN',
      initialRoute: '/home',
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => LoginScreen(),
        '/registrar': (_) => RegistrarScreen(),
      },
    );
  }
}
