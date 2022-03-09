// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../controllers/atendimento_controller.dart';
import '../models/cliente_model.dart';

class AtendimentoPageForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final TextEditingController formFieldDate = TextEditingController();
  final TextEditingController formFieldCliente = TextEditingController();
  final TextEditingController formFieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //AtendimentoController controller = Provider.of<AtendimentoController>(context, listen: true);

    return Consumer<AtendimentoController>(builder: (context, controller, child) {
      formFieldDate.text = controller.atendimento.date;
      formFieldCliente.text = controller.atendimentoCustomer.name;
      formFieldText.text = controller.atendimento.text;

      return Scaffold(
          appBar: AppBar(title: Text('Atendimentos'), actions: [
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
                  fieldDate(controller),
                  SizedBox(height: 20),
                  fieldCustomer(controller),
                  SizedBox(height: 20),
                  fieldText(controller),
                ],
              ),
            ),
          ));
    });
  }

  TextFormField fieldDate(AtendimentoController controller) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value == null || value.isEmpty ? 'Campo nome é obrigatório' : null,
        onSaved: (value) => controller.atendimento = controller.atendimento.copyWith(date: value),
        controller: formFieldDate,
        inputFormatters: [
          MaskTextInputFormatter(mask: '##/##/#####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
        ],
        decoration: InputDecoration(
          labelText: 'Data',
          hintText: 'Informe a Data',
          border: const OutlineInputBorder(),
          prefixIcon: Icon(Icons.schedule),
        ));
  }

  TypeAheadFormField fieldCustomer(AtendimentoController controller) {
    return TypeAheadFormField<ClienteModel>(
        hideSuggestionsOnKeyboardHide: true,
        textFieldConfiguration: TextFieldConfiguration(
          controller: formFieldCliente,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            border: const OutlineInputBorder(),
            hintText: 'Selecione o Cliente',
            label: Text('Cliente'),
          ),
        ),
        noItemsFoundBuilder: (context) => SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Nenhum cliente selecionado',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
        suggestionsCallback: (pattern) => controller.burcarClientes(pattern),
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        itemBuilder: (context, suggestion) => ListTile(title: Text(suggestion.name)),
        onSuggestionSelected: (suggestion) {
          controller.atendimento = controller.atendimento.copyWith(customer_id: suggestion.id);
        });
  }

  fieldText(AtendimentoController controller) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: (value) => controller.atendimento = controller.atendimento.copyWith(text: value),
        controller: formFieldText,
        minLines: 5,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: 'Obsevações',
          hintText: '',
          border: const OutlineInputBorder(),
          prefixIcon: Icon(Icons.note),
        ));
  }
}
