import 'package:flutter/material.dart';

@immutable
class AppColors {

  const AppColors._();

  // Basic Colors
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

  // Grays
  static const Color grayDarkest = Color(0xff4E4E4E);
  static const Color grayShadow = Color(0xff5C5C5C);
  static const Color grayDarker = Color(0xff999999);
  static const Color grayDark = Color(0xffA6A6A6);
  static const Color graySoft = Color(0xffC0C0C0);
  static const Color grayMedium = Color(0xffD1D1D1);
  static const Color grayLight = Color(0xffDADADA);
  static const Color grayLighter = Color(0xffF1F1F1);
  static const Color grayFDFDFD = Color(0xffFDFDFD);
  static const Color gray = Color(0xffE7E7E7);
  static const Color grayLightest = Color(0xffF2F2F2);

  // Opacities for Grays
  static const Color grayLightOpacity20 = Color.fromRGBO(166, 166, 166, 0.2);

  // Opacities for Dark
  static const Color darkLightOpacity80 = Color.fromRGBO(12, 12, 12, 0.8);

  // Dark Tones
  static const Color darkest = Color(0xff141416);
  static const Color darkDarker = Color(0xff1E1E20);
  static const Color darkGray = Color(0xff2A2A2D);

  // Greens
  static const Color greenDark = Color(0xff008F7F);
  static const Color greenLight = Color(0xff00A795);
  static const Color greenSoft = Color(0xff49B7A5);
  static const Color greenOpacity15 = Color.fromRGBO(73, 183, 165, 0.15);
  static const Color greenOpacity30 = Color.fromRGBO(0, 143, 127, 0.30);

  // Reds
  static const Color red = Color(0xffFF426D);
  static const Color redOpacity15 = Color.fromRGBO(248, 83, 121, 0.15);

  // Yellows
  static const Color yellow = Color(0xffFDAB2A);
  static const Color yellowOpacity15 = Color.fromRGBO(255, 171, 42, 0.15);
}
