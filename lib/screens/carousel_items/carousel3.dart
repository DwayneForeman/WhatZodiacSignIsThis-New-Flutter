import 'package:flutter/material.dart';

class CarouselItem3 extends StatelessWidget {
  const CarouselItem3({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset("assets/images/carousel3-chart.png",
            width: width * 0.52),
        const Spacer(),
        Text("Climb the Charts",
            style: TextStyle(
                fontFamily: "Cherry",
                color: const Color(0xffffffff),
                fontSize: width * 0.075)),
        const SizedBox(height: 5),
        Container(
          width: width * 0.72,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  colors: [Color(0xff12A5FF), Color(0xff12FFF7)])),
        ),
        const SizedBox(height: 20),
        Text("Feeling competitive?",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.0442)),
        const SizedBox(height: 30),
        Text(
            textAlign: TextAlign.center,
            "Compete with others to reach the top 10\non the global leaderboard.",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.0442)),
        const Spacer(flex: 2),
      ],
    );
  }
}
