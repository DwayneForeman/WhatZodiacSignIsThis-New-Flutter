import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';

import '../horoscope/horoscope_controller.dart';
import '../horoscope/model.dart';
import '../subscription/subscription_controller.dart';
import '../utils/variables.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 12, vsync: this);

    // Listener to update selectedSign when the tab changes
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {
          selectedSign = zodiacLabels[tabController.index];
          print(selectedSign);
        });
      }
    });
  }

  String horoscopeDay = 'today';
  RxString horoscopeType = 'Relationship'.obs;
  String selectedSign = "Aries";
  String selectedDay = DateTime.now().day.toString();
  final HoroscopeController horoscopeController = HoroscopeController();

  Future<HoroscopeData> fetchHoroscopeData() async {
    return await horoscopeController.fetchHoroscopeData(
      sign: selectedSign,
      day: selectedDay,
      apiKey: GlobalVariables.to.apiKey,
      accessToken: GlobalVariables.to.accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: SizedBox(
        width: width,
        height: height,
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/horoscope-top-img.png',
                      width: width),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              TabBar(
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                isScrollable: true,
                indicator: const BoxDecoration(),
                tabs: List.generate(
                  12,
                  (index) => Tab(
                    height: 70,
                    child: SizedBox(
                      height: 70,
                      width: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background color for the selected label
                          if (tabController.index == index)
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 47,
                                width: index == 3 || index == 8 ? 100 : 90,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: const Color(0xff5848FE),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    zodiacLabels[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'SF-Compact',
                                      fontWeight: FontWeight.w900,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // Zodiac name label
                          Positioned(
                            bottom: 8,
                            child: Text(
                              zodiacLabels[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF-Compact',
                                fontWeight: FontWeight.w900,
                                color: tabController.index == index
                                    ? Colors.white
                                    : const Color(0xff8d8d8e),
                              ),
                            ),
                          ),
                          // Half-visible image
                          if (tabController.index == index)
                            Positioned(
                              top: 0,
                              child: Image.asset(
                                imgPaths[index],
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController, children: [
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                  tabView(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget tabView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(formatDate(horoscopeDay == 'yesterday' ? DateTime.now().subtract(const Duration(days: 1)) : horoscopeDay == 'tomorrow' ? DateTime.now().add(const Duration(days: 1)): DateTime.now()),
              style: const TextStyle(
                  fontFamily: 'SF-Compact',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffC4D0FB))),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                 if(horoscopeDay != 'yesterday'){
                   setState(() {
                     horoscopeDay = 'yesterday';
                     selectedDay = DateTime.now().subtract(const Duration(days: 1)).day.toString();
                     if (kDebugMode) {
                       print(selectedDay);
                     }
                   });
                 }
                },
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: horoscopeDay == 'yesterday'
                          ? Colors.white.withOpacity(0.1)
                          : Colors.transparent),
                  child: Center(
                      child: Text('Yesterday',
                          style: TextStyle(
                              fontFamily: 'SF-Compact',
                              fontWeight: FontWeight.w900,
                              color: horoscopeDay == 'yesterday'
                                  ? const Color(0xffC4D0FB)
                                  : Colors.white))),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if(horoscopeDay != 'today'){
                    setState(() {
                      horoscopeDay = 'today';
                      selectedDay = DateTime.now().day.toString();
                      print(selectedDay);
                    });
                  }
                },
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: horoscopeDay == 'today'
                          ? Colors.white.withOpacity(0.1)
                          : Colors.transparent),
                  child: Center(
                      child: Text('Today',
                          style: TextStyle(
                              fontFamily: 'SF-Compact',
                              fontWeight: FontWeight.w900,
                              color: horoscopeDay == 'today'
                                  ? const Color(0xffC4D0FB)
                                  : Colors.white))),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if(horoscopeDay != 'tomorrow'){
                    setState(() {
                      horoscopeDay = 'tomorrow';
                      selectedDay = DateTime.now().add(const Duration(days: 1)).day.toString();
                    });
                  }
                },
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: horoscopeDay == 'tomorrow'
                          ? Colors.white.withOpacity(0.1)
                          : Colors.transparent),
                  child: Center(
                      child: Text('Tomorrow',
                          style: TextStyle(
                              fontFamily: 'SF-Compact',
                              fontWeight: FontWeight.w900,
                              color: horoscopeDay == 'tomorrow'
                                  ? const Color(0xffC4D0FB)
                                  : Colors.white))),
                ),
              )),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Relationship';
                },
                child: Obx((){
                  return Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Relationship'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset(
                              'assets/images/relationship-emoji.png',
                              width: 16,
                              height: 16)));
                }),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Health';
                },
                child: Obx((){
                  return Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Health'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/health-emoji.png',
                              width: 16, height: 16)));
                }),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Profession';
                },
                child: Obx((){
                  return Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Profession'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/profession-emoji.png',
                              width: 16, height: 16)));
                }),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Emotions';
                },
                child: Obx((){
                  return Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Emotions'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/emotion-emoji.png',
                              width: 16, height: 16)));
                }),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Travel';
                },
                child: Obx((){
                  return Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Travel'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/travel-emoji.png',
                              width: 16, height: 16)));
                }),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Luck';
                },
                child: Obx((){
                  return Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Luck'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/luck-emoji.png',
                              width: 16, height: 16)));
                }),
              )),
              const SizedBox(width: 16),
            ],
          ),
          subscriptionController.entitlement.value == Entitlement.free ? 
           GestureDetector(
             onTap: () async{
               await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
               Get.to(const UpgradeScreen(showClose: true, goBack: true));
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
               child: Image.asset('assets/images/locked-horoscope.png'),
             ),
           )   :
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(
              minHeight: 250
            ),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Row(
                  children: [
                    Obx((){
                      return  Image.asset(getPredictionImg(horoscopeType.value),
                          width: 25, height: 25);
                    }),
                    const SizedBox(width: 20),
                    Obx((){
                      return Text(horoscopeType.value,
                          style: const TextStyle(
                              fontFamily: 'Cherry',
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffC4D0FB)));
                    })
                  ],
                ),
                const SizedBox(height: 12),
                FutureBuilder<HoroscopeData>(
                  future: fetchHoroscopeData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(child: CircularProgressIndicator(color: Colors.white)),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong! Please try again later', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SF-Compact')));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('Something went wrong! Please try again later', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SF-Compact')));
                    } else {
                // Parse and display the data from the API
                      final horoscopeData = snapshot.data!;
          
                      return Obx((){
                        return Text(getPredictionText(horoscopeType.value, horoscopeData),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SF-Compact', color: Colors.white)
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  String getPredictionText(String horoscopeType, HoroscopeData horoscopeData) {
    if (horoscopeType == 'Relationship') {
      return horoscopeData.prediction.personal;
    } else if (horoscopeType == 'Health') {
      return horoscopeData.prediction.health;
    } else if (horoscopeType == 'Profession') {
      return horoscopeData.prediction.profession;
    } else if (horoscopeType == 'Emotions') {
      return horoscopeData.prediction.emotions;
    } else if (horoscopeType == 'Travel') {
      return horoscopeData.prediction.travel;
    } else {
      return horoscopeData.prediction.luck.toString();  // Return luck as a string
    }
  }

  String getPredictionImg(String horoscopeType) {
    if (horoscopeType == 'Luck') {
      return 'assets/images/luck-emoji.png';
    } else if (horoscopeType == 'Health') {
      return 'assets/images/health-emoji.png';
    } else if (horoscopeType == 'Profession') {
      return 'assets/images/profession-emoji.png';
    } else if (horoscopeType == 'Emotions') {
      return 'assets/images/emotion-emoji.png';
    } else if (horoscopeType == 'Travel') {
      return 'assets/images/travel-emoji.png';
    } else {
      return 'assets/images/relationship-emoji.png';
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}
