// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cliente {
  int id_cliente;
  String nome_razao;
  String cpf_cnpj;
  String tipo;
  String email;
  String telefone;
  DateTime created_at;
  DateTime updated_at;
  Cliente({
    required this.id_cliente,
    required this.nome_razao,
    required this.cpf_cnpj,
    required this.tipo,
    required this.email,
    required this.telefone,
    required this.created_at,
    required this.updated_at,
  });

  Cliente copyWith({
    int? id_cliente,
    String? nome_razao,
    String? cpf_cnpj,
    String? tipo,
    String? email,
    String? telefone,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Cliente(
      id_cliente: id_cliente ?? this.id_cliente,
      nome_razao: nome_razao ?? this.nome_razao,
      cpf_cnpj: cpf_cnpj ?? this.cpf_cnpj,
      tipo: tipo ?? this.tipo,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_cliente': id_cliente,
      'nome_razao': nome_razao,
      'cpf_cnpj': cpf_cnpj,
      'tipo': tipo,
      'email': email,
      'telefone': telefone,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
  return Cliente(
    id_cliente: map['id_cliente'] as int,
    nome_razao: map['nome_razao'] as String,
    cpf_cnpj: map['cpf_cnpj'] as String,
    tipo: map['tipo'] as String,
    email: map['email'] as String,
    telefone: map['telefone'] as String,
    created_at: map['created_at'] is int
        ? DateTime.fromMillisecondsSinceEpoch(map['created_at'])
        : DateTime.parse(map['created_at']),
    updated_at: map['updated_at'] is int
        ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
        : DateTime.parse(map['updated_at']),
  );
}

  String toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) => Cliente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cliente(id_cliente: $id_cliente, nome_razao: $nome_razao, cpf_cnpj: $cpf_cnpj, tipo: $tipo, email: $email, telefone: $telefone, created_at: $created_at, updated_at: $updated_at)';
  }

  // @override
  // bool operator ==(covariant Cliente other) {
  //   if (identical(this, other)) return true;
  
  //   return 
  //     other.id_cliente == id_cliente &&
  //     other.nome_razao == nome_razao &&
  //     other.cpf_cnpj == cpf_cnpj &&
  //     other.tipo == tipo &&
  //     other.email == email &&
  //     other.telefone == telefone &&
  //     other.created_at == created_at &&
  //     other.updated_at == updated_at;
  // }

  @override
  int get hashCode {
    return id_cliente.hashCode ^
      nome_razao.hashCode ^
      cpf_cnpj.hashCode ^
      tipo.hashCode ^
      email.hashCode ^
      telefone.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode;
  }
}
