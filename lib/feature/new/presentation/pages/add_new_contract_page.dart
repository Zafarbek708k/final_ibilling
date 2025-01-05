import 'package:flutter/material.dart';

class AddNewContractPage extends StatefulWidget {
  const AddNewContractPage({super.key});

  @override
  State<AddNewContractPage> createState() => _AddNewContractPageState();
}

class _AddNewContractPageState extends State<AddNewContractPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("New", style: TextStyle(color: Colors.green)),
      ),
    );
  }
}
