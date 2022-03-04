import 'dart:async';

import 'package:floor/floor.dart';
import '../dao/atendimento_dao.dart';
import '../dao/custormer_dao.dart';
import '../models/atendimento.dart';
import '../models/atendimento_view.dart';
import '../models/customer.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Customer, Atendimento], views: [AtendimentoView], )
abstract class AppDatabase extends FloorDatabase {
  CustomerDao get customerDao;
  AtendimentoDao get atendimentoDao;
}
