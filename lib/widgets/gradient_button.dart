import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.width, this.onTap, required this.height, this.txtClr, required this.text, required this.btnClrs, this.textGradient, this.fontSize});
  final double width;
  final double height;
  final String text;
  final List<Color> btnClrs;
  final List<Color>? textGradient;
  final Color? txtClr;
  final double? fontSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              colors: btnClrs,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
          )
        ),
        child: Center(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: textGradient ?? [txtClr ?? Colors.black, txtClr ?? Colors.black],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: "SF-Compact",
                  fontSize: fontSize ?? 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
