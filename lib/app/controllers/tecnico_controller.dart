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
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Dados Atualizados com sucesso! Saia e entre novamente para ver as atualizações.',
          ),
        ),
      );
      return true;
    }
    return false;
  }

  Future<bool> editarTecnico(Map<String, dynamic> data, int id) async {
    return await _apiService.patch('/Tecnicos/$id', data) ? true : false;
  }

  Future<bool> apagarTecnico({required int idTecnico}) async {
    if (await _apiService.delete('/Tecnicos/$idTecnico')) {
      messenger.showSnackBar(
        SnackBar(content: Text('Conta deletada com sucesso.')),
      );
      return true;
    }
    messenger.showSnackBar(SnackBar(content: Text('Não foi possivel apagar.')));
    return false;
  }
}
