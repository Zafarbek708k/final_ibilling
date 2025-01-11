import 'dart:developer';

import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:final_ibilling/feature/saved/presentation/pages/single.dart';
import 'package:final_ibilling/feature/setting/common_widgets/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContractLoadedPagination extends StatefulWidget {
  const ContractLoadedPagination({super.key, required this.contracts});

  final List<ContractEntity> contracts;

  @override
  State<ContractLoadedPagination> createState() => _ContractLoadedPaginationState();
}

class _ContractLoadedPaginationState extends State<ContractLoadedPagination> {
  late ScrollController _scrollController;
  List<ContractEntity> visibleContracts = [];
  bool isLoading = false, enableToPagination = false, contract = true;
  int itemPerPage = 4, currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _initializeContracts();
  }

  void _initializeContracts() {
    if (widget.contracts.length > 12) {
      enableToPagination = true;
      visibleContracts = widget.contracts.take(itemPerPage).toList();
    } else {
      visibleContracts = List.from(widget.contracts);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      log("isLoading => $isLoading");
    }
  }

  Future<void> _loadMoreItems() async {
    if (!enableToPagination || isLoading) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    int start = currentPage * itemPerPage;
    int end = start + itemPerPage;
    List<ContractEntity> newContracts = widget.contracts.sublist(start, end > widget.contracts.length ? widget.contracts.length : end);

    setState(() {
      visibleContracts.addAll(newContracts);
      currentPage++;
      isLoading = false;
      if (visibleContracts.length >= widget.contracts.length) {
        enableToPagination = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contracts.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/empty_saved.svg"),
            const SizedBox(height: 10),
            const Text("No more items"),
            const SizedBox(height: 50),
          ],
        ),
      );
    }
    if (enableToPagination == false && widget.contracts.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MainButton(
                  onPressed: () => setState(() {
                    contract = true;
                    _initializeContracts();
                  }),
                  title: "Contracts",
                  bcgC: AppColors.greenDark,
                  select: contract,
                ),
                5.horizontalSpace,
                MainButton(
                  onPressed: () => setState(() {
                    visibleContracts = [];
                    contract = false;
                  }),
                  title: "Invoice",
                  bcgC: AppColors.greenDark,
                  select: !contract,
                ),
              ],
            ),
            ...List.generate(
              visibleContracts.length,
              (index) {
                final contract = visibleContracts[index];
                return ContractWidget(
                  key: UniqueKey(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Single(
                        contract: contract,
                        contracts: widget.contracts,
                      ),
                    ),
                  ),
                  model: contract,
                );
              },
            )
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      itemCount: visibleContracts.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MainButton(
                onPressed: () => setState(() => contract = true),
                title: "Contracts",
                bcgC: AppColors.greenDark,
                select: contract,
              ),
              5.horizontalSpace,
              MainButton(
                onPressed: () => setState(() => contract = false),
                title: "Invoice",
                bcgC: AppColors.greenDark,
                select: !contract,
              ),
            ],
          );
        } else if (index <= visibleContracts.length) {
          final contract = visibleContracts[index - 1];
          return ContractWidget(
            key: UniqueKey(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Single(
                  contract: contract,
                  contracts: widget.contracts,
                ),
              ),
            ),
            model: contract,
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: isLoading
                  ? Text("Loading...", style: context.titleMedium?.copyWith(color: AppColors.greenDark))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: MainButton(onPressed: _loadMoreItems, title: "Load more", bcgC: AppColors.greenDark, select: true),
                    ),
            ),
          );
        }
      },
    );
  }
}
