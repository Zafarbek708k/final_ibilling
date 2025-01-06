import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 4),
          child: CircleAvatar(backgroundColor: AppColors.darkGray, radius: 8),
        ),
        title: Text("History", style: context.titleLarge),
      ),
      body: const Center(
        child: Text("History", style: TextStyle(color: Colors.green)),
      ),
    );
  }
}
