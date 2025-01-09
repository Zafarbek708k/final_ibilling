
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../assets/colors/app_colors.dart';


class ContractCard extends StatelessWidget {
  const ContractCard({
    super.key,
    required this.author,
    required this.status,
    required this.amount,
    required this.lastInvoice,
    required this.numberOfInvoice,
    required this.address,
    required this.inn,
    required this.date,
  });

  final String author, status, amount, lastInvoice, numberOfInvoice, address, inn, date;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.darkGray,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text("Fisher's full name: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text("$author ", style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Wrap(
              children: [
                Text("Status of the contract: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text("$status ", style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("Amount: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text(amount, style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("Last invoice ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text(lastInvoice, style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("Number of invoice ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text(numberOfInvoice, style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Wrap(
              children: [
                Text("Address of the organization: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text(address, style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("ITN/IEC of the organization: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text(inn, style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
            5.verticalSpace,
            Row(
              children: [
                Text("Created at: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                Text(date, style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
