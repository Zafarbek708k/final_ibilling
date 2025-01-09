import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/saved/presentation/bloc/saved_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../contracts/presentation/widgets/loading_state_widget.dart';
import 'saved_success_ui.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
            return SavedSuccessStateWidget(savedContracts: state.savedContracts, fullContractList: state.contracts);
          } else if (state.status == SavedStateStatus.init) {
            return const LoadingStateWidget();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
