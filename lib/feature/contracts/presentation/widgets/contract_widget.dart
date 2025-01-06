import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:flutter/material.dart';
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
  late String paymentTypeText;

  @override
  void initState() {
    selectType(widget.model.status);
    super.initState();
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
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
                        SvgPicture.asset(
                          "assets/icons/number.svg",
                          width: 30,
                          height: 30,
                          colorFilter: const ColorFilter.mode(Color(0xffE7E7E7), BlendMode.modulate),
                        ),
                        Text(
                          widget.model.numberOfInvoice,
                          // style: context.textTheme.bodyMedium?.copyWith( color: const Color(0xffE7E7E7), fontSize: 19),
                        )
                      ],
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: paymentTypeColor.withOpacity(0.3)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 3),
                          child: Text(
                            paymentTypeText,
                            // style: context.textTheme.bodyMedium?.copyWith(
                            //   color: paymentTypeColor,
                            // ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${"fish".tr()} ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7))),
                    Text(widget.model.author, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff999999))),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${"amount".tr()} ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7))),
                    Text(widget.model.amount, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff999999))),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${"lastInvoice".tr()} ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7))),
                    Text("No ${widget.model.lastInvoice}",
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
                        Text(
                          "${"numInvoice".tr()} ",
                          // style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xffE7E7E7)),
                        ),
                        Text(
                          widget.model.numberOfInvoice,
                          // style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff999999)),
                        ),
                      ],
                    ),
                    Text(
                      widget.model.dateTime,
                      // style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xff999999)),
                    ),
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
