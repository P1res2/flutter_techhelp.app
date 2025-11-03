import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    NavigatorState navigator = Navigator.of(context);
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

    if (await _authService.login(email: email, password: password)) {
      navigator.pushNamed('/chatbot');
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Essa conta não existe ou a senha está incorreta. Clique em Cadastrar-se para criar uma conta.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }

  Future<void> register({
    required BuildContext context,
    required String nomeRazao,
    required String cpfCnpj,
    required String tipo,
    required String email,
    required String telefone,
    required String password,
  }) async {
    NavigatorState navigator = Navigator.of(context);
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

    if (await _authService.register(
      nomeRazao: nomeRazao,
      cpfCnpj: cpfCnpj,
      tipo: tipo,
      email: email,
      telefone: telefone,
      password: password,
    )) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            "Conta criada com sucesso!! Faça login.",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Email ou Cpf/Cnpj já existe, faça login.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }

  bool isLoggedIn() => _authService.isLoggedIn();
}
