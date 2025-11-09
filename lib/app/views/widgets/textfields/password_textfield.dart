import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextfield({super.key, required this.controller});

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !showPassword,
      decoration: InputDecoration(
        label: const Text("Senha"),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      controller: widget.controller,
    );
  }
}
