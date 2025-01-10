import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/bloc/contract_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../assets/colors/app_colors.dart';
import '../../../../core/utils/utils_service.dart';
import '../../../contracts/presentation/widgets/contract_widget.dart';
import '../../../contracts/presentation/widgets/loading_state_widget.dart';
import '../../../setting/common_widgets/main_button_widget.dart';
import '../bloc/saved_bloc.dart';
import '../widgets/single_contract_card_widget.dart';

class Single extends StatefulWidget {
  const Single({super.key, required this.contract, required this.contracts});

  final ContractEntity contract;
  final List<ContractEntity> contracts;

  @override
  State<Single> createState() => _SaveDetailState();
}

class _SaveDetailState extends State<Single> {
  String number = "", paymentStatus = '';
  bool saved = false;
  List<ContractEntity> authorList = [];

  @override
  void initState() {
    saved = widget.contract.saved;
    number = widget.contract.lastInvoice;
    selectType(widget.contract.status);
    checkAuthorList(list: widget.contracts, name: widget.contract.author);
    super.initState();
  }

  void checkAuthorList({required List<ContractEntity> list, required String name}) {
    authorList = list.where((contract) => name == contract.author).toList();
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
                if (saved == true && widget.contract.author == "Zafarbek Karimov") {
                  saved = false;
                  debugPrint("Un Save UI");
                  context.read<SavedBloc>().add(UnSave(contract: widget.contract));
                } else if (saved == false && widget.contract.author == "Zafarbek Karimov") {
                  debugPrint("Save in UI");
                  saved = true;
                  context.read<SavedBloc>().add(Save(contract: widget.contract));
                } else {
                  Utils.fireSnackBar("This Data does not belong to you", context);
                }
                context.read<ContractBloc>().add(ReloadEvent());
                setState(() {});
              },
              icon: SvgPicture.asset("assets/icons/outline_save.svg", color: saved ? Colors.white : Colors.grey)),
          const SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            10.verticalSpace,
            ContractCard(
              author: widget.contract.author,
              status: paymentStatus,
              amount: widget.contract.amount,
              lastInvoice: widget.contract.lastInvoice,
              numberOfInvoice: widget.contract.numberOfInvoice,
              address: widget.contract.addressOrganization,
              inn: widget.contract.innOrganization,
              date: widget.contract.dateTime,
            ),
            10.verticalSpace,
            BlocBuilder<SavedBloc, SavedState>(
              builder: (context, state) {
                if (state.status == SavedStateStatus.loading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: LinearProgressIndicator()),
                  );
                } else if (state.status == SavedStateStatus.error) {
                  return ErrorStateWidget(errorMsg: state.errorMsg);
                } else if (state.status == SavedStateStatus.loaded) {
                  return SaveAndDeleteButton(
                    save: () {
                      if (saved == false && widget.contract.author == "Zafarbek Karimov") {
                        context.read<SavedBloc>().add(Save(contract: widget.contract));
                        context.read<ContractBloc>().add(ReloadEvent());
                        setState(() => saved = true);
                      } else {
                        Utils.fireSnackBar("Already saved this data or This Data does not belong to you", context);
                      }
                    },
                    delete: () {
                      if (widget.contract.author == "Zafarbek Karimov") {
                        context.read<SavedBloc>().add(Delete(contract: widget.contract, context: context));
                        context.read<ContractBloc>().add(ReloadEvent());
                        Timer(const Duration(milliseconds: 200), () => Navigator.pop(context));
                      } else {
                        Utils.fireSnackBar("You can not delete others contracts", context);
                      }
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            10.verticalSpace,
            Align(
              alignment: Alignment.topLeft,
              child: Text("Other contracts with \n \t \t \t ${widget.contract.author}", key: UniqueKey()),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView(
                key: UniqueKey(),
                children: [
                  ...List.generate(
                    authorList.length,
                    (index) {
                      final model = authorList[index];
                      return ContractWidget(key: ValueKey(authorList[index]), onTap: () {}, model: model);
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

class SaveAndDeleteButton extends StatelessWidget {
  const SaveAndDeleteButton({super.key, required this.save, required this.delete});

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
