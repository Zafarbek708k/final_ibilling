import 'dart:ui';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../setting/common_widgets/main_button_widget.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key, required this.controller, required this.done});

  final TextEditingController controller;
  final VoidCallback done;

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  String text = '';

  @override
  void initState() {
    text = widget.controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: AppColors.darkGray,
        title: Align(
          alignment: Alignment.center,
          child: Text("Leave a comment, why are you deleting this contract?", textAlign: TextAlign.center, style: context.bodyMedium),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 45,
              child: TextField(
                controller: widget.controller,
                onChanged: (value) => setState(() => text = value),
                decoration: InputDecoration(
                  hintText: 'Type a comment',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  filled: true,
                  fillColor: AppColors.grayShadow,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            16.verticalSpace,
            text.isEmpty
                ? const SizedBox.shrink()
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainButton(
                  onPressed: () => Navigator.pop(context),
                  title: "\t\t\tCancel\t\t\t",
                  bcgC: AppColors.red.withOpacity(0.2),
                  select: true,
                  textC: AppColors.red,
                ),
                const Spacer(),
                MainButton(onPressed: widget.done, title: "\t\t\t\tDone\t\t\t\t", bcgC: AppColors.red, select: true),
              ],
            )
          ],
        ),
      ),
    );
  }
}