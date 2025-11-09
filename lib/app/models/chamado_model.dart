import 'dart:convert';

class ChamadoModel {
  int id_chamado;
  int id_cliente;
  int? id_tecnico;
  String titulo;
  String descricao;
  String prioridade;
  String status;
  String tipo_atendimento;
  String categoria;
  DateTime? data_abertura;
  DateTime? data_fechamento;
  Duration? tempo_resolucao;
  Duration? sla_maximo;
  DateTime created_at;
  DateTime updated_at;
  ChamadoModel({
    required this.id_chamado,
    required this.id_cliente,
    this.id_tecnico,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    required this.status,
    required this.tipo_atendimento,
    required this.categoria,
    this.data_abertura,
    this.data_fechamento,
    this.tempo_resolucao,
    this.sla_maximo,
    required this.created_at,
    required this.updated_at,
  });

  ChamadoModel copyWith({
    int? id_chamado,
    int? id_cliente,
    int? id_tecnico,
    String? titulo,
    String? descricao,
    String? prioridade,
    String? status,
    String? tipo_atendimento,
    String? categoria,
    DateTime? data_abertura,
    DateTime? data_fechamento,
    Duration? tempo_resolucao,
    Duration? sla_maximo,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return ChamadoModel(
      id_chamado: id_chamado ?? this.id_chamado,
      id_cliente: id_cliente ?? this.id_cliente,
      id_tecnico: id_tecnico ?? this.id_tecnico,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      prioridade: prioridade ?? this.prioridade,
      status: status ?? this.status,
      tipo_atendimento: tipo_atendimento ?? this.tipo_atendimento,
      categoria: categoria ?? this.categoria,
      data_abertura: data_abertura ?? this.data_abertura,
      data_fechamento: data_fechamento ?? this.data_fechamento,
      tempo_resolucao: tempo_resolucao ?? this.tempo_resolucao,
      sla_maximo: sla_maximo ?? this.sla_maximo,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_chamado': id_chamado,
      'id_cliente': id_cliente,
      'id_tecnico': id_tecnico,
      'titulo': titulo,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': status,
      'tipo_atendimento': tipo_atendimento,
      'categoria': categoria,
      'data_abertura': data_abertura?.millisecondsSinceEpoch,
      'data_fechamento': data_fechamento?.millisecondsSinceEpoch,
      'tempo_resolucao': tempo_resolucao?.inMilliseconds,
      'sla_maximo': sla_maximo?.inMilliseconds,
      'created_at': created_at.millisecondsSinceEpoch,
      'updated_at': updated_at.millisecondsSinceEpoch,
    };
  }

  factory ChamadoModel.fromMap(Map<String, dynamic> map) {
    return ChamadoModel(
      id_chamado: map['id_chamado'] as int,
      id_cliente: map['id_cliente'] as int,
      id_tecnico: map['id_tecnico'] != null ? map['id_tecnico'] as int : null,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      prioridade: map['prioridade'] as String,
      status: map['status'] as String,
      tipo_atendimento: map['tipo_atendimento'] as String,
      categoria: map['categoria'] as String,
      data_abertura: map['data_abertura'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data_abertura'] as int)
          : null,
      data_fechamento: map['data_fechamento'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data_fechamento'] as int)
          : null,
      tempo_resolucao: map['tempo_resolucao'] != null
          ? Duration(milliseconds: map['tempo_resolucao'] as int)
          : null,
      sla_maximo: map['sla_maximo'] != null
          ? Duration(milliseconds: map['sla_maximo'] as int)
          : null,
      created_at: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updated_at: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChamadoModel.fromJson(String source) =>
      ChamadoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chamado(id_chamado: $id_chamado, id_cliente: $id_cliente, id_tecnico: $id_tecnico, titulo: $titulo, descricao: $descricao, prioridade: $prioridade, status: $status, tipo_atendimento: $tipo_atendimento, categoria: $categoria, data_abertura: $data_abertura, data_fechamento: $data_fechamento, tempo_resolucao: $tempo_resolucao, sla_maximo: $sla_maximo, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant ChamadoModel other) {
    if (identical(this, other)) return true;

    return other.id_chamado == id_chamado &&
        other.id_cliente == id_cliente &&
        other.id_tecnico == id_tecnico &&
        other.titulo == titulo &&
        other.descricao == descricao &&
        other.prioridade == prioridade &&
        other.status == status &&
        other.tipo_atendimento == tipo_atendimento &&
        other.categoria == categoria &&
        other.data_abertura == data_abertura &&
        other.data_fechamento == data_fechamento &&
        other.tempo_resolucao == tempo_resolucao &&
        other.sla_maximo == sla_maximo &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id_chamado.hashCode ^
        id_cliente.hashCode ^
        id_tecnico.hashCode ^
        titulo.hashCode ^
        descricao.hashCode ^
        prioridade.hashCode ^
        status.hashCode ^
        tipo_atendimento.hashCode ^
        categoria.hashCode ^
        data_abertura.hashCode ^
        data_fechamento.hashCode ^
        tempo_resolucao.hashCode ^
        sla_maximo.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
