import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LangUi extends StatelessWidget {
  const LangUi({super.key, required this.locale});

  final String locale;

  @override
  Widget build(BuildContext context) {
    String title = "", icon = '';
    if (locale == "uz") {
      title = "O'zbek (Lotin)";
      icon = "assets/icons/uz.svg";
    }
    if (locale == "ru") {
      title = "Russian";
      icon = "assets/icons/ru.svg";
    }
    if (locale == "en") {
      title = "English (USA)";
      icon = "assets/icons/en.svg";
    }
    return Row(
      children: [
        Text(title, style: context.headlineMedium),
        const Spacer(),
        Container(
          height: 50,
          margin: const EdgeInsets.only(top: 6),
          child: SvgPicture.asset(icon, fit: BoxFit.cover),
        )
      ],
    );
  }
}
