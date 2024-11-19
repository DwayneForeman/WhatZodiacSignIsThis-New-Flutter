import 'package:flutter/material.dart';

class CarouselItem4 extends StatelessWidget {
  const CarouselItem4({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset("assets/images/carousel4-header-img.png",
            width: width * 0.6),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/crystal-ball.png', width: 25, height: 25),
            const SizedBox(width: 10),
            Text("Daily Horoscopes",
                style: TextStyle(
                    fontFamily: "Cherry",
                    color: const Color(0xffffffff),
                    fontSize: width * 0.075)),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: width * 0.72,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  colors: [Color(0xffB721FF), Color(0xff21D4FD)])),
        ),
        const SizedBox(height: 20),
        Text("Meet Erin..Your Astrologer Bestie!",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.0442)),
        const SizedBox(height: 30),
        Text(
            textAlign: TextAlign.center,
            "Horo-SCOPES and JOKES all in one. Your\ndaily necessities to start & end the day.",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.04)),
        const Spacer(flex: 2),
      ],
    );
  }
}
