import 'package:flutter/material.dart';

class CorrectAnswerDialog {
  static bool isDialogShown = false;

  CorrectAnswerDialog();

  static void showResponseDialog(BuildContext context, String signImage) {
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
                height: width*0.95,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: width*0.8,
                          height: width*0.8,
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
                            child: Image.asset('assets/images/check-icon.png', width: width*0.08),
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
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [Color(0xff2AF598), Color(0xff009EFD)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            child: Text(
                              "Nice Work!",
                              style: TextStyle(
                                  fontFamily: "Cherry",
                                  fontSize: MediaQuery.of(context).size.width * 0.11,
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.06, top: width*0.03),
                            child: Image.asset('assets/images/clapping.png', width: width*0.26,
                            ),
                          )
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
