import 'dart:developer';

import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/contract_loaded.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/filter_page.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/search_page.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/calendar.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/loading_state_widget.dart';
import 'package:final_ibilling/feature/main_wrapper/animated_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/contract_bloc.dart';

class ContractPage extends StatelessWidget {
  const ContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 4),
          child: CircleAvatar(backgroundColor: AppColors.darkGray, radius: 8),
        ),
        title: Text("Contracts", style: context.titleLarge),
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
          16.verticalSpace,
          // AnimatedThemeToggle(isDarkMode: true, onThemeToggle: (value){}),
          16.verticalSpace,
          BlocBuilder<ContractBloc, ContractState>(
            builder: (context, state) {
              return CustomCalendarWidget(
                onDateSelected: ({required DateTime date}) {
                  if (state.status == ContractStateStatus.loaded) {
                    context.read<ContractBloc>().add(SelectOneDayEvent(date: date));
                  }
                },
              );
            },
          ),
          10.verticalSpace,
          BlocBuilder<ContractBloc, ContractState>(
            builder: (context, state) {
              if (state.status == ContractStateStatus.loading) {
                return const LoadingStateWidget();
              }
              if (state.status == ContractStateStatus.error) {
                return ErrorStateWidget(errorMsg: state.errorMsg);
              }
              if (state.status == ContractStateStatus.initial) {
                return const Center(child: Text("load more item"));
              }
              if (state.status == ContractStateStatus.loaded) {
                return Expanded(child: ContractLoadedWidget(contracts: state.filteredList, key: UniqueKey(),));
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
