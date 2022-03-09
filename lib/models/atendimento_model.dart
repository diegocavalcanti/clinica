// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity()
class AtendimentoModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String date;
  final int customer_id;
  final String text;



  AtendimentoModel({
    this.id,
    required this.date,
    required this.customer_id,
    required this.text,
  });

  static AtendimentoModel newInstance() {
    return AtendimentoModel(id: null, date: "", customer_id: 0, text: "");
  }

  AtendimentoModel copyWith({
    int? id,
    String? date,
    int? customer_id,
    String? text,
  }) {
    return AtendimentoModel(
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

  factory AtendimentoModel.fromMap(Map<String, dynamic> map) {
    return AtendimentoModel(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] as String,
      customer_id: map['customer_id'] as int,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AtendimentoModel.fromJson(String source) => AtendimentoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
