import 'dart:convert';

import 'package:flutter_techhelp_app/app/services/api_service.dart';

class ChamadoService {
  final ApiService _apiService = ApiService();

  Future<bool> createChamado(String chamado) async {
    Map<String, dynamic> chamadoMap = await jsonDecode(chamado);

    await _apiService.postChamado(
      idCliente: chamadoMap['id_cliente'],
      titulo: chamadoMap['titulo'],
      descricao: chamadoMap['descricao'],
      prioridade: chamadoMap['prioridade'],
      tipoAtendimento: chamadoMap['tipo_atendimento'],
      categoria: chamadoMap['categoria'],
    );
    return true;
  }
}
