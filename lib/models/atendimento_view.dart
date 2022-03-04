// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floor/floor.dart';

import 'package:clinica/models/atendimento.dart';

@DatabaseView('SELECT Atendimento.*,   Customer.name as customer_name FROM Atendimento JOIN  Customer ON (Atendimento.customer_id = Customer.id)',
    viewName: 'AtendimentoView')
class AtendimentoView {
  final int id;
  final String date;
  final int customer_id;
  final String text;
  final String customer_name;

  AtendimentoView({
    required this.id,
    required this.date,
    required this.customer_id,
    required this.text,
    required this.customer_name,
  });

  Atendimento toEntity() {
    return Atendimento(id: this.id, date: this.date, customer_id: this.customer_id, text: this.text);
  }
}
