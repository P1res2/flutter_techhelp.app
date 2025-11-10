import 'package:flutter/material.dart';
import 'plataform_utils.dart';

const List<DropdownMenuItem<String>> tiposContas = [
  DropdownMenuItem(value: "Fisica", child: Text("Fisica")),
  DropdownMenuItem(value: "Juridica", child: Text("Juridica")),
];

// Link da API local
String prefixUrlApi = PlatformUtils.isDesktop ? "http://localhost:7168/api" : "http://10.0.2.2:7168/api";
