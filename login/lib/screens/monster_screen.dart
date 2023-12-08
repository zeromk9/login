import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/widgets.dart';
import '/providers/providers.dart';

class MonsterScreen extends StatelessWidget {
  const MonsterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final monstersProvider = Provider.of<MonstersProvider>(context);
    List<String> nombresDeseados = [
      "Anjanath",
      "Azure Rathalos",
      "Barioth",
      "Barroth",
      "Black Diablos",
      "Deviljho",
      "Diablos",
      "Dodogama",
      "Great Girros",
      "Jyuratodus",
      "Kirin",
      "Kulu-Ya-Ku",
      "Kushala Daora",
      "Lavasioth",
      "Legiana",
      "Lunastra",
      "Nergigante",
      "Odogaron",
      "Paolumu",
      "Pink Rathian",
      "Pukei-Pukei",
      "Radobaan",
      "Rathalos",
      "Rathian",
      "Teostra",
      "Tobi-Kadachi",
      "Tzitzi-Ya-Ku",
      "Uragaan",
      "Vaal Hazak",
      "Xeno'jiiva",
      "Zorah Magdaros",
      "Zinogre"
    ];

    // Llamar al método getMonsterInfo con la lista de nombres deseados
    Future<void> loadMonsters() async {
      await monstersProvider.getMonsterInfo(names: nombresDeseados);
    }

    // Llamar al método de carga de monstruos cuando se construye el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMonsters();
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
        title: const Center(
          child: Text('MONSTERS'),
        ),
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
