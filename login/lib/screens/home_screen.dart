// home_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registrar_screen.dart';
import '/Colors/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MONSTER HUNTER'),
        backgroundColor: AppColors.accentColor,
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonGreenColor,
              ),
              child: const Text('LOGIN'),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.firePrimaryColor,
              ),
              child: const Text('REGISTER A NEW HUNTER'),
            ),
          ],
        ),
      ),
    );
  }
}
