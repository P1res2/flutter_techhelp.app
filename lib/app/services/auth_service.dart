import 'dart:async';
import '../models/cliente_model.dart';
import '../services/api_service.dart';

class AuthService {
  // Manipula os dados da API
  final ApiService _apiService = ApiService();

  String? _currentUserEmail;
  String? _currentUserNomeRazao;
  int? _currentUserId;

  // getter pro usuário logado
  Map<dynamic, dynamic> get currentUser => {"id_cliente": _currentUserId, "nomeRazao": _currentUserNomeRazao, "email": _currentUserEmail};

  // login
  Future<bool> login({required String email, required String password}) async {
    List<dynamic> users = await _apiService.getAll("/Clientes/");

    for (Map user in users) {
      if (user["email"] == email) {
        if (password == "123") {
          _currentUserNomeRazao = user["nome_razao"];
          _currentUserEmail = email;
          _currentUserId = user["id_cliente"];
          return true;
        }
      }
    }
    return false;
  }

  // registro
  Future<bool> register({
    required String nomeRazao,
    required String telefone,
    required String cpfCnpj,
    required String tipo,
    required String email,
    required String password,
  }) async {
    List<dynamic> users = await _apiService.getAll("/Clientes/");

    for (Cliente cliente in users) {
      if (cliente.cpf_cnpj == cpfCnpj) return false;
      if (cliente.email == email) return false;
    }
    _apiService.postCliente(
      nomeRazao: nomeRazao,
      telefone: telefone,
      cpfCnpj: cpfCnpj,
      tipo: tipo,
      email: email,
      password: password,
    );
    return true;
  }

  // logout
  Future<void> logout() async {
    _currentUserEmail = null;
    _currentUserNomeRazao = null;
  }

  // verifica se está logado
  bool isLoggedIn() {
    return _currentUserEmail != null;
  }
}
