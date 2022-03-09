import 'package:clinica/pages/cliente_page_view.dart';
import 'package:flutter/cupertino.dart';
import '../dao/cliente_dao.dart';
import '../utils/nav.dart';

import '../models/cliente_model.dart';
import '../pages/cliente_page_form.dart';

class ClienteController extends ChangeNotifier {
  final db;
  late ClienteDao clienteDao;
  List<ClienteModel> _list = [];

  var _cliente = ClienteModel.newInstance();

  ClienteController(this.db) {
    _readData();
  }

  ClienteModel get cliente => _cliente;

  void set cliente(value) {
    _cliente = value;
    notifyListeners();
  }

  _readData() async {
    clienteDao = db.clienteDao;
    _list = await clienteDao.findAllClientes();
    notifyListeners();
  }

  List<ClienteModel> get list => _list;

  save(BuildContext context, ClienteModel cliente) {
    if (cliente.id != null && cliente.id! > 0) {
      clienteDao.updateCliente(cliente);
    } else {
      clienteDao.insertCliente(cliente);
    }

    _readData();
    Navigator.of(context).pop();
    notifyListeners();
  }

  void goToFormNew(BuildContext context) {
    ClienteModel c = ClienteModel.newInstance();
    this.cliente = c;
    goTo(context, ClientePageForm());
  }

  void goToPageEdit(BuildContext context, ClienteModel cliente) {
    this.cliente = cliente;
    goTo(context, ClientePageForm());
  }

  void remove(BuildContext context, ClienteModel cliente) async {
//    _list.remove(cliente);
    clienteDao.deleteCliente(cliente);
    _readData();
    //Navigator.of(context).pop();
    notifyListeners();
  }

  goToPageView(BuildContext context, ClienteModel cliente) {
    this.cliente = cliente;
    goTo(context, ClientePageView());
  }
}
