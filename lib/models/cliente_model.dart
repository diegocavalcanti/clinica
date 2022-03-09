import 'dart:convert';
import 'package:floor/floor.dart';

@Entity()
class ClienteModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String cel;
  final String email;
  final String responsible;
  final String comments;

  ClienteModel({
    required this.id,
    required this.name,
    required this.cel,
    required this.email,
    required this.responsible,
    required this.comments,
  });

  ClienteModel copyWith({
    int? id,
    String? name,
    String? cel,
    String? email,
    String? responsible,
    String? comments,
  }) {
    return ClienteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cel: cel ?? this.cel,
      email: email ?? this.email,
      responsible: responsible ?? this.responsible,
      comments: comments ?? this.comments,
    );
  }

  static ClienteModel newInstance() {
    return ClienteModel(id: null, name: "", cel: "", email: "", responsible: "", comments: "");
  }

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, cel: $cel, email: $email, responsible: $responsible, comments: $comments)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cel': cel,
      'email': email,
      'responsible': responsible,
      'comments': comments,
    };
  }

  factory ClienteModel.fromMap(Map<String, dynamic> map) {
    return ClienteModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      cel: map['cel'] as String,
      email: map['email'] as String,
      responsible: map['responsible'] as String,
      comments: map['comments'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClienteModel.fromJson(String source) => ClienteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
