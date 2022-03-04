// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../controllers/customer_controller.dart';
import '../models/customer.dart';

class CustomerFormPage extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  Customer customer;
  CustomerFormPage(this.customer);

  @override
  Widget build(BuildContext context) {
    CustomerController controller = Provider.of<CustomerController>(context, listen: true);

    return Scaffold(
        appBar: AppBar(title: Text('Cadastro de Clientes'), actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _form.currentState?.save();
                  controller.save(context, customer);
                }
              })
        ]),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _form,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      label: 'Nome',
                      hint: 'Informe seu Nome',
                      icon: Icons.person,
                      initialValue: customer.name,
                      onChanged: (value) => customer = customer.copyWith(name: value),
                      onSaved: (value) => customer = customer.copyWith(name: value),
                      onValidator: (value) => value == null || value.isEmpty ? 'Campo nome é obrigatório' : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      label: 'Celular',
                      hint: 'Informe Celular',
                      icon: Icons.phone,
                      initialValue: customer.cel,
                      onChanged: (value) => customer = customer.copyWith(cel: value),
                      onSaved: (value) => customer = customer.copyWith(cel: value),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      label: 'Email',
                      hint: 'Informe Email',
                      icon: Icons.email,
                      initialValue: customer.email,
                      onChanged: (value) => customer = customer.copyWith(email: value),
                      onSaved: (value) => customer = customer.copyWith(email: value),
                      onValidator: (value) => (value != null && value.isNotEmpty && (!value.contains('@') || !value.contains('.'))) ? "email inválido" : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      label: 'Responsável',
                      icon: Icons.bedroom_parent,
                      hint: 'Informe o responável quando Menor',
                      initialValue: customer.responsible,
                      onChanged: (value) => customer = customer.copyWith(responsible: value),
                      onSaved: (value) => customer = customer.copyWith(responsible: value),
                    ),
                  ],
                ))));
  }
}
