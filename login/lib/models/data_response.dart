import 'data_monsters.dart';

class Response {
  List<Monster> info;

  Response({
    required this.info,
  });

  factory Response.fromJson(List<dynamic> json) {
    // Parsear la lista json y crear una lista de Monster
    return Response(
      info: List<Monster>.from(json.map((x) => Monster.fromJson(x))),
    );
  }
}
