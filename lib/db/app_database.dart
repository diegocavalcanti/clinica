import 'dart:async';

import 'package:floor/floor.dart';
import '../dao/atendimento_dao.dart';
import '../dao/cliente_dao.dart';
import '../models/atendimento_model.dart';
import '../models/atendimento_model_view.dart';
import '../models/cliente_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // the generated code will be there

@Database(
  version: 1,
  entities: [ClienteModel, AtendimentoModel],
  views: [AtendimentoView],
)
abstract class AppDatabase extends FloorDatabase {
  ClienteDao get clienteDao;
  AtendimentoDao get atendimentoDao;
}
