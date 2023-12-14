// monster_card_swiper.dart
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '/models/models.dart';

class MonsterCardSwiper extends StatelessWidget {
  final List<Monster> monsters;
  final String userEmail;
  const MonsterCardSwiper(
      {Key? key, required this.monsters, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(userEmail);
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
                Navigator.pushNamed(context, 'monster_details',
                    arguments: {'monster': monster, 'userEmail': userEmail});
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/imgs/monsters/${monster.name}.jpg',
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/imgs/nodata.jpg',
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
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
