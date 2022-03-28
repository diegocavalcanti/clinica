import 'dart:async';

import 'package:clinica/db/script.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDatabase {
  static const DATABASE_NAME = "clinica.db";
  static const DATABASE_VERSION = 2;

  AppDatabase._();

  static AppDatabase? _instance;

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  Database? _db;

  Future<Database> get db => _openDatabase();

  Future<Database> _openDatabase() async {
    sqfliteFfiInit();
    String databasePath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasePath, DATABASE_NAME);
    DatabaseFactory databaseFactory = databaseFactoryFfi;

    // ignore: prefer_conditional_assignment
    if (_db == null) {
      _db = await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
              onCreate: (db, DATABASE_VERSION) async {
                var batch = db.batch();
                batch.execute(sqlCreateTableCliente);
                batch.execute(sqlCreateTableAtendimentos);
                batch.execute(sqlCreateTablePagamentos);
                await batch.commit();
              },
              onOpen: (db) async {
                //var batch = db.batch();
                // batch.execute(sqlDropTableCliente);
                // batch.execute(sqlCreateTableCliente);
                // batch.execute(sqlDropTableAtendimentos);
                // batch.execute(sqlCreateTableAtendimentos);
                // batch.execute(sqlDropTablePagamentos);
                // batch.execute(sqlCreateTablePagamentos);
                //await batch.commit();
              },
              version: DATABASE_VERSION));
    }
    return _db!;
  }

  FutureOr<void> close() async {
    _db?.close();
  }
}
