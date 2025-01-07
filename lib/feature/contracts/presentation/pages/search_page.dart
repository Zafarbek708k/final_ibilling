import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/bloc/contract_bloc.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/loading_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkest,
        automaticallyImplyLeading: true,
        title: TextField(
          controller: _controller,
          onChanged: (value) => context.read<ContractBloc>().search(value),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: "Search...",
            border: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.darkGray)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.darkGray)),
            disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.darkGray)),
          ),
        ),
        actions: [IconButton(onPressed: () {
          _controller.clear();
          context.read<ContractBloc>().clear();
        }, icon: const Icon(Icons.clear, color: Colors.white))],
      ),
      body: BlocBuilder<ContractBloc, ContractState>(
        builder: (context, state) {
          if (state.status == ContractStateStatus.loading) {
            return const LoadingStateWidget();
          } else if (state.status == ContractStateStatus.error) {
            return ErrorStateWidget(errorMsg: state.errorMsg);
          } else if (state.status == ContractStateStatus.loaded) {
            return SearchLoadedUi(searchList: state.searchList.isEmpty ? state.fullContract : state.searchList);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class SearchLoadedUi extends StatelessWidget {
  const SearchLoadedUi({super.key, required this.searchList});

  final List<ContractEntity> searchList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          ...List.generate(
            searchList.length,
            (index) {
              final model = searchList[index];
              return ContractWidget(onTap: () {}, model: model);
            },
          )
        ],
      ),
    );
  }
}
