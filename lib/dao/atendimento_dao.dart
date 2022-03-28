import 'package:clinica/db/app_database.dart';
import 'package:sqflite/sqflite.dart';

import '../models/atendimento_model.dart';
import '../models/cliente_model.dart';

class AtendimentoDAO {
  final tableName = 'atendimentos';

  AppDatabase _connection = AppDatabase.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<AtendimentoModel> create(AtendimentoModel model) async {
    try {
      Database db = await _getDatabase();
      final id = await db.insert(tableName, model.toMap());
      return model.copyWith(id: id);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<int> update(AtendimentoModel model) async {
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

  Future<AtendimentoModel> findById(int id) async {
    try {
      Database db = await _getDatabase();

      final maps = await db.query(
        tableName,
        columns: ['id', 'idCliente', 'data', 'texto'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return AtendimentoModel.fromMap(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<AtendimentoModel>> findAll() async {
    try {
      Database db = await _getDatabase();
      //final result = await db.query(tableName, orderBy: orderBy);
      final result = await db.rawQuery('''SELECT A.*, C.nome as nomeCliente FROM Atendimentos A JOIN  Clientes C ON (C.id = A.idCliente) order by data ASC ''');
      return result.map((json) => AtendimentoModel.fromMap(json)).toList();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<AtendimentoModel>> findByCliente(ClienteModel clienteModel) async {
    try {
      Database db = await _getDatabase();
      //final result = await db.query(tableName, orderBy: orderBy);
      final result = await db.rawQuery(
          '''SELECT A.*, C.nome as nomeCliente FROM Atendimentos A JOIN  Clientes C ON (C.id = A.idCliente)  where A.idCliente = ? order by data ASC ''',
          [clienteModel.id]);
      return result.map((json) => AtendimentoModel.fromMap(json)).toList();
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
