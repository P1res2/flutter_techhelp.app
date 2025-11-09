import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextfield({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        label: Text("Email"),
        hintText: "exemplo@email.com",
      ),
      controller: emailController,
    );
  }
}
