import 'package:flutter/material.dart';

class ContractCardWidget extends StatelessWidget {
  const ContractCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Row(
          children: [
            Text("data"),
          ],
        ),
      ),
    );
  }
}
