import 'package:clinica/dao/custormer_dao.dart';
import 'package:flutter/cupertino.dart';
import '../dao/atendimento_dao.dart';
import '../db/app_database.dart';
import '../models/atendimento_view.dart';
import '../models/customer.dart';
import '../utils/nav.dart';

import '../models/atendimento.dart';
import '../pages/atendimento_form_page.dart';

class AtendimentoController extends ChangeNotifier {
  final AppDatabase db;
  late AtendimentoDao atendimentoDao;
  late Atendimento _atendimento;

  late CustomerDao customerDao;
  Atendimento get atendimento => _atendimento;
  List<Atendimento> _listAtendimentos = [];
  List<Customer> _listCustomer = [];
  List<AtendimentoView> _listAtendimentosView = [];

  List<Atendimento> get listAtendimentos => _listAtendimentos;
  List<Customer> get listCustomer => _listCustomer;
  List<AtendimentoView> get listAtendimentosView => _listAtendimentosView;

  void set atendimento(value) {
    _atendimento = value;
    //  notifyListeners();
  }

  AtendimentoController(this.db) {
    _atendimento = Atendimento.newInstance();
    atendimentoDao = db.atendimentoDao;
    customerDao = db.customerDao;
    _readData();
  }

  _readData() async {
    _listCustomer = await customerDao.findAllCustomers();
    _listAtendimentos = await atendimentoDao.findAllAtendimentos();
    _listAtendimentosView = await atendimentoDao.findAtendimentosView();
    notifyListeners();
  }

  save(BuildContext context, Atendimento Atendimento) {
    if (Atendimento.id == null) {
      atendimentoDao.insertAtendimento(Atendimento);
    } else {
      atendimentoDao.updateAtendimento(Atendimento);
    }

    _readData();
    Navigator.of(context).pop();
    notifyListeners();
  }

  void goToFormNew(BuildContext context) {
    _atendimento = Atendimento.newInstance();
    goTo(context, AtendimentoFormPage());
  }

  void goToPageEdit(BuildContext context, Atendimento atendimento) {
    _atendimento = atendimento;
    goTo(context, AtendimentoFormPage());
  }

  void remove(BuildContext context, Atendimento atendimento) async {
//    _list.remove(Atendimento);
    atendimentoDao.deleteAtendimento(atendimento);
    _readData();
    //Navigator.of(context).pop();
    notifyListeners();
  }
}
