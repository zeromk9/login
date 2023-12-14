// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import '/models/models.dart';
// import '/providers/providers.dart';
// import 'package:provider/provider.dart';
import '/services/services.dart';

class MonsterFavoritesScreen extends StatefulWidget {
  const MonsterFavoritesScreen({
    super.key,
  });

  @override
  State<MonsterFavoritesScreen> createState() => _MonsterFavoritesScreenState();
}

class _MonsterFavoritesScreenState extends State<MonsterFavoritesScreen> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Monster> monster = args['monster'];
    final String userEmail = args['userEmail'];
    print('Favorito');
    print(userEmail);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 194, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 82, 31),
        title: const Text('MOUSTROS FAVORITOS'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'monster',
                arguments: {'email': userEmail});
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: authService.obtenerMonstersFavoritos(userEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se obtienen los datos
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Muestra un mensaje de error si ocurre un error
            return Center(
              child: Text(
                  'Error al obtener moustros favoritos: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Muestra un mensaje si no hay moustros favoritos
            return const Center(
              child: Text('No tienes moustros favoritos'),
            );
          } else {
            // Muestra la lista de moustros favoritos
            List<Map<String, dynamic>> moustrosFavoritos = snapshot.data!;
            return ListView.builder(
              itemCount: moustrosFavoritos.length,
              itemBuilder: (_, index) {
                final moustro = monster.firstWhere(
                  (monster) =>
                      monster.name == moustrosFavoritos[index]['monsterName'],
                ); //aqui checa si el monsterName y el monsterName de ese index son iguales
                return GestureDetector(
                  onTap: () {
                    print('ontap');
                    print(userEmail);
                    // Navegar a otra pantalla cuando se toca el elemento
                    Navigator.pushNamed(context, 'monster_details', arguments: {
                      'monster': moustro,
                      'userEmail': userEmail
                    }).then((_) {
                      // el codigo corre cuando details cierra.
                      setState(() {});
                    });
                  },
                  child: ListTile(
                    title: Text(
                      (moustro.name == 'Deviljho') ? 'Deviljho' : moustro.name,
                    ),
                    leading: Image.asset(moustro.monsterImage ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
