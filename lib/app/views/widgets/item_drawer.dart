import 'package:flutter/material.dart';

class ItemDrawer extends StatefulWidget {
  final VoidCallback setUpdate;
  final IconData icon;
  final String text;

  const ItemDrawer({
    super.key,
    required this.icon,
    required this.text,
    required this.setUpdate,
  });

  @override
  State<ItemDrawer> createState() => _ItemDrawerState();
}

class _ItemDrawerState extends State<ItemDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.text),
      onTap: () {
        widget.setUpdate();
        Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {}); // força rebuild da tela
        });
      },
    );
  }
}
