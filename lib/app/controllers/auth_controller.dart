import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/models/cliente_model.dart';
import 'package:flutter_techhelp_app/app/models/usuario_base_model.dart';
import '../models/tecnico_model.dart';
import '../services/auth_service.dart';

enum TipoUsuario { cliente, tecnico }

class AuthController {
  final AuthService _authService = AuthService();
  BuildContext context;

  late final NavigatorState navigator;
  late final ScaffoldMessengerState messenger;

  AuthController({required this.context}) {
    navigator = Navigator.of(context);
    messenger = ScaffoldMessenger.of(context);
  }

  // Faz login
  Future<void> login({required String email, required String password}) async {
    UsuarioBase? user = await AuthService<UsuarioBase>().login(
      email: email,
      password: password,
    );

    if (user != null) {
      if (user.cpfCnpj == '') {
        navigator.pushNamed('/homeTecnico', arguments: user);
      } else {
        navigator.pushNamed('/home', arguments: user);
      }
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text("Essa conta não existe ou a senha está errada."),
        ),
      );
    }
  }

  bool isLoggedIn() => _authService.isLoggedIn();

  Future<void> logout() async {
    await _authService.logout();
    navigator.pop();
    navigator.pop();
    navigator.pop();
  }

  // Registra um usuario
  Future<void> register({
    required TipoUsuario tipo,
    required String sufixUrl,
    required Map<String, dynamic> dados,
  }) async {
    switch (tipo) {
      case TipoUsuario.cliente:
        final novoCliente = ClienteModel.fromMap(dados);

        if (await _authService.register(
          sufixUrl: sufixUrl,
          novoUsuario: novoCliente,
          fromJson: ClienteModel.fromMap,
        )) {
          messenger.showSnackBar(
            SnackBar(
              content: Text("A sua conta foi criada com sucesso! Faça login."),
            ),
          );
          navigator.pop();
        } else {
          messenger.showSnackBar(
            SnackBar(
              content: Text("Email ou Cpf/Cnpj já existe, tente fazer login."),
            ),
          );
        }
        break;

      case TipoUsuario.tecnico:
        final novoUsuario = TecnicoModel.fromMap(dados);

        await _authService.register(
          sufixUrl: sufixUrl,
          novoUsuario: novoUsuario,
          fromJson: TecnicoModel.fromMap,
        );
    }
  }
}
