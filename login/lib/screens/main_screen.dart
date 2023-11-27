import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/providers.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: loginFormProvider.getEmail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Welcome Hunter');
            } else if (snapshot.hasError) {
              return const Text('Welcome Hunter');
            } else {
              final nameEmail = snapshot.data ?? 'Welcome Hunter';
              return Text(nameEmail);
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/menus/welcome.gif',
              height: 300,
              width: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'Accesando to My App...',
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
