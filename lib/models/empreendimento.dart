class Empreendimento {
  const Empreendimento({
    this.id,
    required this.nomeEmpreendimento,
    required this.nomeResponsavel,
    required this.municipio,
    required this.segmento,
    required this.contato,
    required this.statusAtivo,
  });

  final int? id;
  final String nomeEmpreendimento;
  final String nomeResponsavel;
  final String municipio;
  final String segmento;
  final String contato;
  final bool statusAtivo;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome_empreendimento': nomeEmpreendimento,
      'nome_responsavel': nomeResponsavel,
      'municipio': municipio,
      'segmento': segmento,
      'contato': contato,
      'status_ativo': statusAtivo ? 1 : 0,
    };
  }
}
