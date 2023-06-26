import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = const Color(0xffFFFFFF);
Color purpleColor = const Color(0xff8000FF);
Color pinkColor = const Color(0xffFF1F8A);
Color backgroundColor = const Color(0xff1E2126);
Color backgroundBlackColor = const Color(0xff303243);
Color backgroundInput = const Color(0xff3A3F47);
Color orangColor = const Color(0xffFF8700);
Color grayColor = const Color(0xff67686D);
Color blueColor = const Color(0xff0296E5);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);

TextStyle grayTextStyle = GoogleFonts.poppins(
  color: grayColor,
);

TextStyle blueTextStyle = GoogleFonts.poppins(
  color: blueColor,
);

TextStyle orangTextStyle = GoogleFonts.poppins(
  color: orangColor,
);

List<Shadow> shadow = [
  Shadow(
    color: backgroundInput,
    offset: const Offset(2, 2),
    blurRadius: 4,
  ),
];
