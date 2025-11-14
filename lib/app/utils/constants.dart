import 'package:flutter/material.dart';

// Tipos de contas
const List<DropdownMenuItem<String>> tiposContas = [
  DropdownMenuItem(value: "Fisica", child: Text("Fisica")),
  DropdownMenuItem(value: "Juridica", child: Text("Juridica")),
];

const List<DropdownMenuItem<String>> prioridades = [
  DropdownMenuItem(value: "Baixa", child: Text("Baixa")),
  DropdownMenuItem(value: 'Media',child: Text('Media')),
  DropdownMenuItem(value: 'Alta',child: Text('Alta')),
  DropdownMenuItem(value: 'Critica',child: Text('Critica')),
];

const List<DropdownMenuItem<String>> status = [
  DropdownMenuItem(value: "Aberto", child: Text("Aberto")),
  DropdownMenuItem(value: "Em Andamento", child: Text("Em Andamento")),
  DropdownMenuItem(value: "Aguardando Cliente", child: Text("Aguardando Cliente")),
  DropdownMenuItem(value: "Resolvido", child: Text("Resolvido")),
  DropdownMenuItem(value: "Fechado", child: Text("Fechado")),
];

const List<DropdownMenuItem<String>> tiposAtendimentos = [
  DropdownMenuItem(value: "Remoto", child: Text('Remoto')),
  DropdownMenuItem(value: "Presencial", child: Text('Presencial')),
];

const List<DropdownMenuItem<String>> categorias = [
  DropdownMenuItem(value: "Hardware", child: Text('Hardware')),
  DropdownMenuItem(value: "Software", child: Text('Software')),
  DropdownMenuItem(value: "Redes", child: Text('Redes')),
  DropdownMenuItem(value: "Seguranca", child: Text('Seguranca')),
  DropdownMenuItem(value: "Outros", child: Text('Outros')),
];

// Link da API local
String prefixUrlApi = 'https://techhelpapi.azurewebsites.net/api';

const String sucessMessage =
    'Eu criei um chamado para você, em breve um técnico entrara em contato para solucionar o seu problema. Confira a sua página inicial para ver os seus chamados.';
const String failMessage =
    'Não foi possivel criar o seu chamado no momento, tente novamente mais tarde.';
