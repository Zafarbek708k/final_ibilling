



import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

class NumberKeyboardWidget extends StatelessWidget {
  final void Function(String) onKeyPressed;
  final void Function() onBackspacePressed;
  final void Function() onFingerPrintPressed;

  const NumberKeyboardWidget({
    super.key,
    required this.onKeyPressed,
    required this.onFingerPrintPressed,
    required this.onBackspacePressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'F', '0', 'X'];

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      itemCount: keys.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 2,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return MaterialButton(
          minWidth: 20,
          height: 20,
          onPressed: key == 'X' ? onBackspacePressed : key == 'F' ? onFingerPrintPressed : () => onKeyPressed(key),
          color: AppColors.greenDark.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          child: key == 'X' ? const Icon(Icons.backspace_outlined) : key == 'F' ? const Icon(Icons.fingerprint) : Text(key),
        );
      },
    );
  }
}