import 'usuario_base_model.dart';

class ClienteModel implements UsuarioBase {
  @override
  final int? id;
  @override
  final String nomeRazao;
  final String telefone;
  @override
  final String cpfCnpj;
  final String tipo;
  @override
  final String email;
  @override
  final String password;

  ClienteModel({
    this.id,
    required this.nomeRazao,
    required this.telefone,
    required this.cpfCnpj,
    required this.tipo,
    required this.email,
    required this.password,
  });

  @override
  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      nomeRazao: map['nome_razao'],
      telefone: map['telefone'],
      cpfCnpj: map['cpf_cnpj'],
      tipo: map['tipo'],
      email: map['email'],
      password: map['senha'],
    );
  }

  factory ClienteModel.fromMapWithId(Map<String, dynamic> map) {
    return ClienteModel(
      id: map['id_cliente'],
      nomeRazao: map['nome_razao'],
      telefone: map['telefone'],
      cpfCnpj: map['cpf_cnpj'],
      tipo: map['tipo'],
      email: map['email'],
      password: map['senha'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    "nome_razao": nomeRazao,
    "telefone": telefone,
    "cpf_cnpj": cpfCnpj,
    "tipo": tipo,
    "email": email,
    "senha": password,
  };

  // int getId() {

  // }
}
