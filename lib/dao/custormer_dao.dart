import 'package:floor/floor.dart';
import '../models/customer.dart';

@dao
abstract class CustomerDao {
  @Query('SELECT * FROM Customer')
  Future<List<Customer>> findAllCustomers();

  @Query('SELECT * FROM Customer WHERE id = :id')
  Stream<Customer?> findById(int id);

  @insert
  Future<void> insertCustomer(Customer customer);

  //@Query('DELETE FROM Customer WHERE id = :id')
  @delete
  Future<int> deleteCustomer(Customer customer);

  @update
  Future<int> updateCustomer(Customer customer);
}
