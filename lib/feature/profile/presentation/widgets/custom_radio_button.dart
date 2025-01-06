import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRadioButton extends StatelessWidget {
  final bool selected;
  final VoidCallback? onTap;
  final String? text;
  final bool isDisabled;

  const CustomRadioButton({
    super.key,
    required this.selected,
    this.onTap,
    this.text,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isDisabled ? null : onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getIcon(),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                text!,
                style: TextStyle(
                  color: isDisabled ? const Color(0xFFD2D2D2) : const Color(0xFF090909),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getIcon() {
    if (isDisabled) {
      return SvgPicture.asset("assets/icons/selected_radio.svg");
    }
    if (selected) {
      return SvgPicture.asset("assets/icons/selected_radio.svg");
    }
    return SvgPicture.asset("assets/icons/unselect_radio.svg");
  }
}