// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClienteModel {
  final int? id;
  final String? nome;
  final String? celular;
  final String? email;
  final String? responsavel;
  final String? observacoes;
  ClienteModel({
    this.id,
    this.nome,
    this.celular,
    this.email,
    this.responsavel,
    this.observacoes,
  });

  ClienteModel copyWith({
    int? id,
    String? nome,
    String? celular,
    String? email,
    String? responsavel,
    String? observacoes,
  }) {
    return ClienteModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      responsavel: responsavel ?? this.responsavel,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'celular': celular,
      'email': email,
      'responsavel': responsavel,
      'observacoes': observacoes,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      celular: map['celular'] != null ? map['celular'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      responsavel: map['responsavel'] != null ? map['responsavel'] as String : null,
      observacoes: map['observacoes'] != null ? map['observacoes'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) => ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClienteModel(id: $id, nome: $nome, celular: $celular, email: $email, responsavel: $responsavel, observacoes: $observacoes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClienteModel &&
        other.id == id &&
        other.nome == nome &&
        other.celular == celular &&
        other.email == email &&
        other.responsavel == responsavel &&
        other.observacoes == observacoes;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ celular.hashCode ^ email.hashCode ^ responsavel.hashCode ^ observacoes.hashCode;
  }
}
