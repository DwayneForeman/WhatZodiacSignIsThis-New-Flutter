import 'package:flutter/material.dart';

class CarouselItem2 extends StatelessWidget {
  const CarouselItem2({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Spacer(flex: 3),
        Image.asset('assets/images/carousel2-group.png', width: width * 0.62),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/brain-emoji.png', width: 30, height: 30),
            const SizedBox(width: 10),
            Text("Test your Zodiac IQ",
                style: TextStyle(
                    fontFamily: "Cherry",
                    color: const Color(0xffffffff),
                    fontSize: width * 0.075)),
          ],
        ),
        const SizedBox(height: 3),
        Container(
          width: width * 0.76,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  colors: [Color(0xffB721FF), Color(0xff21D4FD)])),
        ),
        SizedBox(height: width * 0.05),
        Text("Guess that Zodiac!",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.0442)),
        SizedBox(height: width * 0.08),
        Text(
            textAlign: TextAlign.center,
            "Guess which Sign is most likely to say\nwhat is written in text meme displayed.",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.0442)),
        const Spacer(flex: 2)
      ],
    );
  }
}
