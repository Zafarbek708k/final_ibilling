import 'package:final_ibilling/feature/contracts/domain/entities/contract_entity.dart';
import 'package:final_ibilling/feature/contracts/presentation/widgets/contract_widget.dart';
import 'package:final_ibilling/feature/saved/presentation/pages/single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contract_bloc.dart';

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
  bool isPaginationEnabled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    isPaginationEnabled = widget.contracts.length >= 12;
    displayedList = isPaginationEnabled ? widget.contracts.take(itemsPerPage).toList() : widget.contracts;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (isPaginationEnabled && _scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 500));

    final int startIndex = currentPage * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;

    if (startIndex < widget.contracts.length) {
      setState(() {
        displayedList.addAll(widget.contracts.sublist(startIndex, endIndex > widget.contracts.length ? widget.contracts.length : endIndex));
        currentPage++;
      });
    }

    setState(() => isLoading = false);
  }

  Future<void> _onRefresh() async {
    setState(() {
      currentPage = 1;
      displayedList = isPaginationEnabled ? widget.contracts.take(itemsPerPage).toList() : widget.contracts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (widget.contracts.length >= 12) {
          _onRefresh();
          context.read<ContractBloc>().init();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: displayedList.length + _loadingIndicatorCount(),
          itemBuilder: (context, index) {
            if (index < displayedList.length) {
              final contract = displayedList[index];
              return ContractWidget(
                key: UniqueKey(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Single(contract: contract, contracts: widget.contracts)),
                ),
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
      ),
    );
  }

  int _loadingIndicatorCount() {
    return isPaginationEnabled && isLoading ? 1 : 0;
  }
}
