import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CpfCnpjTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPessoaFisica;

  const CpfCnpjTextField({
    super.key,
    required this.controller,
    required this.isPessoaFisica,
  });

  @override
  Widget build(BuildContext context) {
    final cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    final cnpjFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return TextField(
      decoration: InputDecoration(label: Text(isPessoaFisica ? "CPF" : "CNPJ")),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [isPessoaFisica ? cpfFormatter : cnpjFormatter],
    );
  }
}
