import 'package:flutter/material.dart';

class NomeTextfield extends StatelessWidget {
  final TextEditingController controller;

  const NomeTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(label: Text("Nome")),
      controller: controller,
    );
  }
}
