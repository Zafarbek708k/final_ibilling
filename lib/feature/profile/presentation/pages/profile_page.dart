import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/loading_state_widget.dart';
import 'package:final_ibilling/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:final_ibilling/feature/profile/presentation/widgets/lang_ui.dart';
import 'package:final_ibilling/feature/profile/presentation/widgets/language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/colors/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 4),
          child: CircleAvatar(backgroundColor: AppColors.darkGray, radius: 8),
        ),
        title: Text("Profile", style: context.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const UserCardWidget(),
            const SizedBox(height: 10),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.status == ProfileStateStatus.init) {
                  return MaterialButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => LangSelect(locale: state.locale));
                    },
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.darkGray,
                    child: LangUi(locale: state.locale),
                  );
                }
                if (state.status == ProfileStateStatus.loaded) {
                  return MaterialButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => LangSelect(locale: state.locale));
                    },
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.darkGray,
                    child: LangUi(locale: state.locale),
                  );
                }
                if (ProfileStateStatus.loading == state.status) {
                  return const LoadingStateWidget();
                }
                if (state.status == ProfileStateStatus.error) {
                  return ErrorStateWidget(errorMsg: state.errorMsg);
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.darkGray),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 10),
                  const CircleAvatar(backgroundColor: AppColors.darkest, child: Icon(Icons.person, color: Colors.white)),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Otabek Abdusamatov"),
                      Text("Graphic Designer IQ Education", style: context.bodyMedium?.copyWith(color: const Color(0xff999999))),
                    ],
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Text("Date of birth: ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                  Text("16.09.2001", style: context.bodyMedium?.copyWith(color: const Color(0xff999999)))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Text("Phone number ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                  Text("+998 97 625 29 79", style: context.bodyMedium?.copyWith(color: const Color(0xff999999)))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Text("E-mail ", style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                  Text("predatorhunter041@gmail.com", style: context.bodyMedium?.copyWith(color: const Color(0xff999999)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
