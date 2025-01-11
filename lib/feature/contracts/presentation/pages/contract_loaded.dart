import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:final_ibilling/feature/saved/presentation/pages/single.dart';
import 'package:final_ibilling/feature/setting/common_widgets/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContractLoadedWidget extends StatefulWidget {
  const ContractLoadedWidget({super.key, required this.contracts});

  final List<ContractEntity> contracts;

  @override
  State<ContractLoadedWidget> createState() => _ContractLoadedWidgetState();
}

class _ContractLoadedWidgetState extends State<ContractLoadedWidget> {
  late List<ContractEntity> displayedList;
  late ScrollController _scrollController;
  bool isLoading = false;
  int currentPage = 1;
  final int itemsPerPage = 4; // Adjust items per page as needed
  bool loadMoreButtonEnable = false; // Flag to show the Load More button

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    displayedList = widget.contracts.take(itemsPerPage).toList(); // Initial display of items
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
      // Show "Load More" button only if not already loading
      setState(() {
        loadMoreButtonEnable = true;
      });
    }
  }

  Future<void> _loadMoreItems() async {
    if (isLoading) return; // Prevent multiple load operations at once

    setState(() {
      isLoading = true;
      loadMoreButtonEnable = false; // Hide the button while loading
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulate loading delay

    final int startIndex = currentPage * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;

    if (startIndex < widget.contracts.length) {
      setState(() {
        displayedList.addAll(widget.contracts.sublist(startIndex, endIndex > widget.contracts.length ? widget.contracts.length : endIndex));
        currentPage++;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      currentPage = 1;
      displayedList = widget.contracts.take(itemsPerPage).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            widget.contracts.isEmpty
                ? Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/empty_saved.svg"),
                  const SizedBox(height: 10),
                  const Text("No more items")
                ],
              ),
            )
                : const SizedBox.shrink(),
            // Row with MainButtons for "Contracts" and "Invoice"
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainButton(onPressed: () {}, title: "Contracts", bcgC: AppColors.greenDark, select: true),
                5.horizontalSpace,
                MainButton(onPressed: () {}, title: "Invoice", bcgC: AppColors.greenDark, select: false),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: displayedList.length + (loadMoreButtonEnable ? 1 : 0), // Add space for loading indicator or button
                itemBuilder: (context, index) {
                  if (index < displayedList.length) {
                    final contract = displayedList[index];
                    return ContractWidget(
                      key: UniqueKey(),
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Single(contract: contract, contracts: widget.contracts))
                          ),
                      model: contract,
                    );
                  }

                  // Show Load More Button
                  return loadMoreButtonEnable
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: MainButton(
                      onPressed: _loadMoreItems,
                      title: "Load More", bcgC: AppColors.greenDark, select: true,minWith: 75,
                    ),
                  )
                      : const SizedBox.shrink(); // In case loading is in progress, hide button
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class ContractLoadedWidget extends StatefulWidget {
//   const ContractLoadedWidget({super.key, required this.contracts});
//
//   final List<ContractEntity> contracts;
//
//   @override
//   State<ContractLoadedWidget> createState() => _ContractLoadedWidgetState();
// }
//
// class _ContractLoadedWidgetState extends State<ContractLoadedWidget> {
//   late List<ContractEntity> displayedList;
//   late ScrollController _scrollController;
//   bool isLoading = false;
//   int currentPage = 1;
//   final int itemsPerPage = 5;
//   bool isPaginationEnabled = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_onScroll);
//     isPaginationEnabled = widget.contracts.length >= 12;
//     displayedList = isPaginationEnabled ? widget.contracts.take(itemsPerPage).toList() : widget.contracts;
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (isPaginationEnabled && _scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
//       _loadMoreItems();
//     }
//   }
//
//   Future<void> _loadMoreItems() async {
//     setState(() => isLoading = true);
//
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     final int startIndex = currentPage * itemsPerPage;
//     final int endIndex = startIndex + itemsPerPage;
//
//     if (startIndex < widget.contracts.length) {
//       setState(() {
//         displayedList.addAll(widget.contracts.sublist(startIndex, endIndex > widget.contracts.length ? widget.contracts.length : endIndex));
//         currentPage++;
//       });
//     }
//
//     setState(() => isLoading = false);
//   }
//
//   Future<void> _onRefresh() async {
//     setState(() {
//       currentPage = 1;
//       displayedList = isPaginationEnabled ? widget.contracts.take(itemsPerPage).toList() : widget.contracts;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         if (widget.contracts.length >= 12) {
//           _onRefresh();
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(
//           children: [
//             widget.contracts.isEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 150),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [SvgPicture.asset("assets/icons/empty_saved.svg"), 10.verticalSpace, const Text("No more item")],
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             Expanded(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 itemCount: displayedList.length + _loadingIndicatorCount(),
//                 itemBuilder: (context, index) {
//                   if(index == 0){
//                     bool contractB = true,  invoiceB=false;
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         MainButton(onPressed: (){}, title: "Contracts", bcgC: AppColors.greenDark, select: contractB),
//                         5.horizontalSpace,
//                         MainButton(onPressed: (){}, title: "Invoice", bcgC: AppColors.greenDark, select: invoiceB),
//                       ],
//                     );
//                   }
//                   if (index < displayedList.length - 1) {
//                     final contract = displayedList[index-1];
//                     return ContractWidget(
//                       key: UniqueKey(),
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Single(contract: contract, contracts: widget.contracts)),
//                       ),
//                       model: contract,
//                     );
//                   } else {
//                     return const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   int _loadingIndicatorCount() {
//     return isPaginationEnabled && isLoading ? 1 : 0;
//   }
// }
