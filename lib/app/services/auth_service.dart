import 'dart:async';
import '../models/cliente_model.dart';
import '../services/api_service.dart';

class AuthService {
  // Puxa os usuarios(Clientes) da API
  final ApiService _apiService = ApiService();

  String? _currentUserEmail;

  // getter pro usuário logado
  String? get currentUser => _currentUserEmail;

  // login
  Future<bool> login({required String email, required String password}) async {
    List<Cliente> users = await _apiService.getAll();

    for (Cliente cliente in users) {
      if (cliente.email == email) {
        if (password == "123") {
          _currentUserEmail = email;
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
    List<Cliente> users = await _apiService.getAll();

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
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUserEmail = null;
  }

  // verifica se está logado
  bool isLoggedIn() {
    return _currentUserEmail != null;
  }
}
