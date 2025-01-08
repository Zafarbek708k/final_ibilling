

import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/single.dart';
import 'package:final_ibilling/feature/saved/presentation/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../contracts/presentation/widgets/contract_widget.dart';
import '../widgets/empty_ui.dart';

class SavedSuccessStateWidget extends StatelessWidget {
  const SavedSuccessStateWidget({super.key, required this.contracts});

  final List<ContractEntity> contracts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<SavedBloc>().loadData();
        },
        child: ListView(
          children: [
            (contracts.isEmpty) ? const EmptyUI() : const SizedBox.shrink(),
            ...List.generate(
              contracts.length,
                  (index) {
                final model = contracts[index];
                return ContractWidget(
                  key: UniqueKey(),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Single(entity: model, fullContracts: contracts))),
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