// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AtendimentoModel {
  final int? id;
  final int? idCliente;
  final String? nomeCliente; //
  final String? data;
  final String? texto;
  AtendimentoModel({
    this.id,
    this.idCliente,
    this.nomeCliente,
    this.data,
    this.texto,
  });

  AtendimentoModel copyWith({
    int? id,
    int? idCliente,
    String? data,
    String? texto,
    String? nomeCliente,
  }) {
    return AtendimentoModel(
      id: id ?? this.id,
      idCliente: idCliente ?? this.idCliente,
      data: data ?? this.data,
      texto: texto ?? this.texto,
      nomeCliente: nomeCliente ?? this.nomeCliente,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idCliente': idCliente,
      'data': data,
      'texto': texto,
      //  'nomeCliente': nomeCliente,
    };
  }

  factory AtendimentoModel.fromMap(Map<String, dynamic> map) {
    return AtendimentoModel(
      id: map['id'] != null ? map['id'] as int : null,
      idCliente: map['idCliente'] as int,
      data: map['data'] as String,
      texto: map['texto'] as String,
      nomeCliente: map['nomeCliente'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtendimentoModel.fromJson(String source) => AtendimentoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AtendimentoModel(id: $id, idCliente: $idCliente, data: $data, texto: $texto, nomeCliente: $nomeCliente)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AtendimentoModel &&
        other.id == id &&
        other.idCliente == idCliente &&
        other.data == data &&
        other.texto == texto &&
        other.nomeCliente == nomeCliente;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idCliente.hashCode ^ data.hashCode ^ texto.hashCode ^ nomeCliente.hashCode;
  }
}
