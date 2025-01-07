import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCheckBox extends StatelessWidget {
  final bool selected;
  final VoidCallback? onTap;
  final String? text;

  const CustomCheckBox({
    super.key,
    required this.selected,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getIcon(),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                text!,
                style: context.titleMedium?.copyWith(
                  color: selected ? const Color(0xFFD2D2D2) : Colors.grey.shade700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getIcon() {
    if (selected) {
      return SvgPicture.asset("assets/icons/checkBox_selected.svg");
    }
    return SvgPicture.asset("assets/icons/checkBox_unselected.svg");
  }
}
