

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LangUi extends StatelessWidget {
  const LangUi({super.key, required this.locale});
  final String locale;
  @override
  Widget build(BuildContext context) {
    String title = "", icon = '';
    if(locale == "uz"){title = "Uzbek"; icon = "assets/icons/uz.svg";}
    if(locale == "ru"){title = "Russian"; icon = "assets/icons/ru.svg";}
    if(locale == "en"){title = "English"; icon = "assets/icons/en.svg";}
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ Text(title, style: const TextStyle(color: Color(0xff999999))), SvgPicture.asset(icon)],
    );
  }
}
