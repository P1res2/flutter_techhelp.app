import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ClienteController {
  final ApiService _apiService = ApiService();
  BuildContext context;

  late final NavigatorState navigator;
  late final ScaffoldMessengerState messenger;

  ClienteController({required this.context}) {
    navigator = Navigator.of(context);
    messenger = ScaffoldMessenger.of(context);
  }

  Future<bool> atualizarCliente({
    required int idCliente,
    required Map<String, dynamic> map,
  }) async {
    if (await _apiService.patch('/clientes/$idCliente', map)) {
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

  Future<bool> apagarCliente({required int idCliente}) async {
    if (await _apiService.delete('/clientes/$idCliente')) {
      navigator.pop();
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(content: Text('Conta deletada com sucesso.')),
      );
      return true;
    }
    messenger.showSnackBar(SnackBar(content: Text('Não foi possivel apagar.')));
    return false;
  }
}
