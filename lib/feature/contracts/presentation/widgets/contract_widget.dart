import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../assets/colors/app_colors.dart';

class ContractWidget extends StatefulWidget {
  const ContractWidget({super.key, required this.onTap, required this.model});

  final VoidCallback onTap;
  final ContractEntity model;

  @override
  State<ContractWidget> createState() => _ContractWidgetState();
}

class _ContractWidgetState extends State<ContractWidget> {
  late Color paymentTypeColor;
  late String paymentTypeText, dateTime;

  @override
  void initState() {
    selectType(widget.model.status);
    changeDate(date: widget.model.dateTime);
    super.initState();
  }

  Map<String, String> monthMap = {
    "January": "1",
    "February": "2",
    "March": "3",
    "April": "4",
    "May": "5",
    "June": "6",
    "July": "7",
    "August": "8",
    "September": "9",
    "October": "10",
    "November": "11",
    "December": "12",
  };

  void changeDate({required String date}) {
    List<String> parts = date.split(', ');
    String day = parts[1].split(' ')[0]; // 9
    String monthName = parts[1].split(' ')[1]; // January
    String year = parts[2]; // 2025
    String month = monthMap[monthName] ?? "0";
    dateTime = "${day.length < 2 ? "0$day" : day}.${month.length < 2 ? "0$month" : month}.$year";
  }

  void selectType(String type) {
    switch (type) {
      case "paid":
        {
          paymentTypeColor = AppColors.greenDark;
          paymentTypeText = "paid".tr();
        }
      case "inProgress":
        {
          paymentTypeColor = AppColors.yellow;
          paymentTypeText = "inProcess".tr();
        }
      case "rejectByPayme":
        {
          paymentTypeColor = AppColors.red;
          paymentTypeText = "rejectByPayme".tr();
        }
      case "rejectByIQ":
        {
          paymentTypeColor = AppColors.red;
          paymentTypeText = "rejectByIQ".tr();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(15),
        child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.darkGray),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/contract.svg"),
                        5.horizontalSpace,
                        Text(
                          "№\t${widget.model.numberOfInvoice}",
                          style: context.bodyLarge?.copyWith(color: const Color(0xffE7E7E7)),
                        )
                      ],
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: paymentTypeColor.withOpacity(0.3)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 3),
                        child: Text(
                          paymentTypeText,
                          style: context.bodyMedium?.copyWith(color: paymentTypeColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${"fish".tr()}\t", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7))),
                    Text(widget.model.author, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff999999))),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${"amount".tr()}\t", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7))),
                    Text(widget.model.amount, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff999999))),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${"lastInvoice".tr()}\t", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7))),
                    Text("№ ${widget.model.lastInvoice}",
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff999999))),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${"numInvoice".tr()}\t"),
                        Text(widget.model.numberOfInvoice, style: context.bodyMedium?.copyWith(color: const Color(0xff999999)),),
                      ],
                    ),
                    Text(dateTime,  style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
