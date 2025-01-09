import 'dart:developer';

import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/saved/presentation/bloc/saved_bloc.dart';
import 'package:final_ibilling/feature/saved/presentation/pages/single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contracts/presentation/widgets/contract_widget.dart';
import '../widgets/empty_ui.dart';

class SavedSuccessStateWidget extends StatelessWidget {
  const SavedSuccessStateWidget({super.key, required this.savedContracts, required this.fullContractList});

  final List<ContractEntity> savedContracts;
  final List<ContractEntity> fullContractList;

  @override
  Widget build(BuildContext context) {
    log("full contract list => ${fullContractList.length} && saved contract list => ${savedContracts.length}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<SavedBloc>().loadData();
        },
        child: ListView(
          children: [
            (savedContracts.isEmpty) ? const EmptyUI() : const SizedBox.shrink(),
            ...List.generate(
              savedContracts.length,
              (index) {
                final model = savedContracts[index];
                return ContractWidget(
                  key: UniqueKey(),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Single(contract: model, contracts: fullContractList))),
                  model: model,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
