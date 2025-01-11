


import 'package:flutter/material.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../setting/common_widgets/main_button_widget.dart';

class SaveAndDeleteButton extends StatelessWidget {
  const SaveAndDeleteButton({super.key, required this.save, required this.delete});

  final VoidCallback save, delete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MainButton(
            onPressed: delete,
            title: "Delete contract",
            bcgC: Colors.red.withOpacity(0.3),
            textC: Colors.red,
            select: true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MainButton(
            onPressed: save,
            title: "Save contract",
            bcgC: AppColors.greenDark.withOpacity(0.3),
            textC: AppColors.greenDark,
            select: true,
          ),
        ),
      ],
    );
  }
}