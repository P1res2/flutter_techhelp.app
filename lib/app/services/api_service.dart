// Implementar...
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final String _prefixUrlApi = prefixUrlApi;

  // Get all
  Future<List<dynamic>> getAll(String sufixUrl) async {
    http.Response response = await http.get(Uri.parse("$_prefixUrlApi$sufixUrl"));

    List<dynamic> listDynamic = json.decode(response.body);
    return listDynamic.toList();
  }

  // Cria Cliente
  Future<void> postCliente({
    required String nomeRazao,
    required String telefone,
    required String cpfCnpj,
    required String tipo,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$prefixUrlApi/Clientes/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "nome_razao": nomeRazao,
          "cpf_cnpj": cpfCnpj,
          "tipo": tipo,
          "email": email,
          "telefone": telefone,
          "password": password, // adiciona se necessário
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Erro ao criar cliente: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
  }

  // Cria Chamado
  Future<void> postChamado({
    required int idCliente,
    required String titulo,
    required String descricao,
    required String prioridade,
    required String tipoAtendimento,
    required String categoria,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$prefixUrlApi/Chamados/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id_cliente": idCliente,
          "titulo": titulo,
          "descricao": descricao,
          "prioridade": prioridade,
          "tipo_atendimento": tipoAtendimento,
          "categoria": categoria,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Erro ao criar chamado: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
  }
}
