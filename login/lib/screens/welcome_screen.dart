import 'package:flutter/material.dart';
import '/memes/memes.dart';
import '/screens/screens.dart';
import '/Colors/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonsterScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.firePrimaryColor,
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 3.0,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('MONSTERS'),
            ),
          ],
        ),
      ),
    );
  }
}
