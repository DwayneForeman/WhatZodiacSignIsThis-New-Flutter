import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  late InfiniteScrollController controller;

  int selectedIndex = 0;

  List<String> zodiacLabels = [
    "ARIES",
    "AQUARIUS",
    "CANCER",
    "CAPRICORN",
    "GEMINI",
    "LEO",
    "LIBRA",
    "PISCES",
    "SAGITTARIUS",
    "SCORPIO",
    "TAURUS",
    "VIRGO",
  ];

  List<String> imgPaths = [
    'assets/images/aries.png',
    'assets/images/aquarius.png',
    'assets/images/cancer.png',
    'assets/images/capricorn.png',
    'assets/images/gemini.png',
    'assets/images/leo.png',
    'assets/images/libra.png',
    'assets/images/pisces.png',
    'assets/images/sagittarius.png',
    'assets/images/scorpio.png',
    'assets/images/taurus.png',
    'assets/images/virgo.png',
  ];

  String selectedItem = 'LEO';

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 75,
              child: InfiniteCarousel.builder(
                itemCount: 12,
                itemExtent: 150,
                center: true,
                anchor: 0.0,
                velocityFactor: 0.2,
                onIndexChanged: (index) {},
                controller: controller,
                axisDirection: Axis.horizontal,
                loop: true,
                itemBuilder: (context, itemIndex, realIndex) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedItem = zodiacLabels[itemIndex];
                      });
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 50,
                            width: 110,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: selectedItem == zodiacLabels[itemIndex] ? const Color(0xff5848FE) : Colors.transparent,
                            ),
                            child: Center(child: Text(zodiacLabels[itemIndex], style: TextStyle(fontFamily: 'SF-Compact', color: selectedItem == zodiacLabels[itemIndex] ? Colors.white : const Color(0xff8d8d8e), fontWeight: FontWeight.w900, fontSize: 14))),
                          ),
                        ),
                        Visibility(
                          visible: selectedItem == zodiacLabels[itemIndex],
                          child: Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              imgPaths[itemIndex],
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
