// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'registrar_screen.dart';
import '/Colors/app_colors.dart';
import '/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MONSTER HUNTER'),
        backgroundColor: AppColors.accentColor,
        actions: [
          // Botón para cambiar el tema
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              _mostrarDialogoCambioTema(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'WELCOME HUNTER',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.fireSecondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/imgs/login.jpg',
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonGreenColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrarScreen()),
                );
              },
              child: const Text('REGISTER A NEW HUNTER'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.firePrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar un diálogo para cambiar el tema
  void _mostrarDialogoCambioTema(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cambiar tema'),
          content: Column(
            children: [
              ListTile(
                title: const Text('Original'),
                onTap: () {
                  _cambiarTema(context, Tema.original);
                },
              ),
              ListTile(
                title: const Text('Hielo'),
                onTap: () {
                  _cambiarTema(context, Tema.hielo);
                },
              ),
              ListTile(
                title: const Text('Fuego'),
                onTap: () {
                  _cambiarTema(context, Tema.fuego);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para cambiar el tema usando TemaManager
  void _cambiarTema(BuildContext context, Tema nuevoTema) {
    final temaManager = Provider.of<TemaManager>(context, listen: false);
    temaManager.cambiarTema(nuevoTema);

    // Cerrar el diálogo
    Navigator.pop(context);
  }
}
