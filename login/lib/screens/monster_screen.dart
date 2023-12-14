// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/monster_names.dart';
import '/widgets/widgets.dart';
import '/providers/providers.dart';
import '/services/services.dart';

class MonsterScreen extends StatefulWidget {
  const MonsterScreen({super.key});

  @override
  State<MonsterScreen> createState() => _MonsterScreenState();
}

class _MonsterScreenState extends State<MonsterScreen> {
  late String userEmail;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userEmail = args['email'];
    // print(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final monstersProvider = Provider.of<MonstersProvider>(context);
    Future<void> loadMonsters() async {
      await monstersProvider.getMonsterInfo(names: monsterNames);
    }

    // Cargar monstruos y favoritos al construir el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMonsters();
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text('MONSTERS'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, 'monster_favorites', arguments: {
                'monster': monstersProvider.onDisplayMonsters,
                'userEmail': userEmail
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
        ],
      ),
      body: Consumer<MonstersProvider>(
        builder: (_, provider, __) {
          if (provider.onDisplayMonsters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                MonsterCardSwiper(
                  monsters: provider.onDisplayMonsters,
                  userEmail: userEmail,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
