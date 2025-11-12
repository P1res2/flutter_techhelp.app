import 'usuario_base_model.dart';

class TecnicoModel implements UsuarioBase {
  @override
  final String cpfCnpj = ''; // Ignorar
  @override
  final int? id;
  @override
  final String nomeRazao;
  @override
  final String email;
  final String telefone;
  @override
  final String password;
  final bool? ativo;
  final List<dynamic>? especialidades;
  final List<int>? idsEspecialidades;

  TecnicoModel({
    this.id,
    required this.nomeRazao,
    required this.email,
    required this.telefone,
    required this.password,
    this.ativo,
    this.especialidades,
    this.idsEspecialidades
  });

  @override
  factory TecnicoModel.fromMap(Map<String, dynamic> map) {
    return TecnicoModel(
      nomeRazao: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      password: map['senha'],
      idsEspecialidades: map['ids_especialidades']
    );
  }

  factory TecnicoModel.fromMapWithId(Map<String, dynamic> map) {
    return TecnicoModel(
      id: map['id_tecnico'],
      nomeRazao: map['nome_razao'],
      email: map['email'],
      telefone: map['telefone'],
      password: map['senha'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
    "nome": nomeRazao,
    "email": cpfCnpj,
    "telefone": email,
    "senha": password,
  };
}
