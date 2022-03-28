// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'package:clinica/dao/atendimento_dao.dart';
import 'package:clinica/models/atendimento_model.dart';

import '../dao/cliente_dao.dart';
import '../dao/pagamento_dao.dart';
import '../models/cliente_model.dart';
import '../models/pagamento_model.dart';

class AppStore extends ChangeNotifier {
  final AtendimentoDAO _atendimentoDAO = AtendimentoDAO();
  final ClienteDAO _clienteDAO = ClienteDAO();
  final PagamentoDAO _pagamentoDAO = PagamentoDAO();

  late ClienteModel _cliente = ClienteModel();
  late AtendimentoModel _atendimento = AtendimentoModel();

  int tabIndex = 0;

  List<AtendimentoModel> _listaAtendimentos = [];
  List<AtendimentoModel> _listaAtendimentosCliente = [];
  List<ClienteModel> _listaClientes = [];

  loadLists() async {
    _listaAtendimentos = await _atendimentoDAO.findAll(); //
    _listaClientes = await _clienteDAO.findAll();
    notifyListeners();
  }

  loadCliente(id) {
    _clienteDAO.findById(id);
  }

  Future<int> quantidadeAtendimentosCliente() async {
    List<AtendimentoModel> atendimentos = await _atendimentoDAO.findByCliente(_cliente);
    return atendimentos.length;
  }

  AtendimentoModel get atendimento => _atendimento;
  set atendimento(AtendimentoModel model) {
    _atendimento = model;
    notifyListeners();
  }

  ClienteModel get cliente => _cliente;
  set cliente(ClienteModel model) {
    _cliente = model;
    notifyListeners();
  }

  UnmodifiableListView<AtendimentoModel> get listaAtendimentos => UnmodifiableListView(_listaAtendimentos);
  UnmodifiableListView<ClienteModel> get listaClientes => UnmodifiableListView(_listaClientes);

  saveCliente(BuildContext context, ClienteModel model) async {
    if (model.id != null && model.id! > 0) {
      _clienteDAO.update(model);
    } else {
      _clienteDAO.create(model);
    }
    _listaClientes = await _clienteDAO.findAll();
    _cliente = model;
    notifyListeners();
  }

  Future<void> saveAtendimento(BuildContext context, AtendimentoModel model) async {
    if (model.id != null && model.id! > 0) {
      _atendimentoDAO.update(model);
    } else {
      _atendimentoDAO.create(model);
    }
    _listaAtendimentos = await _atendimentoDAO.findAll(); //
    notifyListeners();
  }

  Future<List<ClienteModel>> findAllClientes() {
    return _clienteDAO.findAll();
  }

  Future<List<AtendimentoModel>> findAtendimentosByCliente(ClienteModel clienteModel) {
    return _atendimentoDAO.findByCliente(clienteModel);
  }

  Future<List<PagamentoModel>> findPagamentosByCliente(ClienteModel clienteModel) {
    return _pagamentoDAO.findAll();
  }

  removeCliente(BuildContext context, ClienteModel cliente) async {
    _clienteDAO.delete(cliente.id!);
    _listaClientes = await _clienteDAO.findAll();
    notifyListeners();
  }

  removeAtendimento(BuildContext context, AtendimentoModel atendimento) async {
    _atendimentoDAO.delete(atendimento.id!);
    _listaAtendimentos = await _atendimentoDAO.findAll(); //
    notifyListeners();
  }
}
