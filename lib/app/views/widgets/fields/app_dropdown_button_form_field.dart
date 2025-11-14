import 'package:flutter/material.dart';

class AppDropdownButtonFormField extends StatelessWidget {
  final String title;
  final String value;
  final ValueChanged<String> onChanged;
  final List<DropdownMenuItem<String>> itens;

  const AppDropdownButtonFormField({
    super.key,
    required this.title,
    required this.value,
    required this.itens,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String actualValue = value;

    return DropdownButtonFormField<String>(
      value: actualValue,
      decoration: InputDecoration(labelText: title),
      isExpanded: true,
      items: itens,
      onChanged: (newValue) {
        if (newValue != null && newValue.isNotEmpty) {
          actualValue = newValue;
          print(actualValue);
          onChanged(actualValue);
        }
      },
    );
  }
}
