import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:whatsignisthis/screens/how_to_play.dart';
import 'package:whatsignisthis/utils/open_url.dart';

import '../utils/audio_services.dart';

void openMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(40), topLeft: Radius.circular(40)),
    ),
    context: context,
    builder: (BuildContext context) {
      return const MenuBottomSheet();
    },
  );
}

class MenuBottomSheet extends StatefulWidget {
  const MenuBottomSheet({super.key});

  @override
  State<MenuBottomSheet> createState() => _MenuBottomSheetState();
}

class _MenuBottomSheetState extends State<MenuBottomSheet> {

  final AudioService audioService = AudioService();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff9B51E0), Color(0xff2575FC)]),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuRow(
                    onClick: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      Get.back();
                    },
                    title: "Home",
                    iconPath: "assets/images/home-icon.png",
                    iconSize: 28),
                // MenuRow(
                //     onClick: (){
                //       audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                //     },
                //     title: "Notifications",
                //     iconPath: "assets/images/notification-icon.png",
                //     iconSize: 29),
                MenuRow(
                    onClick: () async{
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      await precacheImage(const AssetImage("assets/images/how-to-play-bg.png"), context);
                      Get.off(const HowToPlay());
                    },
                    title: "How To Play",
                    iconPath: "assets/images/how-to-play-icon.png",
                    iconSize: 27),
                MenuRow(
                    onClick: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      openUrl(link: 'https://apps.apple.com/us/app/what-zodiac-sign-is-this-quiz/id6468937334');
                    },
                    title: "Rate Us",
                    iconPath: "assets/images/star-icon.png",
                    iconSize: 28),
                MenuRow(
                    onClick: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      Share.share('LMFAO! This app is JOKES! https://apps.apple.com/us/app/what-zodiac-sign-is-this-quiz/id6468937334');
                    },
                    title: "Share App",
                    iconPath: "assets/images/share-app-icon.png",
                    iconSize: 28),
                MenuRow(
                    onClick: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                    },
                    title: "Restore Purchase",
                    iconPath: "assets/images/restore-purchase-icon.png",
                    iconSize: 29),
                MenuRow(
                    onClick: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      openUrl(link: 'https://www.WhatZodiacSignIsThis.com/terms');
                    },
                    title: "Terms Of Service",
                    iconPath: "assets/images/terms-of-service-icon.png",
                    iconSize: 27),
                MenuRow(
                    onClick: (){
                      audioService.playSound(audioPath: 'assets/sounds/button-press.mpeg');
                      openUrl(link: 'https://www.WhatZodiacSignIsThis.com/contact');
                    },
                    title: "Contact Us",
                    iconPath: "assets/images/contact-us-icon.png",
                    iconSize: 27),
              ],
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

class MenuRow extends StatelessWidget {
  const MenuRow(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.iconSize,
      this.onClick});

  final String iconPath;
  final String title;
  final double iconSize;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onClick,
        child: Row(
          children: [
            SizedBox(
                width: 40,
                height: 40,
                child: Center(
                    child: Image.asset(iconPath,
                        width: iconSize, height: iconSize))),
            const SizedBox(width: 12),
            Text(title,
                style: const TextStyle(
                    fontFamily: "SF-Compact",
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
