import 'package:clinica/models/atendimento_view.dart';
import 'package:floor/floor.dart';
import '../models/atendimento.dart';

@dao
abstract class AtendimentoDao {
  @Query('SELECT * from Atendimento')
  Future<List<Atendimento>> findAllAtendimentos();

  @Query('SELECT * FROM Atendimento WHERE id = :id')
  Stream<Atendimento?> findById(int id);

  @insert
  Future<void> insertAtendimento(Atendimento atendimento);

  //@Query('DELETE FROM Atendimento WHERE id = :id')
  @delete
  Future<int> deleteAtendimento(Atendimento atendimento);

  @update
  Future<int> updateAtendimento(Atendimento atendimento);

  @Query('SELECT Atendimento.*,   Customer.name as customer_name FROM Atendimento JOIN  Customer ON (Atendimento.customer_id = Customer.id)')
  Future<List<AtendimentoView>> findAtendimentosView();
}
