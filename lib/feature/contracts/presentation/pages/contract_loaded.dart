


import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:flutter/material.dart';

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
  final int itemsPerPage = 3;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    displayedList = widget.contracts.take(itemsPerPage).toList();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 500)); // Simulate delay

    final int startIndex = currentPage * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;

    if (startIndex < widget.contracts.length) {
      setState(() {
        displayedList.addAll(widget.contracts.sublist(
          startIndex,
          endIndex > widget.contracts.length ? widget.contracts.length : endIndex,
        ));
        currentPage++;
      });
    }

    setState(() => isLoading = false);
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
      child: ListView.builder(
        controller: _scrollController,
        itemCount: displayedList.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < displayedList.length) {
            final contract = displayedList[index];
            return ContractWidget(
              onTap: () {},
              model: contract,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}