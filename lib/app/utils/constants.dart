import 'package:flutter/material.dart';

const List<DropdownMenuItem<String>> tiposContas = [
  DropdownMenuItem(value: "Fisica", child: Text("Fisica")),
  DropdownMenuItem(value: "Juridica", child: Text("Juridica")),
];

// Android
// const String prefixUrlApi = "http://10.0.2.2:7168/api";

// Desktop
const String prefixUrlApi = "http://localhost:7168/api";
