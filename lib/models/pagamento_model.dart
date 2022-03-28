// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PagamentoModel {
  final int? id;
  final int? idCliente;
  final String? dataPagamento;
  final int? quantidade;
  final double? valorSessao;
  final double? valorTotal;
  final String? observacoes;
  PagamentoModel({
    this.id,
    this.idCliente,
    this.dataPagamento,
    this.quantidade,
    this.valorSessao,
    this.valorTotal,
    this.observacoes,
  });

  PagamentoModel copyWith({
    int? id,
    int? idCliente,
    String? dataPagamento,
    int? quantidade,
    double? valorUnitario,
    double? valorTotal,
    String? observacoes,
  }) {
    return PagamentoModel(
      id: id ?? this.id,
      idCliente: idCliente ?? this.idCliente,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      quantidade: quantidade ?? this.quantidade,
      valorSessao: valorUnitario ?? this.valorSessao,
      valorTotal: valorTotal ?? this.valorTotal,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idCliente': idCliente,
      'dataPagamento': dataPagamento,
      'quantidade': quantidade,
      'valorSessao': valorSessao,
      'valorTotal': valorTotal,
      'observacoes': observacoes,
    };
  }

  factory PagamentoModel.fromMap(Map<String, dynamic> map) {
    return PagamentoModel(
      id: map['id'] != null ? map['id'] as int : null,
      idCliente: map['idCliente'] != null ? map['idCliente'] as int : null,
      dataPagamento: map['dataPagamento'] != null ? map['dataPagamento'] as String : null,
      quantidade: map['quantidade'] != null ? map['quantidade'] as int : null,
      valorSessao: map['valorSessao'] != null ? map['valorSessao'] as double : null,
      valorTotal: map['valorTotal'] != null ? map['valorTotal'] as double : null,
      observacoes: map['observacoes'] != null ? map['observacoes'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PagamentoModel.fromJson(String source) => PagamentoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PagamentoModel(id: $id, idCliente: $idCliente, dataPagamento: $dataPagamento, quantidade: $quantidade, valorSessao: $valorSessao, valorTotal: $valorTotal, observacoes: $observacoes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PagamentoModel &&
        other.id == id &&
        other.idCliente == idCliente &&
        other.dataPagamento == dataPagamento &&
        other.quantidade == quantidade &&
        other.valorSessao == valorSessao &&
        other.valorTotal == valorTotal &&
        other.observacoes == observacoes;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idCliente.hashCode ^ dataPagamento.hashCode ^ quantidade.hashCode ^ valorSessao.hashCode ^ valorTotal.hashCode ^ observacoes.hashCode;
  }
}
