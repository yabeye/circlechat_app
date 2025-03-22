import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.width,
    this.height,
    this.padding,
  });

  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: padding,
          // ??    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          text,
          // style: GoogleFonts.poppins(
          //   fontSize: fontSize ?? 13,
          //   fontWeight: FontWeight.w600,
          // ),
        ),
      ),
    );
  }
}
