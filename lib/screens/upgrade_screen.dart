import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:whatsignisthis/utils/functions/open_url.dart';

import '../subscription/purchase_api.dart';
import '../subscription/subscription_controller.dart';
import '../utils/audio_service/audio_services.dart';
import '../utils/variables.dart';
import 'home_screen.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key, required this.showClose, required this.goBack});
  final bool showClose;
  final bool goBack;

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {

  final AudioService audioService = AudioService();
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  bool isLoading = false;
  int counter = 0;
  DateTime targetDate = DateTime(2024, 12, 5);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PopScope(
        canPop: false,
        // onPopInvokedWithResult: (bool didPop, FormData? result) async {
        //   MapEntry<String, String> question = await getRandomQuestion();
        //   await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
        //   Get.offAll(Level1Screen(question: question));
        //   return;
        // },
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                counter++;
                if(counter == 10 && DateTime.now().isBefore(targetDate)) {
                  subscriptionController.entitlement.value =
                      Entitlement.premium;
                  Get.snackbar('Success', 'You got premium access', colorText: Colors.white);
                  Get.offAll(const HomeScreen());
                }
              },
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/how-to-play-bg.png"),
                        fit: BoxFit.fill)),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: width*0.0),
                              Padding(
                                padding: EdgeInsets.only(left: widget.showClose == true ? 20 : 0),
                                child: Image.asset("assets/images/logo.png",
                                    width: width * 0.48,
                                    height: width * 0.48),
                              ),
                              Visibility(
                                visible: widget.showClose,
                                child: GestureDetector(
                                  onTap: () async {
                                    if(widget.goBack){
                                      Get.back();
                                    } else{
                                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                      await precacheImage(const AssetImage("assets/images/home-bg.png"), context);
                                      Get.offAll(const HomeScreen());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Icon(Icons.close,
                                        color: Colors.white,
                                        size: width * 0.07),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Text("Go Premium",
                          //     style: TextStyle(
                          //         color: const Color(0xffffffff),
                          //         fontSize: width * 0.08,
                          //         fontFamily: "Cherry")),
                          // const SizedBox(height: 5),
                          // Container(
                          //   width: width * 0.65,
                          //   height: 4,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       gradient: const LinearGradient(
                          //           colors: [Color(0xffB3FFAB), Color(0xff12FFF7)])),
                          // ),
                          // const SizedBox(height: 20),
                          // FeaturesRow(
                          //     iconSize: width*0.048,
                          //     label: "3 Day Free Trial",
                          //     iconPath: "assets/images/3-day-free-icon.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.062,
                          //     label: "Unlimited Games",
                          //     iconPath: "assets/images/unlimited-games-icon.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.05,
                          //     label: "No More Ads",
                          //     iconPath: "assets/images/no-ads-icon.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.058,
                          //     label: "Joke Notifications",
                          //     iconPath: "assets/images/joke-notification-icon.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.038,
                          //     label: "Unlock All Levels",
                          //     iconPath: "assets/images/unlock-icon.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.048,
                          //     label: "1200 + Text Meme",
                          //     iconPath: "assets/images/laughing-emoji.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.046,
                          //     label: "Free Content Updates",
                          //     iconPath: "assets/images/free-content-icon.png"),
                          // FeaturesRow(
                          //     iconSize: width*0.05,
                          //     label: "Cancel Anytime",
                          //     iconPath: "assets/images/cancel-anytime-icon.png"),
                          Image.asset('assets/images/go-premium.png', width: width*0.8),
                          const SizedBox(height: 28),
                          Text('First 3 Days For Free', style: TextStyle(fontFamily: 'SF-Compact', color: Colors.white, fontWeight: FontWeight.w900, fontSize: width*0.0416)),
                          Text('Then ${GlobalVariables.to.weeklyPrice.value}/ week', style: TextStyle(fontFamily: 'SF-Compact', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.03888)),
                          Text('Billing starts after trial.', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.02777)),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                              final offerings = await PurchaseApi.fetchOffers();
                              if (offerings.isEmpty) {
                                debugPrint('Error Fetching Prices');
                                Get.snackbar(
                                  'Something went wrong',
                                  'Please try again later.',
                                  colorText: Colors.white,
                                );
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                final packages = offerings
                                    .map((offer) => offer.availablePackages)
                                    .expand((pair) => pair)
                                    .toList();
                                await PurchaseApi.purchasePackage(packages[0]);
                                await Purchases.syncPurchases();
                                await SubscriptionController().fetchCustomerInfo();
                                setState(() {
                                  isLoading = false;
                                });
                                if(subscriptionController.entitlement.value == Entitlement.premium) {
                                   confettiController.play();
                                   await Future.delayed(const Duration(seconds: 3));
                                  Get.offAll(const HomeScreen());
                                }
                              }
                            },
                            child: Container(
                              width: width*0.8,
                              height: width*0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                    colors: [Color(0xffB3FFAB), Color(0xff12FFF7)]
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Image.asset('assets/images/gift-icon.png', width: width*0.095, height: width*0.095),
                                  ),
                                  Text(' Try 3 Days Free', style: TextStyle(fontFamily: 'SF-Compact', fontWeight: FontWeight.w800, fontSize: width*0.05, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width*0.08),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                    },
                                    child: Text('Privacy', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.0333))),
                                GestureDetector(
                                    onTap: (){
                                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                      openUrl(link: 'https://www.WhatZodiacSignIsThis.com/terms');
                                    },
                                    child: Text('Terms', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.0333))),
                                GestureDetector(
                                    onTap: () async{
                                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await subscriptionController.restorePurchases();
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    child: Text('Restore', style: TextStyle(fontFamily: 'AvenirNext', color: Colors.white, fontWeight: FontWeight.w500, fontSize: width*0.0333))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                width: width,
                height: height,
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator(color: Colors.white)),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirection: 3.14 / 2,
                // downwards
                emissionFrequency: 1,
                numberOfParticles: 20,
                gravity: 0.5,
                shouldLoop: false,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 10,
                minBlastForce: 5,
              ),
            ),
          ],
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

class FeaturesRow extends StatelessWidget {
  const FeaturesRow({super.key, required this.label, required this.iconPath, required this.iconSize});

  final String iconPath;
  final String label;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 6, left: width*0.1),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: EdgeInsets.only(left: width*0.12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: Center(
                  child: Image.asset(iconPath,
                      width: iconSize,
                      ),
                ),
              ),
              const SizedBox(width: 10),
              Text(label,
                  style: TextStyle(
                      fontFamily: "SF-Compact",
                      fontWeight: FontWeight.w900,
                      color: const Color(0xffffffff),
                      fontSize: MediaQuery.of(context).size.width * 0.038))
            ],
          ),
        ),
      ),
    );
  }
}