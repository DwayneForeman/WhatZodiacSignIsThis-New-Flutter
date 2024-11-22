import 'package:flutter/material.dart';

class IncorrectAnswerDialog {
  static bool isDialogShown = false;

  IncorrectAnswerDialog();

  static void showResponseDialog({required BuildContext context, required String signImage, required String answer, required String description}) {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: PopScope(
              canPop: false,
              child: SizedBox(
                height: width*0.9,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: width*0.8,
                          height: width*0.75,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Center(
                        child: Container(
                          width: width*0.32,
                          height: width*0.32,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.03),
                                    offset: const Offset(0, 3)
                                )
                              ]
                          ),
                          child: Center(
                            child: Image.asset('assets/images/close-icon.png', width: width*0.08),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: width*0.24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(signImage,
                              width: width*0.16),
                          const SizedBox(height: 10),
                          Text('$answer are ...', style: TextStyle(fontFamily: 'SF-Compact', color: const Color(0xffFF0909), fontSize: width*0.0666, fontWeight: FontWeight.w900)),
                          const SizedBox(height: 20),
                          Text(description, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'SFProText', color: const Color(0xff343434), fontSize: width*0.05, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
