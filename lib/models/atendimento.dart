// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity()
class Atendimento {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String date;
  final int customer_id;
  final String text;



  Atendimento({
    this.id,
    required this.date,
    required this.customer_id,
    required this.text,
  });

  static Atendimento newInstance() {
    return Atendimento(id: null, date: "", customer_id: 0, text: "");
  }

  Atendimento copyWith({
    int? id,
    String? date,
    int? customer_id,
    String? text,
  }) {
    return Atendimento(
      id: id ?? this.id,
      date: date ?? this.date,
      customer_id: customer_id ?? this.customer_id,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'customer_id': customer_id,
      'text': text,
    };
  }

  factory Atendimento.fromMap(Map<String, dynamic> map) {
    return Atendimento(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] as String,
      customer_id: map['customer_id'] as int,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Atendimento.fromJson(String source) => Atendimento.fromMap(json.decode(source) as Map<String, dynamic>);
}
