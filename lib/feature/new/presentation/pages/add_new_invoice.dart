import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/new/presentation/widgets/build_custom_dropdown.dart';
import 'package:final_ibilling/feature/new/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../contracts/presentation/widgets/app_circle_avatar.dart';

class AddNewInvoice extends StatefulWidget {
  const AddNewInvoice({super.key});

  @override
  State<AddNewInvoice> createState() => _AddNewInvoiceState();
}

class _AddNewInvoiceState extends State<AddNewInvoice> {
  TextEditingController invoiceName = TextEditingController();
  TextEditingController invoicePrice = TextEditingController();
  String invoiceStatus = "";
  bool statusSelected = false;

  @override
  void dispose() {
    invoiceName.dispose();
    invoicePrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const AppCircleAvatar(),
        title: Text("New invoice", style: context.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            Text("Invocie name", style: context.titleMedium?.copyWith(color: AppColors.grayDarkest)),
            TFWidget(controller: invoiceName),

            10.verticalSpace,
            Text("Invocie price", style: context.titleMedium?.copyWith(color: AppColors.grayDarkest)),
            TFWidget(controller: invoicePrice),

            10.verticalSpace,
            Text("Invocie status", style: context.titleMedium?.copyWith(color: AppColors.grayDarkest)),
            BuildCustomDropdown(
              selectedValue: invoiceStatus,
              selected: statusSelected,
              onChanged: (String? value) {
                setState(() {
                  invoiceStatus = value ?? "";
                  statusSelected = true;
                });
              },
              items: [
                _buildDropdownItem("Paid", invoiceStatus == "Paid"),
                _buildDropdownItem("In Progress", invoiceStatus == "In Progress"),
                _buildDropdownItem("Reject By IQ", invoiceStatus == "Reject By IQ"),
                _buildDropdownItem("Reject By Payme", invoiceStatus == "Reject By Payme"),
              ],
              statusValue: invoiceStatus,
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(String text, bool isSelected) => DropdownMenuItem(
        value: text,
        child: Row(
          children: [
            Text(text, style: const TextStyle(color: Colors.white)),
            const Spacer(),
            isSelected ? const Icon(Icons.done_all) : const SizedBox.shrink(),
          ],
        ),
      );
}
