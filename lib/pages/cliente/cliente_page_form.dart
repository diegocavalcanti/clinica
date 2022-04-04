// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:clinica/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class ClientePageForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  ClientePageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Cadastro de Clientes'), actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_form.currentState!.validate()) {
                  _form.currentState?.save();
                  store.saveCliente(context, store.cliente);
                  Navigator.of(context).pop();
                }
              })
        ]),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _form,
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    fieldNome(store),
                    SizedBox(height: 20),
                    fieldCelular(store),
                    SizedBox(height: 20),
                    fieldEmail(store),
                    SizedBox(height: 20),
                    fieldResponsavel(store),
                    SizedBox(height: 20),
                    fieldObservacoes(store),
                  ],
                ))));
  }

  TextFormField fieldNome(AppStore store) {
    return TextFormField(
      autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: store.cliente.nome,
      onSaved: (value) => store.cliente = store.cliente.copyWith(nome: value?.toUpperCase()),
      validator: (value) => (value == null || value.isEmpty) ? 'Informe o Nome' : null,
      decoration: InputDecoration(
        labelText: 'Nome',
        hintText: '',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  TextFormField fieldCelular(AppStore store) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: store.cliente.celular,
      onSaved: (value) => store.cliente = store.cliente.copyWith(celular: value),
      validator: (value) {
        if (value == null || value == "") {
          return null;
        } else {
          if (GetUtils.isPhoneNumber(value)) {
            return null;
          } else {
            return 'Celular inválido';
          }
        }
      },
      keyboardType: TextInputType.phone,
      inputFormatters: [
        MaskTextInputFormatter(mask: '(##)#####-####', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy)
      ],
      decoration: InputDecoration(
        labelText: 'Celular',
        hintText: 'Celular',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      autofocus: false,
    );
  }

  TextFormField fieldEmail(AppStore store) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: store.cliente.email,
      onSaved: (value) => store.cliente = store.cliente.copyWith(email: value?.toLowerCase()),
      validator: (value) {
        if (value == null || value == "") {
          return null;
        } else {
          if (GetUtils.isEmail(value)) {
            return null;
          } else {
            return 'Email inválido';
          }
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Informe Email',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      autofocus: false,
    );
  }

  TextFormField fieldResponsavel(AppStore store) {
    return TextFormField(
      initialValue: store.cliente.responsavel,
      onSaved: (value) => store.cliente = store.cliente.copyWith(responsavel: value),
      decoration: InputDecoration(
        labelText: 'Responsável',
        hintText: 'Informe o responsável quando Menor',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.bedroom_parent),
      ),
      autofocus: false,
    );
  }

  TextFormField fieldObservacoes(AppStore store) {
    return TextFormField(
      initialValue: store.cliente.observacoes,
      onSaved: (value) => store.cliente = store.cliente.copyWith(observacoes: value),
      minLines: 5,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Observações',
        hintText: 'Outras informações',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.bedroom_parent),
      ),
      autofocus: false,
    );
  }
}
