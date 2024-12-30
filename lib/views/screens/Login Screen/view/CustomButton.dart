import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? color;

  CustomButton(
      {required this.text,
      required this.onTap,
      this.height,
      this.width,
      this.textStyle,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? 400,
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: color ?? Color.fromARGB(255, 69, 138, 217),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                GoogleFonts.poppins().copyWith(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
