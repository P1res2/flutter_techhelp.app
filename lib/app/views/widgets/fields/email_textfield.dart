import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const EmailTextfield({super.key, required this.controller, this.readOnly = false});

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
