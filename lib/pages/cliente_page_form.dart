// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../controllers/cliente_controller.dart';

import 'package:get/get.dart';

class ClientePageForm extends StatefulWidget {
  @override
  State<ClientePageForm> createState() => _ClientePageFormState();
}

class _ClientePageFormState extends State<ClientePageForm> {
  final _form = GlobalKey<FormState>();

  TextEditingController formFieldName = TextEditingController();
  TextEditingController formFieldCel = TextEditingController();
  TextEditingController formFieldEmail = TextEditingController();
  TextEditingController formFieldResponsible = TextEditingController();
  TextEditingController formFieldComments = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //CustomerController controller = Provider.of<CustomerController>(context, listen: true);

    return Consumer<ClienteController>(builder: (context, controller, child) {
      //databind
      formFieldName.text = controller.cliente.name;
      formFieldCel.text = controller.cliente.cel;
      formFieldEmail.text = controller.cliente.email;
      formFieldResponsible.text = controller.cliente.responsible;
      formFieldComments.text = controller.cliente.comments;

      return Scaffold(
          appBar: AppBar(title: Text('Cadastro de Clientes'), actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    _form.currentState?.save();
                    controller.save(context, controller.cliente);
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
                      fieldName(controller),
                      SizedBox(height: 20),
                      fieldCel(controller),
                      SizedBox(height: 20),
                      fieldEmail(controller),
                      SizedBox(height: 20),
                      fieldResponsible(controller),
                    ],
                  ))));
    });
  }

  TextFormField fieldName(ClienteController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) => controller.cliente = controller.cliente.copyWith(name: value?.toUpperCase()),
      controller: formFieldName,
      decoration: InputDecoration(
        labelText: 'Nome',
        hintText: '',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      autofocus: false,
    );
  }

  TextFormField fieldCel(ClienteController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) => controller.cliente = controller.cliente.copyWith(cel: value),
      controller: formFieldCel,
      validator: (value) => GetUtils.isPhoneNumber(value!) ? null : 'Celular inválido',
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

  TextFormField fieldEmail(ClienteController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) => controller.cliente = controller.cliente.copyWith(email: value?.toLowerCase()),
      validator: (value) => GetUtils.isEmail(value!) ? null : 'Email inválido',
      controller: formFieldEmail,
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

  TextFormField fieldResponsible(ClienteController controller) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value) => controller.cliente = controller.cliente.copyWith(responsible: value),
      controller: formFieldResponsible,
      decoration: InputDecoration(
        labelText: 'Responsável',
        hintText: 'Informe o responsável quando Menor',
        border: const OutlineInputBorder(),
        prefixIcon: Icon(Icons.bedroom_parent),
      ),
      autofocus: false,
    );
  }
}
