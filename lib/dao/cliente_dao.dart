import 'package:clinica/db/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../models/cliente_model.dart';

class ClienteDAO {
  final tableName = 'clientes';
  AppDatabase _connection = AppDatabase.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<ClienteModel> create(ClienteModel model) async {
    try {
      Database db = await _getDatabase();
      final id = await db.insert(tableName, model.toMap());
      return model.copyWith(id: id);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<int> update(ClienteModel model) async {
    try {
      Database db = await _getDatabase();
      return db.update(
        tableName,
        model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
      );
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<ClienteModel> findById(int id) async {
    try {
      Database db = await _getDatabase();

      final maps = await db.query(
        tableName,
        columns: [
          'id',
          'nome',
          'celular',
          'email',
          'responsavel',
          'observacoes',
        ],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ClienteModel.fromMap(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<ClienteModel>> findAll() async {
    try {
      Database db = await _getDatabase();
      final orderBy = 'nome ASC';
      final result = await db.query(tableName, orderBy: orderBy);
      return result.map((json) => ClienteModel.fromMap(json)).toList();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<int> delete(int id) async {
    try {
      Database db = await _getDatabase();
      return await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (error) {
      throw Exception(error);
    }
  }

}
