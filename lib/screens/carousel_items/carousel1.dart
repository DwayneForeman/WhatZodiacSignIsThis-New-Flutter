import 'package:flutter/material.dart';

class CarouselItem1 extends StatelessWidget {
  const CarouselItem1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Spacer(flex: 3),
        Container(
          width: width * 0.8,
          height: width * 0.7,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/carousel1-container.png"),
                  fit: BoxFit.fill)),
          child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: width*0.09, top: width*0.18),
                child: SizedBox(
                  width: width*0.64,
                  child: Text(
                      textAlign: TextAlign.center,
                      "Running an errand is now considered “going out” and you can’t tell me any different. Argue with ya mamma!",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w800,
                          color: const Color(0xffffffff),
                          fontSize: width * 0.0335)),
                ),
              ))
        ),
        const Spacer(),
        Row(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/rolling-on-the-floor-laughing.png', width: 25, height: 25),
            const SizedBox(width: 10),
            Text("1200+ Text Memes",
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
        SizedBox(height: width * 0.053),
        Text("Laugh Your Ahhh Off",
            style: TextStyle(
                fontFamily: "SF-Compact",
                fontWeight: FontWeight.w900,
                color: const Color(0xffffffff),
                fontSize: width * 0.0442)),
        SizedBox(height: width * 0.083),
        Text(
            textAlign: TextAlign.center,
            "Enjoy the most funniest meme jokes to\nkeep you entertained all day ‘n’ night.",
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