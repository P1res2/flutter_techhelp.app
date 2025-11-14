import 'package:flutter/material.dart';

class NomeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const NomeTextfield({super.key, required this.controller, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(label: Text("Nome")),
      controller: controller,
      readOnly: readOnly,
    );
  }
}
