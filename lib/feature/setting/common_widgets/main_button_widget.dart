import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';

import '../../../assets/colors/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.paddingL,
      this.paddingR,
      this.paddingT,
      this.paddingB,
      this.height,
      required this.bcgC,
      this.textC,
      this.radius,
      this.minWith,
      required this.select});

  final VoidCallback onPressed;
  final String title;
  final double? paddingL, paddingR, paddingT, paddingB, height, radius, minWith;
  final Color? bcgC, textC;
  final bool select;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingL ?? 0, right: paddingR ?? 0, top: paddingT ?? 0, bottom: paddingB ?? 0),
      child: MaterialButton(
        color: select ? bcgC : Colors.transparent,
        height: height ?? 37,
        minWidth: minWith ?? 75,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Center(child: Text(title, style: context.titleMedium?.copyWith(color: textC ?? AppColors.white))),
        ),
      ),
    );
  }
}
