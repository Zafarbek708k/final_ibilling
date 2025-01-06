import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:final_ibilling/feature/saved/presentation/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../contracts/presentation/widgets/loading_state_widget.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 4),
          child: CircleAvatar(backgroundColor: AppColors.darkGray, radius: 8),
        ),
        title: Text("Saved", style: context.titleLarge),
      ),
      body: BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) {
          if (state.status == SavedStateStatus.loading) {
            return const LoadingStateWidget();
          } else if (state.status == SavedStateStatus.error) {
            return ErrorStateWidget(errorMsg: state.errorMsg);
          } else if (state.status == SavedStateStatus.loaded) {
            return SavedSuccessStateWidget(contracts: state.contractEntity);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class SavedSuccessStateWidget extends StatelessWidget {
  const SavedSuccessStateWidget({super.key, required this.contracts});

  final List<ContractEntity> contracts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          ...List.generate(
            contracts.length,
            (index) {
              final model = contracts[index];
              return ContractWidget(onTap: (){}, model: model);
            },
          )
        ],
      ),
    );
  }
}
