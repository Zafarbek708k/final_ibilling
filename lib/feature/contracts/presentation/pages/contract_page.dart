import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/filter/presentation/pages/filter_page.dart';
import 'package:final_ibilling/feature/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/contract_bloc.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 4),
          child: CircleAvatar(backgroundColor: AppColors.darkGray, radius: 8),
        ),
        title: Text("Contracts", style: context.titleLarge),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterPage())),
            icon: SvgPicture.asset("assets/icons/Filter.svg"),
          ),
          const Text("|", style: TextStyle(color: Colors.white, fontSize: 20)),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
            icon: const Icon(Icons.search, color: AppColors.white),
          ),
        ],
      ),
      body: BlocBuilder<ContractBloc, ContractState>(
        builder: (context, state) {
          return Column(
            children: [
            ],
          );
        },
      ),
    );
  }
}
