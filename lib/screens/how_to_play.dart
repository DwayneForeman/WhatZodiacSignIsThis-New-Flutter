import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/audio_services.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {

  final AudioService audioService = AudioService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/how-to-play-bg.png"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      Get.back();
                    },
                    child: const Align(
                        alignment: Alignment.centerRight,
                        child:
                            Icon(Icons.close, color: Colors.white, size: 28)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("How to Play",
                        style: TextStyle(
                            fontFamily: "SF-Compact",
                            fontWeight: FontWeight.w900,
                            color: Color(0xffffffff),
                            fontSize: 30)),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: const Color(0x15ffffff),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/mission-text.png', width: 108),
                          const SizedBox(height: 10),
                          const Text(
                              "You'll encounter a randomly generated text meme along with a set of 4 (Level 1), 8 (Level 2), or 12 (Level 3) random zodiac signs.\n\nYour mission? Pick the zodiac sign most likely to do or say what’s described in the text meme!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "SF-Compact",
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xffffffff),
                                  fontSize: 16)),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.415,
                        height: width * 0.415,
                        decoration: BoxDecoration(
                            color: const Color(0x15ffffff),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.17,
                              height: width * 0.17,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/star.png'),
                                      fit: BoxFit.fill)),
                              child: Center(
                                  child: Text('100',
                                      style: TextStyle(
                                          fontFamily: "SF-Compact",
                                          fontWeight: FontWeight.w900,
                                          fontSize: width * 0.0333,
                                          color: const Color(0xffFF0909)))),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'SF-Compact',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: width * 0.036,
                                ),
                                children: [
                                  const TextSpan(text: 'Start the game\nw/ '),
                                  TextSpan(
                                    text: '100',
                                    style: TextStyle(
                                      color: const Color(0xFF43E97B),
                                      // Green color for '100'
                                      fontWeight: FontWeight.w900,
                                      fontSize: width * 0.04,
                                      shadows: const [
                                        Shadow(
                                          // Outline effect
                                          offset: Offset(0, 0),
                                          blurRadius: 3,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const TextSpan(text: ' pts'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.415,
                        height: width * 0.415,
                        decoration: BoxDecoration(
                            color: const Color(0x15ffffff),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/balloon2.png',
                                width: width * 0.18, height: width * 0.18),
                            const SizedBox(height: 2),
                            Text(
                              '-5',
                              style: TextStyle(
                                fontFamily: 'SF-Compact',
                                fontSize: width * 0.04,
                                // Adjust the size as needed
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFF0909),
                                // Red color (#FF0909)
                                shadows: const [
                                  Shadow(
                                    // Black outline
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Text('Lifeline: Remove 1/2\nIncorrect Answers',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'SF-Compact',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: width * 0.035))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.415,
                        height: width * 0.415,
                        decoration: BoxDecoration(
                            color: const Color(0x15ffffff),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/check-icon.png',
                                width: width * 0.05),
                            Stack(
                              children: [
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      colors: [
                                        Color(0xff2AF598),
                                        Color(0xff009EFD)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds);
                                  },
                                  child: Text(
                                    "Nice Work!",
                                    style: TextStyle(
                                        fontFamily: "Cherry",
                                        fontSize: width * 0.062,
                                        color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "Nice Work!",
                                  style: TextStyle(
                                    fontFamily: "Cherry",
                                    fontSize: width * 0.062,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Image.asset('assets/images/virgo.png',
                                width: width * 0.1),
                            const SizedBox(height: 6),
                            Text(
                              '+10',
                              style: TextStyle(
                                fontFamily: 'SF-Compact',
                                fontSize: width * 0.032,
                                // Adjust the size as needed
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF43E97B),
                                // Red color (#FF0909)
                                shadows: const [
                                  Shadow(
                                    // Black outline
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Text('Correct Answer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'SF-Compact',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: width * 0.035))
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.415,
                        height: width * 0.415,
                        decoration: BoxDecoration(
                            color: const Color(0x15ffffff),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/close-icon.png',
                                width: width * 0.05),
                            Text(
                              'Try Again',
                              style: TextStyle(
                                fontFamily: 'Cherry',
                                fontSize: width * 0.05,
                                // Adjust the size as needed
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFF0909),
                                // Red color (#FF0909)
                                shadows: const [
                                  Shadow(
                                    // Black outline
                                    offset: Offset(0, 0),
                                    blurRadius: 3,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Image.asset('assets/images/leo.png',
                                width: width * 0.1),
                            const SizedBox(height: 6),
                            Text(
                              '-10',
                              style: TextStyle(
                                fontFamily: 'SF-Compact',
                                fontSize: width * 0.032,
                                // Adjust the size as needed
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFF0909),
                                // Red color (#FF0909)
                                shadows: const [
                                  Shadow(
                                    // Black outline
                                    offset: Offset(0, 0),
                                    blurRadius: 5,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Text('Incorrect Answer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'SF-Compact',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: width * 0.035))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    audioService.dispose();
  }
}
