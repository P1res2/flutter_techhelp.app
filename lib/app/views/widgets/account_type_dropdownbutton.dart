import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class AccountTypeDropdown extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const AccountTypeDropdown({
    super.key,
    required this.value,
    
    required this.onChanged,
  });

  @override
  State<AccountTypeDropdown> createState() => _AccountTypeDropdownState();
}

class _AccountTypeDropdownState extends State<AccountTypeDropdown> {
  late String _accountType;

  @override
  void initState() {
    super.initState();
    _accountType = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _accountType,
      isExpanded: true,
      items: tiposContas,
      onChanged: (value) {
        if (value != null && value.isNotEmpty) {
          setState(() {
            _accountType = value;
          });
          widget.onChanged(value);
        }
      },
    );
  }
}
