import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/loading_state_widget.dart';
import 'package:final_ibilling/feature/history/presentation/bloc/history_bloc.dart';
import 'package:final_ibilling/feature/history/presentation/widgets/data_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../contracts/presentation/pages/filter_page.dart';
import '../../../contracts/presentation/pages/search_page.dart';
import '../../../contracts/presentation/widgets/app_circle_avatar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const AppCircleAvatar(),
        title: Text("History", style: context.titleLarge),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FilterPage())),
            icon: SvgPicture.asset("assets/icons/Filter.svg"),
          ),
          const Text("|", style: TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
            icon: const Icon(Icons.search, color: AppColors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 10),
            child: Align(alignment: Alignment.topLeft, child: Text("Date", style: context.bodyMedium)),
          ),
          Expanded(
            child: BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                if (state.status == HistoryStateStatus.loading) {
                  return const LoadingStateWidget();
                } else if (state.status == HistoryStateStatus.error) {
                  return ErrorStateWidget(errorMsg: state.errorMsg);
                } else if (state.status == HistoryStateStatus.loaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              DateBox(
                                label: "Start Time",
                                date: state.startTime,
                                onDateSelected: (data) {
                                  context.read<HistoryBloc>().add(StartTimeEvent(startTime: DateTime(data.year, data.month, data.day)));
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.0),
                                child: Icon(Icons.remove, color: Colors.white),
                              ),
                              DateBox(
                                label: "End Time",
                                date: state.endTime,
                                onDateSelected: (date) {
                                  context.read<HistoryBloc>().add(EndTimeEvent(endTime: DateTime(date.year, date.month, date.day)));
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: HistorySuccessWidget(contracts: state.filteredList.isEmpty ? state.contracts : state.filteredList)),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HistorySuccessWidget extends StatelessWidget {
  const HistorySuccessWidget({super.key, required this.contracts});

  final List<ContractEntity> contracts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HistoryBloc>().init();
      },
      child: ListView(
        children: [
          ...List.generate(
            contracts.length,
            (index) {
              final model = contracts[index];
              return ContractWidget(onTap: () {}, model: model);
            },
          )
        ],
      ),
    );
  }
}
