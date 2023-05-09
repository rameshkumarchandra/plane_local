import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: constant_identifier_names
const APP_FONT = 'Lexend';

enum FontStyle {
  heading,
  heading2,
  subheading,
  title,
  subtitle,
  boldTitle,
  boldSubtitle,
  appbarTitle,
  buttonText,
}

// ignore: non_constant_identifier_names
Color APP_TEXT_GREY = const Color.fromRGBO(135, 135, 135, 1);

class CustomText extends StatelessWidget {
   CustomText(
    this.text, {
    this.maxLines,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign= TextAlign.center,
    this.type = FontStyle.title,
    final Key? key,
  }) : super(key: key);
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final FontStyle? type;

  @override
  Widget build(BuildContext context) {
    var style = getStyle(type);

    return Text(
      text.toString(),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: style.merge(style),
    );
  }

  TextStyle getStyle(FontStyle? type) {
    switch (type) {
      case FontStyle.heading:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 22,
            color: color ?? Colors.black,
            letterSpacing: 0.8,
            fontWeight: fontWeight ?? FontWeight.bold);
      case FontStyle.heading2:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 19,
            color: color ?? Colors.black,
            letterSpacing: 0.8,
            fontWeight: fontWeight ?? FontWeight.bold);
      case FontStyle.title:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 16,
            color: color ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.w500);
      case FontStyle.subheading:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 18,
            color: color ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.w500);
      case FontStyle.boldTitle:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 18,
            color: color ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.bold);
      case FontStyle.subtitle:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 14,
            color: color ?? const Color(0xff222222),
            fontWeight: fontWeight ?? FontWeight.normal);
      case FontStyle.boldSubtitle:
        return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 16,
            color: color ?? const Color(0xff222222),
            fontWeight: fontWeight ?? FontWeight.bold);
     case FontStyle.buttonText:
      return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 17,
            color: color ??  Colors.white,
            fontWeight: fontWeight ?? FontWeight.w500); 
      case FontStyle.appbarTitle:
      return GoogleFonts.getFont(APP_FONT).copyWith(
            fontSize: fontSize ?? 18,
            color: color ?? const Color(0xff222222),
            fontWeight: fontWeight ?? FontWeight.bold); 
      default:
        return GoogleFonts.getFont(APP_FONT).copyWith(
          color: color ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 17,
        );
    }
  }
}
