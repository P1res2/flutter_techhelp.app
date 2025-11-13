import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TecnicoController {
  final ApiService _apiService = ApiService();
  BuildContext context;

  late final NavigatorState navigator;
  late final ScaffoldMessengerState messenger;

  TecnicoController({required this.context}) {
    navigator = Navigator.of(context);
    messenger = ScaffoldMessenger.of(context);
  }

  Future<bool> atualizarTecnico({
    required int idTecnico,
    required Map<String, dynamic> map,
  }) async {
    if (await _apiService.patch('/Tecnicos/$idTecnico', map)) {
      messenger.showSnackBar(SnackBar(content: Text('Dados Atualizados com sucesso! Saia e entre novamente para ver as atualizações.')));
      return true;
    }
    return false;
  }
}
