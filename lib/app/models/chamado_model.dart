class ChamadoModel {
  final int? idChamado;
  final int idCliente;
  final int? idTecnico;
  final String titulo;
  final String descricao;
  final String prioridade;
  final String? status;
  final String tipoAtendimento;
  final String categoria;

  ChamadoModel({
    this.idChamado,
    required this.idCliente,
    this.idTecnico,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    this.status,
    required this.tipoAtendimento,
    required this.categoria,
  });

  factory ChamadoModel.fromMapForPost(Map<String, dynamic> map) {
    return ChamadoModel(
      idCliente: map['id_cliente'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      tipoAtendimento: map['tipo_atendimento'],
      categoria: map['categoria'],
    );
  }

  factory ChamadoModel.fromMap(Map<String, dynamic> map) {
    return ChamadoModel(
      idChamado: map['id_chamado'],
      idCliente: map['id_cliente'],
      idTecnico: map['id_tecnico'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      status: map['status'],
      tipoAtendimento: map['tipo_atendimento'],
      categoria: map['categoria'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id_cliente': idCliente,
    'titulo': titulo,
    'descricao': descricao,
    'prioridade': prioridade,
    'tipo_atendimento': tipoAtendimento,
    'categoria': categoria,
  };
}
