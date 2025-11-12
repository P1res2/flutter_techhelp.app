import 'package:flutter/material.dart';

const List<DropdownMenuItem<String>> tiposContas = [
  DropdownMenuItem(value: "Fisica", child: Text("Fisica")),
  DropdownMenuItem(value: "Juridica", child: Text("Juridica")),
];

// Link da API local
String prefixUrlApi = 'https://techhelpapi.azurewebsites.net/api';
