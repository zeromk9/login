import 'package:flutter/material.dart';
import '../memes/memes.dart'; // Asegúrate de importar tus mensajes

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          InGameMessages.igmessages[0], // Muestra el primer mensaje por defecto
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/welcome.jpg',
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              "WELCOME TO THE HUNT, WHERE LEGENDS ARE FORGED!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
