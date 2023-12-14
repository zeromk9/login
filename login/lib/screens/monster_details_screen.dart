// monster_details_screen.dart

// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
// import 'package:login/data/monster_names.dart';
import 'package:provider/provider.dart';
import '/models/models.dart';
// import '/providers/providers.dart';
import '/services/services.dart';

class MonsterDetailsScreen extends StatefulWidget {
  const MonsterDetailsScreen({super.key});

  @override
  State<MonsterDetailsScreen> createState() => _MonsterDetailsScreenState();
}

class _MonsterDetailsScreenState extends State<MonsterDetailsScreen> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final authService = Provider.of<AuthService>(context, listen: false);
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final Monster monster = args['monster'];
      final String userEmail = args['userEmail'];

      // Verificar si el juego es favorito y asignar a isFavorite
      authService.existeMonsterFavorito(userEmail, monster.name).then((exists) {
        setState(() {
          isFavorite = exists;
        });
      });
    });
  }

  bool isTextVisible = true;
  void toggleTextVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Monster monster = args['monster'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(monster.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite == true ? Icons.favorite : Icons.favorite_border,
              color: Color.fromARGB(255, 168, 24, 24),
              size: 30,
            ),
            onPressed: () {
              toggleFavorite();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              _MonsterName(monster: monster),
              const SizedBox(height: 20),
              _MonsterImage(name: monster.name),
            ]),
          ),
        ],
      ),
    );
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    //print(isFavorite);
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Monster monster = args['monster'];
    final String userEmail = args['userEmail'];

    // isFavorite = !isFavorite;
    String monsterName = monster.name;

    final authService = Provider.of<AuthService>(context, listen: false);
    // print(userEmail);
    // print(monsterName);
    // Llama a la función correspondiente en tu servicio
    if (isFavorite == true) {
      // print('entra');
      authService.agregarMonsterFavorito(userEmail, monsterName);
    } else if (isFavorite == false) {
      // print('entre en else');
      authService.quitarMonsterFavorito(userEmail, monsterName);
    }
  }
}

class _MonsterName extends StatelessWidget {
  final Monster monster;

  const _MonsterName({required this.monster});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.topLeft,
          child: Text(
            monster.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          alignment: Alignment.topLeft,
          child: Text(
            monster.description,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class _MonsterImage extends StatelessWidget {
  final String name;

  const _MonsterImage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/imgs/monsters/$name.jpg',
        fit: BoxFit.cover,
        width: 250,
        height: 250,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/imgs/nodata.jpg',
            fit: BoxFit.cover,
            width: 250,
            height: 250,
          );
        },
      ),
    );
  }
}
