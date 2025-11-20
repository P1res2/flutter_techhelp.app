import 'package:flutter/material.dart';
import '../models/cliente_model.dart';
import '../models/usuario_base_model.dart';
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
  Future<bool> login({required String email, required String password}) async {
    UsuarioBase? user;
    try {
      user = await AuthService<UsuarioBase>().login(
        email: email,
        password: password,
      );
    } on Exception {
      messenger.showSnackBar(
        SnackBar(
          content: Text("Não foi possivel entrar, tente novamente mais tarde."),
        ),
      );
      return false;
    }

    if (user != null) {
      if (user.cpfCnpj == '') {
        navigator.pushNamed('/homeTecnico', arguments: user);
        messenger.showSnackBar(
          SnackBar(content: Text('Seja bem vindo ${user.nomeRazao}')),
        );
        return true;
      } else {
        navigator.pushNamed('/home', arguments: user);
        messenger.showSnackBar(
          SnackBar(content: Text('Seja bem vindo ${user.nomeRazao}')),
        );
        return true;
      }
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text("Essa conta não existe ou a senha está errada."),
        ),
      );
      return false;
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
  Future<bool> register({
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
              content: Text(
                "A sua conta foi criada com sucesso ${novoCliente.nomeRazao.split(' ').first} Faça login.",
              ),
            ),
          );

          navigator.pop();
          return true;
        } else {
          messenger.showSnackBar(
            SnackBar(
              content: Text("Email ou Cpf/Cnpj já existe, tente fazer login."),
            ),
          );
          return false;
        }

      case TipoUsuario.tecnico:
        final novoUsuario = TecnicoModel.fromMap(dados);

        if (await _authService.register(
          sufixUrl: sufixUrl,
          novoUsuario: novoUsuario,
          fromJson: TecnicoModel.fromMap,
        )) {
          messenger.showSnackBar(
            SnackBar(content: Text("A conta foi criada com sucesso!")),
          );
          return true;
        } else {
          messenger.showSnackBar(
            SnackBar(content: Text("Esse email já existe.")),
          );
          return false;
        }
    }
  }
}
