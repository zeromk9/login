// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'loginbackend2023.somee.com';
  final storage = const FlutterSecureStorage();
  String? token;

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    try {
      final resp = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData),
      );
      print('Response body: ${resp.body}');
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (resp.statusCode == 200) {
        if (decodedResp.containsKey('token')) {
          await storage.write(key: 'token', value: decodedResp['token']);
          return null;
        } else {
          return 'Unexpected response format';
        }
      } else {
        // Handle non-200 status codes
        return 'Error: ${decodedResp['error']['message']}';
      }
    } catch (e) {
      // Handle network or other errors
      return 'Error: $e';
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.http(_baseUrl, '/api/Cuentas/Login');

    try {
      final resp = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authData),
      );
      print('Response body: ${resp.body}');
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (resp.statusCode == 200) {
        if (decodedResp.containsKey('token')) {
          token = decodedResp['token'];
          await storage.write(key: 'token', value: decodedResp['token']);
          return null;
        } else {
          return 'Unexpected response format';
        }
      } else {
        // Handle non-200 status codes
        return 'Error: ${decodedResp['error']['message']}';
      }
    } catch (e) {
      // Handle network or other errors
      return 'Error: $e';
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

//------------------------------------------------------------------------------------------------
  Future<String?> getUserId() async {
    try {
      final token = await readToken();

      if (token != null) {
        // Decodificar el token para obtener la información del usuario
        final Map<String, dynamic> decodedToken = json.decode(
          ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))),
        );

        // Aquí asumimos que el ID del usuario está presente en el token
        if (decodedToken.containsKey('sub')) {
          return decodedToken['sub'];
        }
      }
    } catch (e) {
      print('Error al obtener el ID del usuario: $e');
    }

    return null;
  }

  Future<void> agregarMonsterFavorito(String userId, String monsterName) async {
    try {
      final Map<String, dynamic> data = {
        'id': 0,
        'userId': userId,
        'monsterName': monsterName,
      };

      final url = Uri.http(_baseUrl, '/api/Cuentas/MonsterFavorito');

      final resp = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );

      if (resp.statusCode == 200) {
        print('Moustro favorito agregado con éxito');
      } else {
        print(
            'Error al agregar Moustro favorito. Código de estado: ${resp.statusCode}');
      }
    } catch (error) {
      print('Excepción al agregar Moustro favorito: $error');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerMonstersFavoritos(
      String userId) async {
    try {
      final url = Uri.http(_baseUrl, '/api/Cuentas/$userId');

      final resp = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (resp.statusCode == 200) {
        final List<dynamic> data = json.decode(resp.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        print(
            'Error al obtener moustros favoritos. Código de estado: ${resp.statusCode}');
        return [];
      }
    } catch (error) {
      print('Excepción al obtener moustros favoritos: $error');
      return [];
    }
  }
  //----------------------------------------------------------------------

  Future<void> quitarMonsterFavorito(String userId, String monsterName) async {
    try {
      final urlb = Uri.http(_baseUrl, '/api/Cuentas/$userId');

      final resp2 = await http.get(
        urlb,
        headers: {
          "Content-Type": "application/json",
        },
      );
      final List<dynamic> userDataList = json.decode(resp2.body);
      print('userda');
      print(userDataList);

      // Recorrer la lista de userData para buscar coincidencias
      for (final userData in userDataList) {
        int registroId = userData['id'];

        // Verificar si userId y monsterName coinciden con los de la base de datos
        if (userData['userId'] == userId &&
            userData['monsterName'] == monsterName) {
          print('id');
          print(userData['userId']);
          print(userData['monsterName']);
          print(userId);
          print(monsterName);

          final Map<String, dynamic> data = {
            'id': registroId,
            'userId': userId,
            'monsterName': monsterName,
          };

          final url =
              Uri.http(_baseUrl, '/api/Cuentas/EliminarMonsterFavorito');

          final resp = await http.delete(
            url,
            headers: {
              "Content-Type": "application/json",
            },
            body: json.encode(data),
          );

          if (resp.statusCode == 200) {
            print('Moustro favorito eliminado con éxito');
            return; // Salir de la función después de eliminar el moustro favorito
          } else {
            print('dentro del resp');
            print(
                'Error al eliminar Moustro favorito. Código de estado: ${resp.statusCode}');
          }
        } else {
          print(
              'userId y/o monsterName en los detalles no coinciden con la base de datos');
        }
      }

      // Si no se encontró coincidencia después de recorrer toda la lista
      print('No se encontraron coincidencias en la base de datos');
    } catch (error) {
      print('fuera de todo');
      print('Excepción al eliminar moustro favorito: $error');
    }
  }

  Future<bool> existeMonsterFavorito(String userId, String monsterName) async {
    try {
      final url = Uri.http(_baseUrl, '/api/Cuentas/$userId');

      final resp = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (resp.statusCode == 200) {
        final List<dynamic> userDataList = json.decode(resp.body);

        // Verificar si existe un moustro favorito con el userId y monsterName proporcionados
        return userDataList.any((userData) =>
            userData['userId'] == userId &&
            userData['monsterName'] == monsterName);
      } else {
        print(
            'Error al verificar moustro favorito. Código de estado: ${resp.statusCode}');
        return false;
      }
    } catch (error) {
      print('Excepción al verificar moustro favorito: $error');
      return false;
    }
  }
}
