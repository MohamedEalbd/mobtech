import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarouserlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      width: double.infinity,
      child: Carousel(
        dotSize: 8,
        dotIncreaseSize: 2,
        dotColor: Colors.white,
        dotBgColor: Colors.black.withOpacity(.4),
        dotIncreasedColor: Colors.blue,
        indicatorBgPadding: 10,
        boxFit: BoxFit.cover,
        images: [
          AssetImage(
            'assets/images/mob.png',
          ),
          AssetImage(
            'assets/images/mob1.jpg',
          ),
          AssetImage(
            'assets/images/mo1.jpg',
          ),
        ],
      ),
    );
  }
}
