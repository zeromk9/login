import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Monster {
  int id;
  String species;
  String name;
  String description;

  Monster({
    required this.id,
    required this.species,
    required this.name,
    required this.description,
  });

  Future<String?> getImagePath(String imageName) async {
    // Obtener el directorio de documentos de la aplicación
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // Construir la ruta completa del archivo de imagen
    String imagePath = '$appDocPath/imgs/monsters/$imageName.jpg';
    //print(imagePath);

    // Verificar si el archivo existe
    if (await File(imagePath).exists()) {
      return imagePath;
    } else {
      // Si el archivo no existe, puedes devolver null o una ruta predeterminada si quieres mostrar una imagen predeterminada.
      return null;
    }
  }

  Future<bool> doesImageExist() async {
    String? imagePath = await getImagePath(name);
    return imagePath != null && File(imagePath).existsSync();
  }

  factory Monster.fromRawJson(String str) => Monster.fromJson(json.decode(str));

  factory Monster.fromJson(Map<String, dynamic> json) => Monster(
        id: json["id"],
        species: json["species"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "species": species,
        "name": name,
        "description": description,
      };
}
