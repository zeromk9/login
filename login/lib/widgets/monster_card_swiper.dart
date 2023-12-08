import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '/models/models.dart';

class MonsterCardSwiper extends StatelessWidget {
  final List<Monster> monsters;
  const MonsterCardSwiper({super.key, required this.monsters});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.6,
        child: Swiper(
          itemCount: monsters.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.6,
          itemBuilder: (_, int index) {
            final monster = monsters[index];
            return GestureDetector(
              onTap: () {
                //print("Pushing to details screen");
                Navigator.pushNamed(context, '/details', arguments: monster);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.orange,
                      child: Text(
                        monster.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Tamaño grande para el texto
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/imgs/monsters/${monster.name}.jpg',
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
