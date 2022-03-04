import 'package:flutter/cupertino.dart';
import '../dao/custormer_dao.dart';
import '../utils/nav.dart';

import '../models/customer.dart';
import '../pages/customer_form_page.dart';

class CustomerController extends ChangeNotifier {
  final db;
  late CustomerDao customerDao;
  List<Customer> _list = [];

  CustomerController(this.db) {
    _readData();
  }

  _readData() async {
    customerDao = db.customerDao;
    _list = await customerDao.findAllCustomers();
    notifyListeners();
  }

  List<Customer> get list => _list;

  save(BuildContext context, Customer customer) {
    if (customer.id != null && customer.id! > 0) {
      customerDao.updateCustomer(customer);
    } else {
      customerDao.insertCustomer(customer);
    }

    _readData();
    Navigator.of(context).pop();
    notifyListeners();
  }

  void goToFormNew(BuildContext context) {
    Customer c = Customer.newInstance();
    goTo(context, CustomerFormPage(c));
  }

  void goToPageEdit(BuildContext context, Customer customer) {
    goTo(context, CustomerFormPage(customer));
  }

  void remove(BuildContext context, Customer customer) async {
//    _list.remove(customer);
    customerDao.deleteCustomer(customer);
    _readData();
    //Navigator.of(context).pop();
    notifyListeners();
  }
}
