import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  const AppCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff00FFC2), Color(0xff0500FF), Color(0xffFFC700), Color(0xffAD00FF), Color(0xff00FF94)],
            ),
          ),
        ),
      ),
    );
  }
}
