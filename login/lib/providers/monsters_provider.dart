import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/models/models.dart';

class MonstersProvider extends ChangeNotifier {
  final String _baseUrl = 'mhw-db.com';
  List<Monster> onDisplayMonsters = [];

  Future<void> getMonsterInfo({List<String>? names}) async {
    String monsters = 'monsters';
    var url = Uri.https(_baseUrl, monsters);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final monsterInfo = Response.fromJson(jsonResponse);

        if (names != null && names.isNotEmpty) {
          onDisplayMonsters = monsterInfo.info
              .where((monster) => names.contains(monster.name))
              .toList();
        } else {
          onDisplayMonsters = monsterInfo.info;
        }

        // Imprimir la lista solo la primera vez que se obtienen los datos
/*         if (!_isListPrinted) {
          print('Lista de monstruos obtenida de la API:');
          onDisplayMonsters.forEach((monster) {
            print('ID: ${monster.id}, Nombre: ${monster.name}');
          });
          _isListPrinted = true;
        } */

        notifyListeners();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
