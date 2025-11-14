import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class TelefoneTextfield extends StatelessWidget {
  final TextEditingController controller;

  const TelefoneTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final phoneFormatter = MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
    );
    return TextField(
      decoration: const InputDecoration(
        label: Text("Telefone"),
        hintText: "(00)90000-0000",
      ),
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [phoneFormatter],
    );
  }
}
