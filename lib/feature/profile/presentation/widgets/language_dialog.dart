import 'dart:ui';

import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:final_ibilling/feature/setting/common_widgets/main_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../assets/colors/app_colors.dart';
import 'custom_radio_button.dart';

class LangSelect extends StatefulWidget {
  const LangSelect({
    super.key,
    required this.locale,
  });

  final String locale;

  @override
  State<LangSelect> createState() => _LangSelectState();
}

class _LangSelectState extends State<LangSelect> {
  bool uz = false, ru = false, en = false;

  void select(String locale) {
    setState(
      () => locale == "uz"
          ? (uz = true, ru = false, en = false)
          : locale == "ru"
              ? (ru = true, uz = false, en = false)
              : (en = true, ru = false, uz = false),
    );
  }

  @override
  void initState() {
    select(widget.locale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.darkGray),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                Align(alignment: Alignment.center, child: Text("Select Language", style: context.headlineLarge)),
                15.verticalSpace,
                LangDialogButton(
                  onPress: () => setState(() {
                    uz = true;
                    ru = false;
                    en = false;
                  }),
                  image: "assets/icons/uz.svg",
                  langText: "O'zbek (Lotin)",
                  selected: uz,
                ),
                LangDialogButton(
                  onPress: () => setState(() {
                    ru = true;
                    uz = false;
                    en = false;
                  }),
                  image: "assets/icons/ru.svg",
                  langText: "Русский",
                  selected: ru,
                ),
                LangDialogButton(
                  onPress: () => setState(() {
                    uz = false;
                    ru = false;
                    en = true;
                  }),
                  image: "assets/icons/en.svg",
                  langText: "English (USA)",
                  selected: en,
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MainButton(
                          minWith: double.infinity,
                          onPressed: () => Navigator.pop(context),
                          title: "Cancel",
                          bcgC: const Color(0xff008F7F).withOpacity(0.5),
                          textC: const Color(0xff0008F7F).withOpacity(0.7),
                          select: true,
                        ),
                      ),
                      20.horizontalSpace,
                      Expanded(
                        child: MainButton(
                          minWith: double.infinity,
                          onPressed: () async {
                            if (uz) {
                              context.read<ProfileBloc>().add(ChangeLocaleInProfile(locale: "uz", context: context));
                            } else if (ru) {
                              context.read<ProfileBloc>().add(ChangeLocaleInProfile(locale: "ru", context: context));
                            } else {
                              context.read<ProfileBloc>().add(ChangeLocaleInProfile(locale: "en", context: context));
                            }
                            Navigator.pop(context);
                          },
                          title: "Done",
                          bcgC: const Color(0xff008F7F),
                          select: true,
                        ),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LangDialogButton extends StatelessWidget {
  const LangDialogButton({super.key, required this.onPress, required this.image, required this.langText, required this.selected});

  final VoidCallback onPress;
  final String image, langText;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: SvgPicture.asset(image, fit: BoxFit.cover),
              )),
          Expanded(
            flex: 6,
            child: CupertinoButton(
              onPressed: onPress,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [Text(langText), const Spacer(), CustomRadioButton(selected: selected, onTap: onPress)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
