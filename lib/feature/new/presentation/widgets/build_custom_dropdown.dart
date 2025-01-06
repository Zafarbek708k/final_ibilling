


import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BuildCustomDropdown extends StatelessWidget {
  const BuildCustomDropdown({
    super.key,
    this.selectedValue,
    required this.onChanged,
    required this.items,
    this.statusValue,
    required this.selected,
  });

  final String? selectedValue, statusValue;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>> items;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        barrierColor: Colors.black.withOpacity(0.6),
        isExpanded: true,
        barrierDismissible: false,
        selectedItemBuilder: (context) => List.generate(
          items.length,
              (index) => LeftAlignment(statusValue: statusValue), // Ensure LeftAlignment is defined
        ),
        items: items,
        value: selected ? selectedValue : null,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: selected ? Colors.blueGrey : Colors.grey.shade400,
              width: 2,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey,
          ),
          offset: const Offset(0, -2),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}


class LeftAlignment extends StatelessWidget {
  const LeftAlignment({super.key, this.statusValue});

  final String? statusValue;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft, child: Text(statusValue ?? "Select", style: const TextStyle(color: Colors.white)));
  }
}