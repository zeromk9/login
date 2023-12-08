// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'services/services.dart';
import 'providers/providers.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => TemaManager()),
        ],
        child: const AppState(),
      ),
    );

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MonstersProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN TO MONSTER HUNTER',
      initialRoute: 'home',
      routes: {
        'checking': (_) => const CheckAuthScreen(),
        'home': (_) => const HomeScreen(),
        'login': (_) => const LoginScreen(),
        'monster_details': (_) => const MonsterDetailsScreen(),
        'monster': (_) => const MonsterScreen(),
        'register': (_) => const RegistrarScreen(),
        'welcome': (_) => const WelcomeScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: _getTheme(context),
    );
  }

  ThemeData _getTheme(BuildContext context) {
    final temaManager = Provider.of<TemaManager>(context);

    return temaManager.tema.copyWith(
      scaffoldBackgroundColor: Colors.black54,
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.redAccent),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
    );
  }
}
