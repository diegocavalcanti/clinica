import 'package:clinica/db/app_database.dart';
import 'package:clinica/models/pagamento_model.dart';
import 'package:sqflite/sqflite.dart';



class PagamentoDAO {
  final tableName = 'pagamentos';
  AppDatabase _connection = AppDatabase.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<PagamentoModel> create(PagamentoModel model) async {
    try {
      Database db = await _getDatabase();
      final id = await db.insert(tableName, model.toMap());
      return model.copyWith(id: id);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<int> update(PagamentoModel model) async {
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



  Future<PagamentoModel> findById(int id) async {
    try {
      Database db = await _getDatabase();

      final maps = await db.query(
        tableName,
        columns: [
          'id',
          'customer_id',
          'date',
          'email',
          'responsavel',
          'observacoes',
        ],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return PagamentoModel.fromMap(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<PagamentoModel>> findAll() async {
    try {
      Database db = await _getDatabase();
      final orderBy = 'nome ASC';
      final result = await db.query(tableName, orderBy: orderBy);
      return result.map((json) => PagamentoModel.fromMap(json)).toList();
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

  // Future<Contato> adicionar(Contato contato) async {
  //   try {
  //     Database db = await _getDatabase();
  //     int id = await db.rawInsert(ConnectionSQL.adicionarContato(contato));
  //     contato.id = id;
  //     return contato;
  //   } catch (error) {
  //     throw Exception();
  //   }
  // }

  // Future<bool> atualizar(Contato contato) async {
  //   try {
  //     Database db = await _getDatabase();
  //     int linhasAfetadas = await db.rawUpdate(ConnectionSQL.atualizarContato(contato));
  //     if (linhasAfetadas > 0) {
  //       return true;
  //     }
  //     return false;
  //   } catch (error) {
  //     throw Exception();
  //   }
  // }

  // Future<List<Contato>> selecionarTodos() async {
  //   try {
  //     Database db = await _getDatabase();
  //     List<Map> linhas = await db.rawQuery(ConnectionSQL.selecionarTodosOsContatos());
  //     List<Contato> contatos = Contato.fromSQLiteList(linhas);
  //     return contatos;
  //   } catch (error) {
  //     throw Exception();
  //   }
  // }

  // Future<bool> deletar(Contato contato) async {
  //   try {
  //     Database db = await _getDatabase();
  //     int linhasAfetadas = await db.rawUpdate(ConnectionSQL.deletarContato(contato));
  //     if (linhasAfetadas > 0) {
  //       return true;
  //     }
  //     return false;
  //   } catch (error) {
  //     throw Exception();
  //   }
  // }
}
