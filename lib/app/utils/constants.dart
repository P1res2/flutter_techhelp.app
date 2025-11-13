import 'package:flutter/material.dart';

const List<DropdownMenuItem<String>> tiposContas = [
  DropdownMenuItem(value: "Fisica", child: Text("Fisica")),
  DropdownMenuItem(value: "Juridica", child: Text("Juridica")),
];

// Link da API local
String prefixUrlApi = 'https://techhelpapi.azurewebsites.net/api';

const String sucessMessage =
    'Eu criei um chamado para você, em breve um técnico entrara em contato para solucionar o seu problema. Confira a sua página inicial para ver os seus chamados.';
const String failMessage =
    'Não foi possivel criar o seu chamado no momento, tente novamente mais tarde.';
