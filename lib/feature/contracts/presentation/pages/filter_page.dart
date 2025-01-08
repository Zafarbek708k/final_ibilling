import 'dart:developer';

import 'package:final_ibilling/feature/contracts/presentation/bloc/contract_bloc.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/contract_page.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/check_box_custom.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/loading_state_widget.dart';
import 'package:final_ibilling/feature/history/presentation/widgets/data_select.dart';
import 'package:final_ibilling/feature/main_wrapper/main_wrap.dart';
import 'package:final_ibilling/feature/setting/common_widgets/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late bool paid, inProcess, rejectByIQ, rejectByPayme;

  @override
  void initState() {
    paid = context.read<ContractBloc>().state.paid;
    inProcess = context.read<ContractBloc>().state.inProcess;
    rejectByIQ = context.read<ContractBloc>().state.rejectByIQ;
    rejectByPayme = context.read<ContractBloc>().state.rejectByPayme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Filters"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Status"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckBox(selected: paid, text: "Paid", onTap: () => setState((){ paid = !paid;})),
                    CustomCheckBox(selected: rejectByIQ, text: "Rejected by IQ", onTap: () => setState((){rejectByIQ = !rejectByIQ;})),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCheckBox(selected: inProcess, text: "In Precess", onTap: () => setState((){inProcess = !inProcess;})),
                    CustomCheckBox(selected: rejectByPayme, text: "Rejected by Payment", onTap: () => setState((){rejectByPayme = !rejectByPayme;})),
                  ],
                )
              ],
            ),
            20.verticalSpace,
            const Text("Date"),
            10.verticalSpace,
            BlocBuilder<ContractBloc, ContractState>(
              builder: (context, state) {
                if(state.status == ContractStateStatus.loading){
                  return const LoadingStateWidget();
                }
                if(state.status == ContractStateStatus.error){
                  return ErrorStateWidget(errorMsg: state.errorMsg);
                }
                if(state.status == ContractStateStatus.loaded){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        DateBox(
                          label: "Start Time",
                          date: state.beginDate,
                          onDateSelected: (date) {
                            log("begin date ui year ${date.year} month= ${date.month} day = ${date.day}");
                            context.read<ContractBloc>().add(BeginDateSelectEvent(beginTime: DateTime(date.year, date.month, date.day)));
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                        DateBox(
                          label: "End Time",
                          date: state.endDate,
                          onDateSelected: (date) {
                            log("end date ui func year ${date.year} month= ${date.month} day = ${date.day}");
                            context.read<ContractBloc>().add(EndDateSelectEvent(endTime: DateTime(date.year, date.month, date.day)));
                          },
                        ),
                      ],
                    ),
                  );
                }
                if(state.status == ContractStateStatus.initial){
                  return const SizedBox.shrink();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainWrap()));
                    context.read<ContractBloc>().init();
                  },
                  title: "Cancel",
                  bcgC: const Color(0xff008F7F).withOpacity(0.5),
                  textC: const Color(0xff008F7F).withOpacity(0.8),
                  select: true,
                  height: 35,
                  minWith: 125),
              const SizedBox(width: 25),
              BlocBuilder<ContractBloc, ContractState>(
                builder: (context, state) {
                  return MainButton(
                    onPressed: () {
                      log("paid = $paid process = $inProcess rejectIq = $rejectByIQ reject payme => $rejectByPayme");

                      context.read<ContractBloc>().add(
                            ContractFilterEvent(
                              paid: paid,
                              process: inProcess,
                              rejectIq: rejectByIQ,
                              rejectPay: rejectByPayme,
                              end: state.endDate,
                              start: state.beginDate,
                            ),
                          );
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainWrap()));
                    },
                    title: "Apply Filters",
                    bcgC: const Color(0xff008F7F),
                    select: true,
                    height: 35,
                    minWith: 125,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
