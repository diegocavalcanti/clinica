import 'package:clinica/dao/cliente_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../dao/atendimento_dao.dart';
import '../db/app_database.dart';
import '../models/atendimento_model_view.dart';
import '../models/cliente_model.dart';
import '../utils/nav.dart';

import '../models/atendimento_model.dart';
import '../pages/atendimento_page_form.dart';

class AtendimentoController extends ChangeNotifier {
  final AppDatabase db;
  late AtendimentoDao atendimentoDao;
  late AtendimentoModel _atendimento;

  late ClienteModel _atendimentoCustomer = ClienteModel.newInstance();

  late ClienteDao customerDao;

  List<AtendimentoModel> _listAtendimentos = [];
  List<ClienteModel> _listCustomer = [];
  List<AtendimentoView> _listAtendimentosView = [];

  AtendimentoModel get atendimento => _atendimento;
  List<AtendimentoModel> get listAtendimentos => _listAtendimentos;
  List<ClienteModel> get listCustomer => _listCustomer;
  List<AtendimentoView> get listAtendimentosView => _listAtendimentosView;
  ClienteModel get atendimentoCustomer => _atendimentoCustomer;

  TextEditingController formFieldCustomer = TextEditingController();
  TextEditingController formFieldData = TextEditingController();

  AtendimentoController(this.db) {
    _atendimento = AtendimentoModel.newInstance();
    atendimentoDao = db.atendimentoDao;
    customerDao = db.clienteDao;
    _readData();
  }

  void set atendimento(value) {
    _atendimento = value;
    _updateBind();
  }

  Future<List<ClienteModel>> burcarClientes(String name) async {
    List<ClienteModel> clientes = await customerDao.findClientesByName('%' + name + '%');
    return clientes;
  }

  _updateBind() async {
    _atendimentoCustomer = (await customerDao.findById(_atendimento.customer_id))!;
    formFieldCustomer.text = atendimentoCustomer.name;
    formFieldData.text = atendimento.date;
    notifyListeners();
  }

  _readData() async {
    _listCustomer = await customerDao.findAllClientes();
    _listAtendimentos = await atendimentoDao.findAllAtendimentos();
    _listAtendimentosView = await atendimentoDao.findAtendimentosView();
    notifyListeners();
  }

  save(BuildContext context, AtendimentoModel Atendimento) {
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
    _atendimento = AtendimentoModel.newInstance();
    goTo(context, AtendimentoPageForm());
  }

  void goToPageEdit(BuildContext context, AtendimentoModel atendimentoEdit) {
    atendimento = atendimentoEdit;
    goTo(context, AtendimentoPageForm());
  }

  void remove(BuildContext context, AtendimentoModel atendimento) async {
//    _list.remove(Atendimento);
    atendimentoDao.deleteAtendimento(atendimento);
    _readData();
    //Navigator.of(context).pop();
    notifyListeners();
  }
}
