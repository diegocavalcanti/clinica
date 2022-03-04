// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinica/controllers/atendimento_controller.dart';
import 'package:clinica/models/atendimento.dart';
import 'package:flutter/material.dart';
import '../widgets/popup_menuitem_action.dart';
import 'package:provider/provider.dart';

import '../widgets/search_widget.dart';

class AtendimentoListPage extends StatelessWidget {
  const AtendimentoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AtendimentoController controller = Provider.of<AtendimentoController>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Atendimentos"),
          backgroundColor: Colors.blueGrey,
          actions: [IconButton(icon: Icon(Icons.calendar_month), onPressed: () async {})],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              controller.goToFormNew(context);
            }),
        body: Container(
          child: ListView.builder(
              itemCount: controller.listAtendimentosView.length,
              itemBuilder: (context, index) {
                var item = controller.listAtendimentosView[index];
                return ListTile(
                  // ignore: prefer_const_constructors
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(item.date),
                  subtitle: Row(
                    children: [
                      //tem que fazer um cast
                      Text(item.customer_id.toString()),
                      Text(item.customer_name)
                    ],
                  ),
                  onTap: () => controller.goToPageEdit(context, item.toEntity()),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: PopupMenuItemAction(action: () => controller.goToPageEdit(context, item.toEntity())),
                          child: Text('Editar'),
                        ),
                        PopupMenuItem(
                          value: PopupMenuItemAction(action: () => controller.remove(context, item.toEntity())),
                          child: Text('Excluir'),
                        )
                      ];
                    },
                    onSelected: (PopupMenuItemAction option) {
                      option.action();
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }

  void _opcoes(BuildContext context, Atendimento Atendimento) {
    AtendimentoController controller = Provider.of<AtendimentoController>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 180,
          child: Container(
            child: Column(
              children: [
                ListTile(leading: Icon(Icons.delete), title: Text("Excluir"), onTap: () => controller.remove(context, Atendimento)),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Editar"),
                  onTap: () => controller.goToPageEdit(context, Atendimento),
                ),
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
