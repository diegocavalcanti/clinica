// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ClienteDao? _clienteDaoInstance;

  AtendimentoDao? _atendimentoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ClienteModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cel` TEXT NOT NULL, `email` TEXT NOT NULL, `responsible` TEXT NOT NULL, `comments` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AtendimentoModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` TEXT NOT NULL, `customer_id` INTEGER NOT NULL, `text` TEXT NOT NULL)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `AtendimentoView` AS SELECT Atendimento.*,   Customer.name as customer_name FROM Atendimento JOIN  Customer ON (Atendimento.customer_id = Customer.id)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ClienteDao get clienteDao {
    return _clienteDaoInstance ??= _$ClienteDao(database, changeListener);
  }

  @override
  AtendimentoDao get atendimentoDao {
    return _atendimentoDaoInstance ??=
        _$AtendimentoDao(database, changeListener);
  }
}

class _$ClienteDao extends ClienteDao {
  _$ClienteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _clienteModelInsertionAdapter = InsertionAdapter(
            database,
            'ClienteModel',
            (ClienteModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'cel': item.cel,
                  'email': item.email,
                  'responsible': item.responsible,
                  'comments': item.comments
                }),
        _clienteModelUpdateAdapter = UpdateAdapter(
            database,
            'ClienteModel',
            ['id'],
            (ClienteModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'cel': item.cel,
                  'email': item.email,
                  'responsible': item.responsible,
                  'comments': item.comments
                }),
        _clienteModelDeletionAdapter = DeletionAdapter(
            database,
            'ClienteModel',
            ['id'],
            (ClienteModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'cel': item.cel,
                  'email': item.email,
                  'responsible': item.responsible,
                  'comments': item.comments
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ClienteModel> _clienteModelInsertionAdapter;

  final UpdateAdapter<ClienteModel> _clienteModelUpdateAdapter;

  final DeletionAdapter<ClienteModel> _clienteModelDeletionAdapter;

  @override
  Future<List<ClienteModel>> findAllClientes() async {
    return _queryAdapter.queryList('SELECT * FROM Customer',
        mapper: (Map<String, Object?> row) => ClienteModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            cel: row['cel'] as String,
            email: row['email'] as String,
            responsible: row['responsible'] as String,
            comments: row['comments'] as String));
  }

  @override
  Future<List<ClienteModel>> findClientesByName(String name) async {
    return _queryAdapter.queryList('SELECT * FROM Customer WHERE name like ?1',
        mapper: (Map<String, Object?> row) => ClienteModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            cel: row['cel'] as String,
            email: row['email'] as String,
            responsible: row['responsible'] as String,
            comments: row['comments'] as String),
        arguments: [name]);
  }

  @override
  Future<ClienteModel?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Customer WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ClienteModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            cel: row['cel'] as String,
            email: row['email'] as String,
            responsible: row['responsible'] as String,
            comments: row['comments'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCliente(ClienteModel customer) async {
    await _clienteModelInsertionAdapter.insert(
        customer, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCliente(ClienteModel customer) {
    return _clienteModelUpdateAdapter.updateAndReturnChangedRows(
        customer, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCliente(ClienteModel customer) {
    return _clienteModelDeletionAdapter.deleteAndReturnChangedRows(customer);
  }
}

class _$AtendimentoDao extends AtendimentoDao {
  _$AtendimentoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _atendimentoModelInsertionAdapter = InsertionAdapter(
            database,
            'AtendimentoModel',
            (AtendimentoModel item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'customer_id': item.customer_id,
                  'text': item.text
                },
            changeListener),
        _atendimentoModelUpdateAdapter = UpdateAdapter(
            database,
            'AtendimentoModel',
            ['id'],
            (AtendimentoModel item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'customer_id': item.customer_id,
                  'text': item.text
                },
            changeListener),
        _atendimentoModelDeletionAdapter = DeletionAdapter(
            database,
            'AtendimentoModel',
            ['id'],
            (AtendimentoModel item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'customer_id': item.customer_id,
                  'text': item.text
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AtendimentoModel> _atendimentoModelInsertionAdapter;

  final UpdateAdapter<AtendimentoModel> _atendimentoModelUpdateAdapter;

  final DeletionAdapter<AtendimentoModel> _atendimentoModelDeletionAdapter;

  @override
  Future<List<AtendimentoModel>> findAllAtendimentos() async {
    return _queryAdapter.queryList('SELECT * from Atendimento',
        mapper: (Map<String, Object?> row) => AtendimentoModel(
            id: row['id'] as int?,
            date: row['date'] as String,
            customer_id: row['customer_id'] as int,
            text: row['text'] as String));
  }

  @override
  Stream<AtendimentoModel?> findById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Atendimento WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AtendimentoModel(
            id: row['id'] as int?,
            date: row['date'] as String,
            customer_id: row['customer_id'] as int,
            text: row['text'] as String),
        arguments: [id],
        queryableName: 'AtendimentoModel',
        isView: false);
  }

  @override
  Future<List<AtendimentoView>> findAtendimentosView() async {
    return _queryAdapter.queryList(
        'SELECT Atendimento.*,   Customer.name as customer_name FROM Atendimento JOIN  Customer ON (Atendimento.customer_id = Customer.id)',
        mapper: (Map<String, Object?> row) => AtendimentoView(
            id: row['id'] as int,
            date: row['date'] as String,
            customer_id: row['customer_id'] as int,
            text: row['text'] as String,
            customer_name: row['customer_name'] as String));
  }

  @override
  Future<void> insertAtendimento(AtendimentoModel atendimento) async {
    await _atendimentoModelInsertionAdapter.insert(
        atendimento, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAtendimento(AtendimentoModel atendimento) {
    return _atendimentoModelUpdateAdapter.updateAndReturnChangedRows(
        atendimento, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAtendimento(AtendimentoModel atendimento) {
    return _atendimentoModelDeletionAdapter
        .deleteAndReturnChangedRows(atendimento);
  }
}
