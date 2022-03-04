import 'dart:convert';
import 'package:floor/floor.dart';

@Entity()
class Customer {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String cel;
  final String email;
  final String responsible;
  final String comments;

  Customer({
    required this.id,
    required this.name,
    required this.cel,
    required this.email,
    required this.responsible,
    required this.comments,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? cel,
    String? email,
    String? responsible,
    String? comments,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      cel: cel ?? this.cel,
      email: email ?? this.email,
      responsible: responsible ?? this.responsible,
      comments: comments ?? this.comments,
    );
  }

  static Customer newInstance() {
    return Customer(id: null, name: "", cel: "", email: "", responsible: "", comments: "");
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

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      cel: map['cel'] as String,
      email: map['email'] as String,
      responsible: map['responsible'] as String,
      comments: map['comments'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) => Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
