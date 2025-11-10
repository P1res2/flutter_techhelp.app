// Implementar...
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final String _prefixUrlApi = prefixUrlApi;

  // Get all
  Future<List<T>> getAll<T>(
    String sufixUrl,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await http.get(Uri.parse("$_prefixUrlApi$sufixUrl"));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar dados: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body);
    return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  // Post
  Future<void> post<T>(String sufixUrl, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("$_prefixUrlApi$sufixUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Erro ao criar registro: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha na requisição: $e');
    }
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
          "senha": password,
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
