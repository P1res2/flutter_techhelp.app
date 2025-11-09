import 'package:br_validators/br_validators.dart';
import 'package:flutter/material.dart';

class Validators {
  BuildContext context;

  Validators({required this.context});

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(context);

  bool phoneValidation(String telefone) {
    if (!BRValidators.validateMobileNumber(telefone)) {
      messenger.showSnackBar(
        SnackBar(content: Text("Número de telefone inválido!")),
      );
      return false;
    } else {
      return true;
    }
  }

  bool cpfCnpjValidation(bool isPessoaFisica, String cpfCnpj) {
    if (isPessoaFisica
        ? !BRValidators.validateCPF(cpfCnpj)
        : !BRValidators.validateCNPJ(cpfCnpj)) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(isPessoaFisica ? "Cpf inválido!" : "Cnpj inválido!"),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  bool emailValidation(String email) {
    if (!email.contains("@") || !email.contains(".com")) {
      messenger.showSnackBar(const SnackBar(content: Text('Email inválido!')));
      return false;
    } else {
      return true;
    }
  }

  bool samePasswordValidation(String senha1, String senha2) {
    if (senha1 != senha2) {
      messenger.showSnackBar(
        const SnackBar(content: Text('As senhas devem ser iguais.')),
      );
      return false;
    } else {
      return true;
    }
  }
}
