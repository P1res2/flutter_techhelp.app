import 'package:flutter_techhelp_app/app/models/cliente_model.dart';
import 'package:collection/collection.dart';
import '../models/tecnico_model.dart';

import '../models/usuario_base_model.dart';
import 'api_service.dart';

class AuthService<T extends UsuarioBase> {
  final ApiService _apiService = ApiService();

  T? _currentUser;
  T? get currentUser => _currentUser;

  // Faz login
  Future<T?> login({required String email, required String password}) async {
    late List<ClienteModel> clientes;
    late List<TecnicoModel> tecnicos;
    try {
      clientes = await _apiService
          .getAll<ClienteModel>('/Clientes/', ClienteModel.fromMapWithId);
      tecnicos = await _apiService
          .getAll<TecnicoModel>('/Tecnicos/', TecnicoModel.fromMapWithId);
    } on Exception catch (e) {
      throw Exception('Erro ao buscar dados: $e');
    }

    if (await _tecnicoIsRegister(email, password)) {
      TecnicoModel? tecnicoUser = tecnicos.firstWhereOrNull(
        (t) => t.email == email && t.password == password,
      );
      _currentUser = tecnicoUser as T;
      return tecnicoUser as T;
    } else if (await _clienteEmailIsRegister(email, password)) {
      final clienteUser = clientes.firstWhereOrNull(
        (c) => c.email == email && c.password == password,
      );

      if (clienteUser == null) return null;

      _currentUser = clienteUser as T;
      return clienteUser as T;
    }
    return null;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  bool isLoggedIn() => _currentUser != null;

  // Registra um usuario
  Future<bool> register({
    required String sufixUrl,
    required T novoUsuario,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final List<T> users = await _apiService.getAll<T>(sufixUrl, fromJson);

    // Verifica se o email ja esta cadastrado como tecnico
    if (await _tecnicoIsRegister(novoUsuario.email, novoUsuario.password)) return false;

    // verifica se o email ou cpf/cnpj ja está cadastrado
    for (var user in users) {
      if (user.email == novoUsuario.email) return false;
      if (user.cpfCnpj == novoUsuario.cpfCnpj && novoUsuario.cpfCnpj != '') return false;
    }

    await _apiService.post<T>(sufixUrl, novoUsuario.toMap());
    return true;
  }

  Future<bool> _tecnicoIsRegister(String email, String senha) async {
    final List<TecnicoModel> tecnicos = await _apiService.getAll<TecnicoModel>(
      '/Tecnicos/',
      TecnicoModel.fromMap,
    );

    return tecnicos.any((t) => t.email == email && t.password == senha);
  }

  Future<bool> _clienteEmailIsRegister(String email, String senha) async {
    final List<ClienteModel> clientes = await _apiService.getAll<ClienteModel>(
      '/Clientes/',
      ClienteModel.fromMap,
    );

    return clientes.any((c) => c.email == email && c.password == senha);
  }
}
