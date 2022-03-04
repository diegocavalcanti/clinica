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

  CustomerDao? _customerDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Customer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cel` TEXT NOT NULL, `email` TEXT NOT NULL, `responsible` TEXT NOT NULL, `comments` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Atendimento` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` TEXT NOT NULL, `customer_id` INTEGER NOT NULL, `text` TEXT NOT NULL)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `AtendimentoView` AS SELECT Atendimento.*,   Customer.name as customer_name FROM Atendimento JOIN  Customer ON (Atendimento.customer_id = Customer.id)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CustomerDao get customerDao {
    return _customerDaoInstance ??= _$CustomerDao(database, changeListener);
  }

  @override
  AtendimentoDao get atendimentoDao {
    return _atendimentoDaoInstance ??=
        _$AtendimentoDao(database, changeListener);
  }
}

class _$CustomerDao extends CustomerDao {
  _$CustomerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _customerInsertionAdapter = InsertionAdapter(
            database,
            'Customer',
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'cel': item.cel,
                  'email': item.email,
                  'responsible': item.responsible,
                  'comments': item.comments
                },
            changeListener),
        _customerUpdateAdapter = UpdateAdapter(
            database,
            'Customer',
            ['id'],
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'cel': item.cel,
                  'email': item.email,
                  'responsible': item.responsible,
                  'comments': item.comments
                },
            changeListener),
        _customerDeletionAdapter = DeletionAdapter(
            database,
            'Customer',
            ['id'],
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'cel': item.cel,
                  'email': item.email,
                  'responsible': item.responsible,
                  'comments': item.comments
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Customer> _customerInsertionAdapter;

  final UpdateAdapter<Customer> _customerUpdateAdapter;

  final DeletionAdapter<Customer> _customerDeletionAdapter;

  @override
  Future<List<Customer>> findAllCustomers() async {
    return _queryAdapter.queryList('SELECT * FROM Customer',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int?,
            name: row['name'] as String,
            cel: row['cel'] as String,
            email: row['email'] as String,
            responsible: row['responsible'] as String,
            comments: row['comments'] as String));
  }

  @override
  Stream<Customer?> findById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Customer WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int?,
            name: row['name'] as String,
            cel: row['cel'] as String,
            email: row['email'] as String,
            responsible: row['responsible'] as String,
            comments: row['comments'] as String),
        arguments: [id],
        queryableName: 'Customer',
        isView: false);
  }

  @override
  Future<void> insertCustomer(Customer customer) async {
    await _customerInsertionAdapter.insert(customer, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCustomer(Customer customer) {
    return _customerUpdateAdapter.updateAndReturnChangedRows(
        customer, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCustomer(Customer customer) {
    return _customerDeletionAdapter.deleteAndReturnChangedRows(customer);
  }
}

class _$AtendimentoDao extends AtendimentoDao {
  _$AtendimentoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _atendimentoInsertionAdapter = InsertionAdapter(
            database,
            'Atendimento',
            (Atendimento item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'customer_id': item.customer_id,
                  'text': item.text
                },
            changeListener),
        _atendimentoUpdateAdapter = UpdateAdapter(
            database,
            'Atendimento',
            ['id'],
            (Atendimento item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'customer_id': item.customer_id,
                  'text': item.text
                },
            changeListener),
        _atendimentoDeletionAdapter = DeletionAdapter(
            database,
            'Atendimento',
            ['id'],
            (Atendimento item) => <String, Object?>{
                  'id': item.id,
                  'date': item.date,
                  'customer_id': item.customer_id,
                  'text': item.text
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Atendimento> _atendimentoInsertionAdapter;

  final UpdateAdapter<Atendimento> _atendimentoUpdateAdapter;

  final DeletionAdapter<Atendimento> _atendimentoDeletionAdapter;

  @override
  Future<List<Atendimento>> findAllAtendimentos() async {
    return _queryAdapter.queryList('SELECT * from Atendimento',
        mapper: (Map<String, Object?> row) => Atendimento(
            id: row['id'] as int?,
            date: row['date'] as String,
            customer_id: row['customer_id'] as int,
            text: row['text'] as String));
  }

  @override
  Stream<Atendimento?> findById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Atendimento WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Atendimento(
            id: row['id'] as int?,
            date: row['date'] as String,
            customer_id: row['customer_id'] as int,
            text: row['text'] as String),
        arguments: [id],
        queryableName: 'Atendimento',
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
  Future<void> insertAtendimento(Atendimento atendimento) async {
    await _atendimentoInsertionAdapter.insert(
        atendimento, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAtendimento(Atendimento atendimento) {
    return _atendimentoUpdateAdapter.updateAndReturnChangedRows(
        atendimento, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAtendimento(Atendimento atendimento) {
    return _atendimentoDeletionAdapter.deleteAndReturnChangedRows(atendimento);
  }
}
