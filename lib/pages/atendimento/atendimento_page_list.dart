// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clinica/models/atendimento_model.dart';
import 'package:clinica/pages/atendimento/atendimento_page_form.dart';
import 'package:clinica/store/app_store.dart';
import 'package:clinica/utils/nav.dart';
import 'package:clinica/widgets/popup_menuitem_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AtendimentoPageList extends StatelessWidget {
  const AtendimentoPageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);

    //final store = context.watch<AppStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Atendimentos"),
          backgroundColor: Colors.blue,
          actions: [IconButton(icon: Icon(Icons.calendar_month), onPressed: () async {})],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              goTo(context, AtendimentoPageForm());
            }),
        body: Container(
            child: ListView.builder(
                itemCount: store.listaAtendimentos.length,
                itemBuilder: (context, index) {
                  var item = store.listaAtendimentos[index];
                  return ListTile(
                    // ignore: prefer_const_constructors
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text(item.data ?? ''),
                    subtitle: Row(
                      children: [
                        //tem que fazer um cast
                        Text(item.nomeCliente!)
                      ],
                    ),
                    onTap: () {
                      store.atendimento = item;
                      goTo(context, AtendimentoPageForm());
                    },
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: PopupMenuItemAction(action: () {
                              store.atendimento = item;
                              goTo(context, AtendimentoPageForm());
                            }),
                            child: Text('Editar'),
                          ),
                          PopupMenuItem(
                            value: PopupMenuItemAction(action: () {
                              store.atendimento = item;
                              goTo(context, AtendimentoPageForm());
                            }),
                            child: Text('Excluir'),
                          )
                        ];
                      },
                      onSelected: (PopupMenuItemAction option) {
                        option.action();
                      },
                    ),
                  );
                })),
      ),
    );
  }

  void _opcoes(BuildContext context, AppStore store, AtendimentoModel atendimento) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 180,
          child: Container(
            child: Column(
              children: [
                ListTile(leading: Icon(Icons.delete), title: Text("Excluir"), onTap: () => store.removeAtendimento(context, atendimento)),
                ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Editar"),
                    onTap: () {
                      store.atendimento = atendimento;
                      goTo(context, AtendimentoPageForm());
                    }),
              ],
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                )),
          ),
        );
      },
    );
  }

  Widget iconEditButton(Function() onPressed) {
    return IconButton(icon: Icon(Icons.edit), color: Colors.orange, onPressed: onPressed);
  }

  Widget iconRemoveButton(BuildContext context, Function() remove) {
    return IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Confirma a Exclusão?'),
                    actions: [
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: remove,
                      ),
                    ],
                  ));
        });
  }
}
