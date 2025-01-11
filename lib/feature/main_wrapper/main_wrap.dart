import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/presentation/pages/contract_page.dart';
import 'package:final_ibilling/feature/history/presentation/pages/history_page.dart';
import 'package:final_ibilling/feature/main_wrapper/seasonal_effect.dart';
import 'package:final_ibilling/feature/new/presentation/pages/add_new_contract_page.dart';
import 'package:final_ibilling/feature/new/presentation/pages/add_new_invoice.dart';
import 'package:final_ibilling/feature/profile/presentation/pages/profile_page.dart';
import 'package:final_ibilling/feature/saved/presentation/pages/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainWrap extends StatefulWidget {
  const MainWrap({super.key});

  @override
  State<MainWrap> createState() => _MainWrapState();
}

class _MainWrapState extends State<MainWrap> {
  int _currentIndex = 0;
  bool isContractSelected = true;
  final List<Widget> _pages = const [
    ContractPage(),
    HistoryPage(),
    Placeholder(), // Placeholder for AddNewContractPage/AddNewInvoice
    SavedPage(),
    ProfilePage(),
  ];

  void _showCreateDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (dialogContext) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 18),
          backgroundColor: const Color(0xff2A2A2D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Что вы хотите создать?",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 777),
              _buildDialogButton(
                label: "Contract",
                iconPath: "assets/icons/contract.svg",
                onPressed: () {
                  setState(() {
                    isContractSelected = true;
                    _currentIndex = 2;
                  });
                  Navigator.pop(dialogContext);
                },
              ),
              const SizedBox(height: 10),
              _buildDialogButton(
                label: "Invoice",
                iconPath: "assets/icons/invoice.svg",
                onPressed: () {
                  setState(() {
                    isContractSelected = false;
                    _currentIndex = 2;
                  });
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogButton({
    required String label,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 40,
      color: const Color(0xff4E4E4E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 10),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkest,
      body: _currentIndex == 2
          ? (isContractSelected ? const AddNewContractPage() : const AddNewInvoice())
          : _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            _showCreateDialog();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 0 ? "assets/icons/bold_contract.svg" : "assets/icons/outline_contract.svg",
            ),
            label: "contract".tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1 ? "assets/icons/bold_history.svg" : "assets/icons/outline_history.svg",
            ),
            label: "history".tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2 ? "assets/icons/bold_plus.svg" : "assets/icons/outline_plus.svg",
            ),
            label: "addNew".tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3 ? "assets/icons/bold_save.svg" : "assets/icons/outline_save.svg",
            ),
            label: "saved".tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 4 ? "assets/icons/bold_profile.svg" : "assets/icons/outline_profile.svg",
            ),
            label: "profile".tr(),
          ),
        ],
      ),
    );
  }
}


// class MainWrap extends StatefulWidget {
//   const MainWrap({super.key});
//
//   @override
//   State<MainWrap> createState() => _MainWrapState();
// }
//
// class _MainWrapState extends State<MainWrap> {
//   int _currentIndex = 0;
//   bool contract = true;
//   final List<Widget> _pages = const [ContractPage(), HistoryPage(), AddNewContractPage(), SavedPage(), ProfilePage()];
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (value, res) async {
//         await showDialog<bool>(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Are you sure?'),
//               content: const Text('Do you want to exit the app?'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: const Text('No'),
//                 ),
//                 TextButton(
//                   onPressed: () => SystemNavigator.pop(),
//                   child: const Text('Yes'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.darkest,
//         body: Stack(
//           children: [
//             IgnorePointer(child: seasonalEffectWidget(Range(0.1, 7), context: context)),
//             _currentIndex == 2 && contract
//                 ? _pages[3]
//                 : (_currentIndex == 2 && contract == false)
//                     ? const AddNewInvoice()
//                     : _pages[_currentIndex],
//             IgnorePointer(child: seasonalEffectWidget(Range(2, 12), context: context)),
//           ],
//         ),
//         bottomNavigationBar: Theme(
//           data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               if (index == 2) {
//                 showDialog(
//                   context: context,
//                   barrierColor: Colors.black.withOpacity(0.5),
//                   builder: (dialogContext) => BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                     child: AlertDialog(
//                       backgroundColor: const Color(0xff2A2A2D),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       title: Align(alignment: Alignment.center, child: Text("Что вы хотите создать?", style: context.bodyLarge)),
//                       content: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const SizedBox(width: 555),
//                           MaterialButton(
//                             onPressed: () => setState(() {
//                               _currentIndex = index;
//                               contract = true;
//                               Navigator.pop(dialogContext);
//                             }),
//                             minWidth: double.infinity,
//                             color: const Color(0xff4E4E4E),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset("assets/icons/contract.svg"),
//                                 10.horizontalSpace,
//                                 Text("Contract", style: context.bodyLarge),
//                                 const Spacer()
//                               ],
//                             ),
//                           ),
//                           10.verticalSpace,
//                           MaterialButton(
//                             onPressed: () => setState(() {
//                               _currentIndex = index;
//                               contract = false;
//                               Navigator.pop(dialogContext);
//                             }),
//                             minWidth: double.infinity,
//                             color: const Color(0xff4E4E4E),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset("assets/icons/invoice.svg"),
//                                 10.horizontalSpace,
//                                 Text("Invoce", style: context.bodyLarge),
//                                 const Spacer()
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//                 setState(() => _currentIndex = index);
//               } else {
//                 setState(() => _currentIndex = index);
//               }
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: _currentIndex == 0 ? SvgPicture.asset("assets/icons/bold_contract.svg") : SvgPicture.asset("assets/icons/outline_contract.svg"),
//                 label: "contract".tr(),
//               ),
//               BottomNavigationBarItem(
//                 icon: _currentIndex == 1 ? SvgPicture.asset("assets/icons/bold_history.svg") : SvgPicture.asset("assets/icons/outline_history.svg"),
//                 label: "history".tr(),
//               ),
//               BottomNavigationBarItem(
//                 icon: _currentIndex == 2 ? SvgPicture.asset("assets/icons/bold_plus.svg") : SvgPicture.asset("assets/icons/outline_plus.svg"),
//                 label: "addNew".tr(),
//               ),
//               BottomNavigationBarItem(
//                 icon: _currentIndex == 3 ? SvgPicture.asset("assets/icons/bold_save.svg") : SvgPicture.asset("assets/icons/outline_save.svg"),
//                 label: "saved".tr(),
//               ),
//               BottomNavigationBarItem(
//                 icon: _currentIndex == 4 ? SvgPicture.asset("assets/icons/bold_profile.svg") : SvgPicture.asset("assets/icons/outline_profile.svg"),
//                 label: "profile".tr(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
