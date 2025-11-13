import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  final TextEditingController controller;
  bool readOnly = false;

  EmailTextfield({super.key, required this.controller, required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        label: Text("Email"),
        hintText: "exemplo@email.com",
      ),
      controller: controller,
      readOnly: readOnly,
    );
  }
}
