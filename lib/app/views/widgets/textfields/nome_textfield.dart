import 'package:flutter/material.dart';

class NomeTextfield extends StatelessWidget {
  TextEditingController controller;
  bool readOnly = false;

  NomeTextfield({super.key, required this.controller, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(label: Text("Nome")),
      controller: controller,
      readOnly: readOnly,
    );
  }
}
