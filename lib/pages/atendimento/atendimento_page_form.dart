// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors

import 'package:clinica/store/app_store.dart';
import 'package:clinica/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class AtendimentoPageForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  AtendimentoPageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Atendimentos'), actions: [
        IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_form.currentState!.validate()) {
                _form.currentState?.save();
                store.saveAtendimento(context, store.atendimento);
                Navigator.of(context).pop();
              }
            })
      ]),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Consumer<AppStore>(builder: (context, store, child) {
          return Form(
              key: _form,
              child: ListView(
                children: [
                  fieldCliente(store),
                  SizedBox(height: 20),
                  fieldDate(context, store),
                  SizedBox(height: 20),
                  fieldText(store),
                ],
              ));
        }),
      ),
    );
  }

  Widget fieldCliente(AppStore store) {
    return TextFormField(
        readOnly: true,
        initialValue: store.atendimento.nomeCliente,
        decoration: InputDecoration(
          labelText: 'Cliente',
          hintText: '',
          border: const OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ));
  }

  // DropdownMenuItem<ClienteModel> buildDropdowMenuItem(ClienteModel model) {
  //   return DropdownMenuItem(child: Text(model.nome!));
  // }

  // Widget fieldCliente(AppStore store) {
  //   return DropdownButton<int>(
  //       value: store.atendimento.idCliente,
  //       onChanged: (value) {
  //         store.atendimento = store.atendimento.copyWith(idCliente: value);
  //       },
  //       items: getItens(store.listaClientes));
  // }

  // List<DropdownMenuItem<int>> getItens(List<ClienteModel> data) {
  //   List<DropdownMenuItem<int>> menuItems = data.map((e) => DropdownMenuItem(child: Text(e.nome!), value: e.id)).toList();
  //   menuItems.add(DropdownMenuItem(child: Text("Nenhum"), value: 0));
  //   return menuItems;
  // }

  Widget fieldDate(BuildContext context, AppStore store) {
    final TextEditingController _controllerDate = TextEditingController();
    _controllerDate.text = store.atendimento.data ?? '';

    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value == null || value.isEmpty ? 'Campo nome é obrigatório' : null,
        onSaved: (value) => store.atendimento = store.atendimento.copyWith(data: value),
        readOnly: true,
        controller: _controllerDate,
        inputFormatters: [
          MaskTextInputFormatter(mask: '##/##/#####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
        ],
        onTap: () async {
          final data = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime(DateTime.now().year + 1),
            locale: Locale('pt', 'BR'),
          );
          if (data != null) {
            _controllerDate.text = dateToDateStr(data);
          }
        },
        decoration: InputDecoration(
          labelText: 'Data',
          hintText: 'Informe a Data',
          border: const OutlineInputBorder(),
          prefixIcon: Icon(Icons.schedule),
        ));
  }

  Widget fieldText(AppStore store) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: (value) => store.atendimento = store.atendimento.copyWith(texto: value),
        initialValue: store.atendimento.texto,
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
