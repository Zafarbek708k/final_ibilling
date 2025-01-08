


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyUI extends StatelessWidget {
  const EmptyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 250),
        SvgPicture.asset("assets/icons/empty_saved.svg"),
        const SizedBox(height: 10),
        const Text("No saved contracts", style: TextStyle(color: Color(0xffE7E7E7)))
      ],
    );
  }
}