// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/atendimento_controller.dart';
import '../models/atendimento.dart';
import '../models/atendimento_view.dart';
import '../models/customer.dart';
import '../widgets/custom_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AtendimentoFormPage extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  final TextEditingController _typeAheadController = TextEditingController();

  AtendimentoFormPage();

  @override
  Widget build(BuildContext context) {
    AtendimentoController controller = Provider.of<AtendimentoController>(context, listen: true);

    _typeAheadController.text = controller.atendimento.customer_id.toString();

    return Scaffold(
        appBar: AppBar(title: Text('Cadastro de Clientes'), actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _form.currentState?.save();
                  controller.save(context, controller.atendimento);
                }
              })
        ]),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _form,
                child: ListView(
                  children: [
                    SafeArea(
                      child: Container(
                        child: TypeAheadFormField<Customer>(
                          hideSuggestionsOnKeyboardHide: false,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: this._typeAheadController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                              hintText: 'Cliente',
                            ),
                          ),
                          noItemsFoundBuilder: (context) => Container(
                            height: 100,
                            child: Center(
                              child: Text(
                                'No Users Found.',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return await controller.listCustomer;
                          },
                          transitionBuilder: (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          itemBuilder: (context, suggestion) {
                            //final customer = suggestion!;
                            return ListTile(
                              title: Text(suggestion.name),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            this._typeAheadController.text = suggestion.name;
                            controller.atendimento = controller.atendimento.copyWith(customer_id: suggestion.id);
                          },
                          //onSaved: (value) => controller.atendimento = controller.atendimento.copyWith(customer_id:  value!.id),
                          validator: (value) => value == null || value.isEmpty ? 'Campo Cliente é obrigatório' : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      label: 'Data',
                      hint: 'Informa a Data',
                      icon: Icons.person,
                      initialValue: controller.atendimento.date,
                      onChanged: (value) => controller.atendimento = controller.atendimento.copyWith(date: value),
                      onSaved: (value) => controller.atendimento = controller.atendimento.copyWith(date: value),
                      onValidator: (value) => value == null || value.isEmpty ? 'Campo nome é obrigatório' : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))));
  }
}
