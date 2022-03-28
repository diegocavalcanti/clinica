import 'package:floor/floor.dart';
import '../models/cliente_model.dart';

@dao
abstract class ClienteDao {
  @Query('SELECT * FROM Customer')
  Future<List<ClienteModel>> findAllClientes();

  @Query('SELECT * FROM Customer WHERE name like :name')
  Future<List<ClienteModel>> findClientesByName(String name);

  @Query('SELECT * FROM Customer WHERE id = :id')
  Future<ClienteModel?> findById(int id);

  @insert
  Future<void> insertCliente(ClienteModel customer);

  //@Query('DELETE FROM Customer WHERE id = :id')
  @delete
  Future<int> deleteCliente(ClienteModel customer);

  @update
  Future<int> updateCliente(ClienteModel customer);
}
