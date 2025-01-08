import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../../core/utils/utils_service.dart';
import '../../../setting/common_widgets/main_button_widget.dart';
import '../bloc/contract_bloc.dart';

class Single extends StatefulWidget {
  const Single({super.key, required this.entity, required this.fullContracts});

  final ContractEntity entity;
  final List<ContractEntity> fullContracts;

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  String number = "", paymentStatus = '';
  bool saved = false;
  List<ContractEntity> authorList = [];

  @override
  void initState() {
    saved = widget.entity.saved;
    number = widget.entity.lastInvoice;
    selectType(widget.entity.status);
    checkAuthorList(list: widget.fullContracts, name: widget.entity.author);
    super.initState();
  }

  void checkAuthorList({required List<ContractEntity> list, required String name}) {
    authorList = list.where((contract) => name.toLowerCase() == contract.author.toLowerCase()).toList();
  }

  void selectType(String type) {
    switch (type) {
      case "paid":
        paymentStatus = "paid".tr();
      case "inProgress":
        paymentStatus = "inProcess".tr();
      case "rejectByPayme":
        paymentStatus = "rejectByPayme".tr();
      case "rejectByIQ":
        paymentStatus = "rejectByIQ".tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkest,
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/contract.svg"),
            4.horizontalSpace,
            SvgPicture.asset(
              "assets/icons/number.svg",
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(Color(0xffE7E7E7), BlendMode.modulate),
            ),
            4.horizontalSpace,
            Text(number, style: context.titleMedium?.copyWith(color: const Color(0xffE7E1E1), fontSize: 18))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.entity.saved == true && widget.entity.author == "Zafarbek Karimov") {
                  context.read<ContractBloc>().add(UnSaveContractEvent(contract: widget.entity));
                  Navigator.pop(context);
                } else if(widget.entity.saved == false && widget.entity.author == "Zafarbek Karimov"){
                  context.read<ContractBloc>().add(SaveContractEvent(contract: widget.entity));
                  Navigator.pop(context);
                }else{
                  Utils.fireSnackBar("This Data does not belong to you", context);
                }
              },
              icon: SvgPicture.asset("assets/icons/outline_save.svg", color: saved ? Colors.white : Colors.grey)),
          const SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
        child: Column(
          children: [
            ContractCard(
              author: widget.entity.author,
              status: paymentStatus,
              amount: widget.entity.amount,
              lastInvoice: widget.entity.lastInvoice,
              numberOfInvoice: widget.entity.numberOfInvoice,
              address: widget.entity.addressOrganization,
              inn: widget.entity.innOrganization,
              date: widget.entity.dateTime,
            ),
            10.verticalSpace,
            BlocBuilder<ContractBloc, ContractState>(
              builder: (context, state) {
                return SaveDelete(
                  save: () {
                    if (widget.entity.saved == false && widget.entity.author == "Zafarbek Karimov") {
                      context.read<ContractBloc>().add(SaveContractEvent(contract: widget.entity));
                      Navigator.pop(context);
                    } else {
                      Utils.fireSnackBar("Already saved this data or This Data does not belong to you", context);
                    }
                  },
                  delete: () async {
                    if (widget.entity.author == "Zafarbek Karimov") {
                      context.read<ContractBloc>().add(DeleteContractEvent(contract: widget.entity));
                      Navigator.pop(context);
                    } else {
                      Utils.fireSnackBar("This Data does not belong to you", context);
                    }
                  },
                );
              },
            ),
            10.verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: Text("Other contracts with \n ${"   ${widget.entity.author}"}"),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView(
                children: [
                  ...List.generate(
                    authorList.length,
                    (index) {
                      final model = authorList[index];
                      return ContractWidget(onTap: () {}, model: model);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaveDelete extends StatelessWidget {
  const SaveDelete({super.key, required this.save, required this.delete});

  final VoidCallback save, delete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MainButton(
            onPressed: delete,
            title: "Delete contract",
            bcgC: Colors.red.withOpacity(0.3),
            textC: Colors.red,
            select: true,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: MainButton(
            onPressed: save,
            title: "Save contract",
            bcgC: AppColors.greenDark.withOpacity(0.3),
            textC: AppColors.greenDark,
            select: true,
          ),
        ),
      ],
    );
  }
}

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
            Row(
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
