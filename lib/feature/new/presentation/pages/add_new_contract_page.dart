import 'dart:developer';

import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/new/presentation/bloc/add_new_contract_bloc.dart';
import 'package:final_ibilling/feature/new/presentation/widgets/text_field.dart';
import 'package:final_ibilling/feature/setting/common_widgets/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets/colors/app_colors.dart';
import '../widgets/build_custom_dropdown.dart';

class AddNewContractPage extends StatefulWidget {
  const AddNewContractPage({super.key});

  @override
  State<AddNewContractPage> createState() => _AddNewContractPageState();
}

class _AddNewContractPageState extends State<AddNewContractPage> {
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  late final TextEditingController innController = TextEditingController();
  late final FocusNode nameFocusNode;
  late final FocusNode addressFocusNode;
  late final FocusNode innFocusNode;
  String? personValue, statusValue;

  bool personValueSelected = false;
  bool statusValueSelected = false;

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    innFocusNode = FocusNode();
    personValue = null;
    statusValue = null;
    resetDropdownValues();
  }

  void resetDropdownValues() {
    setState(() {
      addressCtrl.clear();
      fNameCtrl.clear();
      innController.clear();
      personValue = null;
      statusValue = null;
      personValueSelected = false;
      statusValueSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 4),
          child: CircleAvatar(backgroundColor: AppColors.darkGray, radius: 8),
        ),
        title: Text("New contracts", style: context.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            10.verticalSpace,
            Text("Lico", style: context.titleMedium?.copyWith(color: AppColors.grayLighter)),
            BuildCustomDropdown(
              selectedValue: personValue,
              selected: personValueSelected,
              onChanged: (String? value) {
                setState(() {
                  personValue = value;
                  personValueSelected = true;
                });
              },
              items: [
                _buildDropdownItem("Jismoniy", personValue == "Jismoniy"),
                _buildDropdownItem("Yuridik", personValue == "Yuridik"),
              ],
              statusValue: personValue,
            ),
            10.verticalSpace,
            Text("Fresher's full name", style: context.titleMedium?.copyWith(color: AppColors.grayLighter)),
            TFWidget(controller: fNameCtrl),
            10.verticalSpace,
            Text("Address of the organization", style: context.titleMedium?.copyWith(color: AppColors.grayLighter)),
            TFWidget(controller: addressCtrl),
            10.verticalSpace,
            Text("Inn", style: context.titleMedium?.copyWith(color: AppColors.grayLighter)),
            TFWidget(controller: innController, type: TextInputType.number),
            10.verticalSpace,
            Text("Status of the contract", style: context.titleMedium?.copyWith(color: AppColors.grayLighter)),
            BuildCustomDropdown(
              selectedValue: statusValue,
              selected: statusValueSelected,
              onChanged: (String? value) {
                setState(() {
                  statusValue = value;
                  statusValueSelected = true;
                });
              },
              items: [
                _buildDropdownItem("Paid", statusValue == "Paid"),
                _buildDropdownItem("In Progress", statusValue == "In Progress"),
                _buildDropdownItem("Reject By IQ", statusValue == "Reject By IQ"),
                _buildDropdownItem("Reject By Payme", statusValue == "Reject By Payme"),
              ],
              statusValue: statusValue,
            ),
            20.verticalSpace,
            BlocBuilder<AddNewContractBloc, AddNewContractState>(
              builder: (context, state) {
                final status = statusValue == "Paid"
                    ? "paid"
                    : statusValue == "In Progress"
                        ? "inProgress"
                        : statusValue == "Reject By IQ"
                            ? "rejectByIQ"
                            : "rejectByPayme";
                return MainButton(
                  height: 55,
                  onPressed: () {
                    if (innController.text.isNotEmpty && fNameCtrl.text.isNotEmpty && addressCtrl.text.isNotEmpty) {
                      context.read<AddNewContractBloc>().add(
                            AddNewContractEvent(
                              status: status,
                              inn: innController.text.trim(),
                              address: addressCtrl.text.trim(),
                              context: context,
                              clear: resetDropdownValues,
                            ),
                          );
                    }
                  },
                  title: "Save Contract",
                  bcgC: innController.text.isEmpty && fNameCtrl.text.isEmpty && addressCtrl.text.isEmpty
                      ? AppColors.greenDark.withOpacity(0.4)
                      : AppColors.greenDark,
                  select: true,
                );
              },
            )
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
