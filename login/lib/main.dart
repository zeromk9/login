// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login/screens/check_auth_screen.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN TO MY APP',
      initialRoute: 'home',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegistrarScreen(),
        'home': (_) => HomeScreen(),
        'checking': (_) => CheckAuthScreen()
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.black54,
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.redAccent),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.redAccent, elevation: 0)),
    );
  }
}
