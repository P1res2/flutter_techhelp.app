import '../models/usuario_base_model.dart';
import 'api_service.dart';

class AuthService<T extends UsuarioBase> {
  final ApiService _apiService = ApiService();

  T? _currentUser;
  T? get currentUser => _currentUser;

  // Faz login
  Future<T?> login({
    required String email,
    required String password,
    required String sufixUrl,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final List<T> users = await _apiService.getAll<T>(sufixUrl, fromJson);

    for (var user in users) {
      print(user.id);
      if (user.email == email && user.password == password) {
        _currentUser = user;
        return user;
      }
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

    // verifica se o email ou cpf/cnpj ja está cadastrado
    for (var user in users) {
      if (user.email == novoUsuario.email) return false;
      if (user.cpfCnpj == novoUsuario.cpfCnpj) return false;
    }

    await _apiService.post<T>(sufixUrl, novoUsuario.toMap());
    return true;
  }
}
