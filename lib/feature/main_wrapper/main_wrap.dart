import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/contract_page.dart';
import 'package:final_ibilling/feature/history/presentation/pages/history_page.dart';
import 'package:final_ibilling/feature/new/presentation/pages/add_new_contract_page.dart';
import 'package:final_ibilling/feature/profile/presentation/pages/profile_page.dart';
import 'package:final_ibilling/feature/saved/presentation/pages/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainWrap extends StatefulWidget {
  const MainWrap({super.key});

  @override
  State<MainWrap> createState() => _MainWrapState();
}

class _MainWrapState extends State<MainWrap> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [ContractPage(), HistoryPage(), AddNewContractPage(), SavedPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkest,
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items:  [
            BottomNavigationBarItem(
              icon: _currentIndex == 0 ? SvgPicture.asset("assets/icons/bold_contract.svg") : SvgPicture.asset("assets/icons/outline_contract.svg"),
              label: "contract".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1 ? SvgPicture.asset("assets/icons/bold_history.svg") : SvgPicture.asset("assets/icons/outline_history.svg"),
              label: "history".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2 ? SvgPicture.asset("assets/icons/bold_plus.svg") : SvgPicture.asset("assets/icons/outline_plus.svg"),
              label: "addNew".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3 ? SvgPicture.asset("assets/icons/bold_save.svg") : SvgPicture.asset("assets/icons/outline_save.svg"),
              label: "saved".tr(),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 4 ? SvgPicture.asset("assets/icons/bold_profile.svg") : SvgPicture.asset("assets/icons/outline_profile.svg"),
              label: "profile".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
