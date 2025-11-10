import 'usuario_base_model.dart';

class TecnicoModel implements UsuarioBase {
  @override
  int? id;
  @override
  final String nomeRazao;
  @override
  final String cpfCnpj;
  @override
  final String email;
  @override
  final String password;

  TecnicoModel({
    required this.nomeRazao,
    required this.cpfCnpj,
    required this.email,
    required this.password,
  });

  @override
  factory TecnicoModel.fromMap(Map<String, dynamic> map) {
    return TecnicoModel(
      nomeRazao: map['nome'],
      cpfCnpj: map['cpf_cnpj'],
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    "nome": nomeRazao,
    "cpf_cnpj": cpfCnpj,
    "email": email,
    "password": password,
  };
}
