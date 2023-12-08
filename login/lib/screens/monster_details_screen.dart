import 'package:flutter/material.dart';
import '/models/models.dart';

class MonsterDetailsScreen extends StatefulWidget {
  const MonsterDetailsScreen({super.key});

  @override
  State<MonsterDetailsScreen> createState() => _MonsterDetailsScreenState();
}

class _MonsterDetailsScreenState extends State<MonsterDetailsScreen> {
  bool isTextVisible = true;
  void toggleTextVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Monster monster =
        ModalRoute.of(context)?.settings.arguments as Monster;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange, title: Text(monster.name)),
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
        'assets/imgs/monsters/$name.jpg', // Ruta de la imagen del monstruo
        fit: BoxFit
            .cover, // Ajustar la imagen para que se vea completa sin importar el tamaño original
        width:
            250, // Tamaño específico para la imagen (ajústalo según tus necesidades)
        height:
            250, // Tamaño específico para la imagen (ajústalo según tus necesidades)
        errorBuilder: (context, error, stackTrace) {
          // En caso de error al cargar la imagen, cargar la imagen de respaldo
          return Image.asset(
            'assets/imgs/nodata.jpg', // Ruta de la imagen de respaldo
            fit: BoxFit
                .cover, // Ajustar la imagen de respaldo de la misma manera
            width: 250, // Tamaño específico para la imagen de respaldo
            height: 250, // Tamaño específico para la imagen de respaldo
          );
        },
      ),
    );
  }
}
