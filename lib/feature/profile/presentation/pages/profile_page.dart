import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/loading_state_widget.dart';
import 'package:final_ibilling/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:final_ibilling/feature/profile/presentation/widgets/lang_ui.dart';
import 'package:final_ibilling/feature/profile/presentation/widgets/language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../assets/colors/app_colors.dart';
import '../../../contracts/presentation/widgets/app_circle_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const AppCircleAvatar(),
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
                    onPressed: () => showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (context) => LangSelect(locale: state.locale),
                    ),
                    minWidth: double.infinity,
                    height: 40,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.darkGray,
                    child: LangUi(locale: state.locale),
                  );
                }
                if (state.status == ProfileStateStatus.loaded) {
                  return MaterialButton(
                    onPressed: () => showDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      context: context,
                      builder: (context) => LangSelect(locale: state.locale),
                    ),
                    minWidth: double.infinity,
                    height: 40,
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
    final email = "email".tr();
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.darkGray),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 24, bottom: 24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/account-circle.svg"),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Otabek Abdusamatov", style: context.bodyLarge?.copyWith(color: AppColors.greenDark)),
                      Text("Graphic designer • IQ Education", style: context.labelMedium?.copyWith(color: const Color(0xffE7E7E7))),
                    ],
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("birth".tr(), style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                  Text("16.09.2001", style: context.labelSmall?.copyWith(color: const Color(0xff999999), fontSize: 14))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("phone".tr(), style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                  Text("+998 97 625 29 79", style: context.labelSmall?.copyWith(color: const Color(0xff999999), fontSize: 14))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(email, style: context.bodyMedium?.copyWith(color: const Color(0xffE7E7E7))),
                  Text(
                    email.length > 10 ? "predatorhunter041@gma..." : "predatorhunter041@gmail.com",
                    style: context.labelSmall?.copyWith(color: const Color(0xff999999), fontSize: 14),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
