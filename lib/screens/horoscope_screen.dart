import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsignisthis/screens/upgrade_screen.dart';

import '../horoscope/horoscope_controller.dart';
import '../horoscope/model.dart';
import '../sqflite/database_service.dart';
import '../sqflite/save_data_in_database.dart';
import '../subscription/subscription_controller.dart';
import '../utils/functions/get_time_zone.dart';
import '../utils/variables.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({super.key});

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  PageController pageController = PageController();
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  late String timezone;
  bool changeSign = false;
  String selectedSign = GlobalVariables.to.horoscopeSelectedSign;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
    timezone = getCurrentTimeZone();
    debugPrint('Time Zone: $timezone');
    tabController = TabController(length: 12, vsync: this);
    tabController.index = zodiacLabels.indexOf(selectedSign.toUpperCase());

    // Listener to update selectedSign when the tab changes
    // tabController.addListener(() async {
    //   if (tabController.indexIsChanging) {
    //     setState(() {
    //       GlobalVariables.to.horoscopeSelectedSign = zodiacLabels[tabController.index];
    //       debugPrint(GlobalVariables.to.horoscopeSelectedSign);
    //     });
    //   }
    // });
  }


  String horoscopeDay = 'today';
  RxString horoscopeType = 'Relationship'.obs;
  String selectedDay = DateTime.now().day.toString();
  String selectedMonth = DateTime.now().month.toString();
  String selectedYear = DateTime.now().year.toString();
  final HoroscopeController horoscopeController = HoroscopeController();

  // Future<HoroscopeData> fetchHoroscopeData() async {
  //   return await horoscopeController.fetchHoroscopeData(
  //       sign: selectedSign,
  //       day: selectedDay,
  //       apiKey: GlobalVariables.to.horoscopeApiKey,
  //       accessToken: GlobalVariables.to.horoscopeAccessToken,
  //       tzone: timezone);
  // }

  Future<HoroscopeData> fetchHoroscopeData() async {
    // Check if data exists in the local SQLite database first
    HoroscopeData? localData = await getHoroscopeDataFromDatabase(selectedSign, selectedDay);

    // If data is found in local database, return it
    if (localData != null) {
      return localData;
    }

    // If no data is found, fetch it from the API
    HoroscopeData apiData = await horoscopeController.fetchHoroscopeData(
      sign: selectedSign,
      day: selectedDay,
      month: selectedMonth,
      year: selectedYear,
      apiKey: GlobalVariables.to.horoscopeApiKey,
      accessToken: GlobalVariables.to.horoscopeAccessToken,
      tzone: timezone,
    );

    saveHoroscopeDataInDatabase(apiData, date: selectedDay, day: horoscopeDay);
    // Return the fetched data
    return apiData;
  }

  Future<HoroscopeData?> getHoroscopeDataFromDatabase(String sign, String day) async {
    // Query the database using sign (table name) and day (primary key)
    var db = await HoroscopeDatabase.instance.database;
    var result = await db.query(
      sign,
      where: 'date = ?',
      whereArgs: [day],
    );

    if (result.isNotEmpty) {
      // Assuming the stored data is serialized as a map

      var record = result.first;
      debugPrint('Data from local Database');
      return HoroscopeData(
        sign: selectedSign, // Assign selectedSign directly
        prediction: Prediction(
          personal: record['relationship'] as String, // Assuming relationship field maps to personal
          health: record['health'] as String,         // Direct assignment from the result
          profession: record['profession'] as String, // Direct assignment from the result
          emotions: record['emotions'] as String,     // Direct assignment from the result
          travel: record['travel'] as String,         // Direct assignment from the result
          luck: [record['luck'] as String],  // Assuming 'luck' is stored as a comma-separated string
        ),
      );
    }

    return null; // No data found
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
                          color: Colors.white, size: 25),
                    ),
                  ),
                ],
              ),
              TabBar(
                onTap: (index) {
                  // Only allow tab switching when `changeSign` is true
                  if (changeSign) {
                    pageController.jumpToPage(index);
                    tabController.index = index;
                    setState(() {
                      selectedSign = zodiacLabels[index];
                    });
                  }
                },
                physics: changeSign == false
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                isScrollable: true,
                indicator: const BoxDecoration(),
                tabs: List.generate(
                  12,
                      (index) => GestureDetector(
                    onTap: () {
                      // Prevent interaction when `changeSign` is false
                      if (!changeSign) return;

                      pageController.jumpToPage(index);
                      tabController.index = index;
                      setState(() {
                        selectedSign = zodiacLabels[index];
                      });
                    },
                    child: AbsorbPointer(
                      absorbing: !changeSign && tabController.index != index,
                      child: Tab(
                        height: changeSign == false ? 70 : 100,
                        child: SizedBox(
                          height: changeSign == false ? 70 : 100,
                          width: 100,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background color for the selected label
                              Visibility(
                                visible: tabController.index == index,
                                child: Positioned(
                                  bottom: changeSign == false ? 0 : 30,
                                  child: Container(
                                    height: 47,
                                    width: index == 3 || index == 8 ? 100 : 90,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              ),
                              // Zodiac name label
                              Positioned(
                                bottom: changeSign == false ? 8 : 38,
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
                              Visibility(
                                visible: tabController.index == index,
                                child: Positioned(
                                  top: 0,
                                  child: Image.asset(
                                    imgPaths[index],
                                    height: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              // Edit Icon
                              Visibility(
                                visible: tabController.index == index && !changeSign,
                                child: Positioned(
                                  right: 0,
                                  top: 12,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        changeSign = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit,
                                        color: Colors.white, size: 22),
                                  ),
                                ),
                              ),
                              // Save text
                              Visibility(
                                visible: tabController.index == index && changeSign,
                                child: Positioned(
                                  right: 0,
                                  left: 0,
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('horoscope_selected_sign', selectedSign);
                                      setState(() {
                                        changeSign = false;
                                        GlobalVariables.to.horoscopeSelectedSign =
                                            selectedSign;
                                      });
                                    },
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('save',
                                            style: TextStyle(
                                                fontFamily: 'SF-Compact',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff84FAB0))),
                                        Icon(Icons.check_circle_rounded,
                                            color: Color(0xff84FAB0), size: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return tabView(index); // Pass index to track current page
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabView(int pageIndex) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
              formatDate(horoscopeDay == 'yesterday'
                  ? DateTime.now().subtract(const Duration(days: 1))
                  : horoscopeDay == 'tomorrow'
                      ? DateTime.now().add(const Duration(days: 1))
                      : DateTime.now()),
              style: const TextStyle(
                  fontFamily: 'SF-Compact',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffC4D0FB))),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (horoscopeDay != 'yesterday') {
                    setState(() {
                      horoscopeDay = 'yesterday';
                      DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
                      selectedDay = yesterday.day.toString();
                      selectedMonth = yesterday.month.toString();
                      selectedYear = yesterday.year.toString();
                      if (kDebugMode) {
                        print("$selectedDay-$selectedMonth-$selectedYear");
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
                              fontSize: 16,
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
                  if (horoscopeDay != 'today') {
                    setState(() {
                      horoscopeDay = 'today';
                      selectedDay = DateTime.now().day.toString();
                      selectedMonth = DateTime.now().month.toString();
                      selectedYear = DateTime.now().year.toString();
                      debugPrint('$selectedDay-$selectedMonth-$selectedYear');
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
                              fontSize: 16,
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
                  if (horoscopeDay != 'tomorrow') {
                    setState(() {
                      horoscopeDay = 'tomorrow';
                      DateTime tommorow = DateTime.now().add(const Duration(days: 1));
                      selectedDay = tommorow.day.toString();
                      selectedMonth = tommorow.month.toString();
                      selectedYear = tommorow.year.toString();
                      if (kDebugMode) {
                        print("$selectedDay-$selectedMonth-$selectedYear");
                      }
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
                              fontSize: 16,
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
                child: Obx(() {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Relationship'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset(
                              'assets/images/relationship-emoji.png',
                              width: 18,
                              height: 18)));
                }),
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Health';
                },
                child: Obx(() {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Health'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/health-emoji.png',
                              width: 18, height: 18)));
                }),
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Profession';
                },
                child: Obx(() {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Profession'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset(
                              'assets/images/profession-emoji.png',
                              width: 18,
                              height: 18)));
                }),
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Emotions';
                },
                child: Obx(() {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Emotions'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/emotion-emoji.png',
                              width: 18, height: 18)));
                }),
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Travel';
                },
                child: Obx(() {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Travel'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/travel-emoji.png',
                              width: 18, height: 18)));
                }),
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  horoscopeType.value = 'Luck';
                },
                child: Obx(() {
                  return Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: horoscopeType.value == 'Luck'
                              ? const Color(0xff7579FF)
                              : Colors.white.withOpacity(0.1)),
                      child: Center(
                          child: Image.asset('assets/images/luck-emoji.png',
                              width: 18, height: 18)));
                }),
              )),
              const SizedBox(width: 16),
            ],
          ),
          subscriptionController.entitlement.value == Entitlement.free
              ? GestureDetector(
                  onTap: () async {
                    await precacheImage(
                        const AssetImage("assets/images/how-to-play-bg.png"),
                        context);
                    Get.to(const UpgradeScreen(showClose: true, goBack: true));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Image.asset('assets/images/locked-horoscope.png'),
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  padding: const EdgeInsets.all(24),
                  constraints: const BoxConstraints(minHeight: 250),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(() {
                            return Image.asset(
                                getPredictionImg(horoscopeType.value),
                                width: 25,
                                height: 25);
                          }),
                          const SizedBox(width: 20),
                          Obx(() {
                            return Text(horoscopeType.value,
                                style: const TextStyle(
                                    fontFamily: 'Cherry',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffC4D0FB)));
                          })
                        ],
                      ),
                      const SizedBox(height: 12),
                      pageIndex == currentPage ? FutureBuilder<HoroscopeData>(
                        future: fetchHoroscopeData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white)),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text(
                                    'Something went wrong! Please try again later',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SF-Compact')));
                          } else if (!snapshot.hasData) {
                            return const Center(
                                child: Text(
                                    'Something went wrong! Please try again later',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SF-Compact')));
                          } else {
                            // Parse and display the data from the API
                            final horoscopeData = snapshot.data!;

                            return Obx(() {
                              if (horoscopeType.value == 'Luck') {
                                // If the type is 'Luck', display the luck items as separate lines
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: horoscopeData.prediction.luck.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    String item = entry.value;

                                    // Check if it's the last item in the list
                                    return Text(
                                      index == horoscopeData.prediction.luck.length - 1
                                          ? item
                                          : "$item\n", // If last item, don't add \n
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SF-Compact',
                                        color: Colors.white,
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else {
                                // Default behavior for other horoscope types
                                return Text(
                                  getPredictionText(
                                      horoscopeType.value, horoscopeData),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SF-Compact',
                                    color: Colors.white,
                                  ),
                                );
                              }
                            });
                          }
                        },
                      ) : const SizedBox(),
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
      return horoscopeData.prediction.luck
          .toString(); // Return luck as a string
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