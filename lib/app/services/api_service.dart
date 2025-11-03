// Implementar...
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cliente_model.dart';
import '../utils/constants.dart';

class ApiService {
  var urlClientes = urlClientesForDesktop;
  // var urlClientes = urlClientesForAndroid;


  // Get Clientes
  Future<List<Cliente>> getAll() async {
    http.Response response = await http.get(Uri.parse(urlClientes));

    List<dynamic> listDynamic = json.decode(response.body);

    List<Cliente> listClientes = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapCliente = dyn as Map<String, dynamic>;
      Cliente cliente = Cliente.fromMap(mapCliente);
      listClientes.add(cliente);
    }
    return listClientes;
  }

  // Post Cliente
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
        Uri.parse(urlClientes),
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
}
